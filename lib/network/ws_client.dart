import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/constants.dart';
import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/subscribe_request.dart';
import 'package:blaise_wallet_flutter/network/model/request_item.dart';
import 'package:blaise_wallet_flutter/network/model/response/price_response.dart';
import 'package:blaise_wallet_flutter/network/model/response/subscribe_response.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:pascaldart/pascaldart.dart' as pd;

import 'package:web_socket_channel/io.dart';
import 'package:package_info/package_info.dart';
import 'package:logger/logger.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:synchronized/synchronized.dart';

// For running in isolate
Map decodeJson(dynamic src) {
  return json.decode(src);
}

// WSClient singleton
class WSClient {
  final Logger log = sl.get<Logger>();

  // For all requests we place them on a queue with expiry to be processed sequentially
  Queue<RequestItem> _requestQueue;

  // WS Client
  IOWebSocketChannel _channel;

  // WS connection status
  bool _isConnected;
  bool _isConnecting;
  bool suspended; // When the app explicity closes the connection

  // Lock instnace for synchronization
  Lock _lock;

  // Constructor
  WSClient() {
    _requestQueue = Queue();
    _isConnected = false;
    _isConnecting = false;
    suspended = false;
    _lock = Lock();
    initCommunication(unsuspend: true);
  }

  // Re-connect handling
  bool _isInRetryState = false;
  StreamSubscription<dynamic> reconnectStream;

  /// Retry up to once per 3 seconds
  Future<void> reconnectToService() async {
    if (_isInRetryState) {
      return;
    } else if (reconnectStream != null) {
      reconnectStream.cancel();
    }
    _isInRetryState = true;
    log.d("Retrying connection in 3 seconds...");
    Future<dynamic> delayed = new Future.delayed(new Duration(seconds: 3));
    delayed.then((_) {
      return true;
    });
    reconnectStream = delayed.asStream().listen((_) {
      log.d("Attempting connection to service");
      initCommunication(unsuspend: true);
      _isInRetryState = false;
    });
  }

  // Connect to server
  Future<void> initCommunication({bool unsuspend = false}) async {
    if (_isConnected || _isConnecting) {
      return;
    } else if (suspended && !unsuspend) {
      return;
    } else if (!unsuspend) {
      reconnectToService();
      return;
    }
    _isConnecting = true;
    try {
      var packageInfo = await PackageInfo.fromPlatform();

      _isConnecting = true;
      suspended = false;
      _channel = new IOWebSocketChannel
                      .connect(AppConstants.WS_API_URL,
                               headers: {
                                'X-Client-Version': packageInfo.buildNumber
                               });
      log.d("Connected to service");
      _isConnecting = false;
      _isConnected = true;
      EventTaxiImpl.singleton().fire(ConnStatusEvent(status: ConnectionStatus.CONNECTED));
      _channel.stream.listen(_onMessageReceived, onDone: connectionClosed, onError: connectionClosedError);
    } catch(e){
      log.e("Error from service ${e.toString()}", e);
      _isConnected = false;
      _isConnecting = false;
      EventTaxiImpl.singleton().fire(ConnStatusEvent(status: ConnectionStatus.DISCONNECTED));
    }
  }

  // Connection closed (normally)
  void connectionClosed() {
    _isConnected = false;
    _isConnecting = false;
    clearQueue();
    log.d("disconnected from service");
    // Send disconnected message
    EventTaxiImpl.singleton().fire(ConnStatusEvent(status: ConnectionStatus.DISCONNECTED));
  }

  // Connection closed (with error)
  void connectionClosedError(e) {
    _isConnected = false;
    _isConnecting = false;
    clearQueue();
    log.d("disconnected from service with error ${e.toString()}");
    // Send disconnected message
    EventTaxiImpl.singleton().fire(ConnStatusEvent(status: ConnectionStatus.DISCONNECTED));
  }

  // Close connection
  void reset({bool suspend = false}){
    suspended = suspend;
    if (_channel != null && _channel.sink != null) {
      _channel.sink.close();
      _isConnected = false;
      _isConnecting = false;
    }
  }

  // Send message
  Future<void> _send(String message) async {
    bool reset = false;
    try {
      if (_channel != null && _channel.sink != null && _isConnected) {
        _channel.sink.add(message);
      } else {
        reset = true; // Re-establish connection
      }
    } catch (e) {
      reset = true;
    } finally {
      if (reset) {
        // Reset queue item statuses
        _requestQueue.forEach((requestItem) {
          requestItem.isProcessing = false;
        });
        if (!_isConnecting && !suspended) {
          initCommunication();
        }
      }
    }
  }

  Future<void> _onMessageReceived(dynamic message) async {
    if (suspended) {
      return;
    }
    await _lock.synchronized(() async {
      _isConnected = true;
      _isConnecting = false;
      // TODO showing full length for debugging
      log.d(message);
      //log.d("Received ${message.length > 30 ? message.substring(0, 30) : message}");
      Map msg = await compute(decodeJson, message);
      // Determine response type
      if (msg.containsKey("subscribe") ||
          msg.containsKey("error") && msg.containsKey("currency")) {
        // Subscribe response
        SubscribeResponse resp = await compute(subscribeResponseFromJson, msg);
        // Post to callbacks
        EventTaxiImpl.singleton().fire(SubscribeEvent(response: resp));
      } else if (msg.containsKey("currency") && msg.containsKey("price") && msg.containsKey("btc")) {
        // Price info sent from server
        PriceResponse resp = PriceResponse.fromJson(msg);
        EventTaxiImpl.singleton().fire(PriceEvent(response: resp));
      } else if (msg.containsKey("block") && msg.containsKey("ophash")) {
        // Operation
        pd.PascalOperation op = pd.PascalOperation.fromJson(msg);
        EventTaxiImpl.singleton().fire(NewOperationEvent(operation: op));
      }
      return;
    });
  }

  /* Send Request */
  Future<void> sendRequest(BaseRequest request) async {
    // We don't care about order or server response in these requests
    log.d("sending ${json.encode(request.toJson())}");
    _send(await compute(encodeRequestItem, request));
  }

  /* Enqueue Request */
  void queueRequest(BaseRequest request) {
    log.d("requetest ${json.encode(request.toJson())}, q length: ${_requestQueue.length}");
    _requestQueue.add(new RequestItem(request));
  }

  /* Process Queue */
  Future<void> processQueue() async {
    await _lock.synchronized(() async {
      log.d("Request Queue length ${_requestQueue.length}");
      if (_requestQueue != null && _requestQueue.length > 0) {
        RequestItem requestItem = _requestQueue.first;
        if (requestItem != null && !requestItem.isProcessing) {
          if (!_isConnected && !_isConnecting && !suspended) {
            initCommunication();
            return;
          } else if (suspended) {
            return;
          }
          requestItem.isProcessing = true;
          String requestJson = await compute(encodeRequestItem, requestItem.request);
          log.d("Sending: $requestJson");
          await _send(requestJson);
        } else if (requestItem != null && (DateTime
            .now()
            .difference(requestItem.expireDt)
            .inSeconds > RequestItem.EXPIRE_TIME_S)) {
          pop();
          processQueue();
        }
      }
    });
  }

  // Queue Utilities
  void removeSubscribeFromQueue() {
    if (_requestQueue != null && _requestQueue.length > 0) {
      List<RequestItem> toRemove = new List();
      _requestQueue.forEach((requestItem) {
        if ((requestItem.request is SubscribeRequest)
              && !requestItem.isProcessing) {
          toRemove.add(requestItem);
        }
      });
      toRemove.forEach((requestItem) {
        _requestQueue.remove(requestItem);
      });
    }    
  }

  RequestItem pop() {
    return _requestQueue.length > 0 ? _requestQueue.removeFirst() : null;
  }

  RequestItem peek() {
    return _requestQueue.length > 0 ? _requestQueue.first : null;
  }
  
  /// Clear entire queue, except for AccountsBalancesRequest
  void clearQueue() {
    List<RequestItem> reQueue = List();
    _requestQueue.forEach((requestItem) {
    });
    _requestQueue.clear();
    // Re-queue requests
    reQueue.forEach((requestItem) {
      requestItem.isProcessing = false;
      _requestQueue.add(requestItem);
    });
  }

  Queue<RequestItem> get requestQueue => _requestQueue;
}