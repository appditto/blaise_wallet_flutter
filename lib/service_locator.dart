import 'package:blaise_wallet_flutter/model/db/appdb.dart';
import 'package:blaise_wallet_flutter/network/ws_client.dart';
import 'package:blaise_wallet_flutter/util/pascal_util.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

/// Service locator that provides various singletons
GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<PascalUtil>(() => PascalUtil());
  sl.registerLazySingleton<Vault>(() => Vault());
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  sl.registerLazySingleton<DBHelper>(() => DBHelper());
  sl.registerLazySingleton<WSClient>(() => WSClient());
  sl.registerLazySingleton<Logger>(() => Logger());
}
