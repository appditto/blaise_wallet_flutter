# Blaise - Simple, Sleek & Secure PASCAL Wallet

[![GitHub release (latest)](https://img.shields.io/github/v/release/appditto/blaise_wallet_flutter)](https://github.com/appditto/blaise_wallet_flutter/releases) [![License](https://img.shields.io/github/license/appditto/blaise_wallet_flutter)](https://github.com/appditto/blaise_wallet_flutter/blob/master/LICENSE) [[![CI](https://github.com/appditto/blaise_wallet_flutter/workflows/CI/badge.svg)](https://github.com/appditto/blaise_wallet_flutter/actions?query=workflow%3ACI) [![Twitter Follow](https://img.shields.io/twitter/follow/Appditto?style=social)](https://twitter.com/intent/follow?screen_name=Appditto)

## What is Blaise?
![Blaise Hero](https://blaisewallet.com/assets/hero-mockup.png)

Blaise is a cross-platform mobile wallet for the PASCAL cryptocurrency. It is written in Dart using [Flutter](https://flutter.io).

![Blaise Borrow](https://blaisewallet.com/assets/blaise-borrow.gif) ![Blaise Send](https://blaisewallet.com/assets/blaise-send.gif)


Private keys are stored on the device and never transmitted to the server. Signing and other low-level operations are performed using [PascalDart](https://pub.dev/packages/pascaldart)

| Link | Description |
| :----- | :------ |
[blaisewallet.com](https://blaisewallet.com) | Blaise Homepage
[pascalcoin.org](https://pascalcoin.org) | PACAL Cryptocurrency Homepage
[appditto.com](https://appditto.com) | Appditto Homepage

## Server

Blaise can interact with any PascalCoin Daemon, a high-performance Python server is used for push notifications, periodic price updates, and the PASA purchase APIs.

Blaise's backend server source code can be found [here](https://github.com/appditto/blaise_wallet_server)

## Contributing

* Fork the repository and clone it to your local machine
* Follow the instructions [here](https://flutter.io/docs/get-started/install) to install the Flutter SDK
* Setup [Android Studio](https://flutter.io/docs/development/tools/android-studio) or [Visual Studio Code](https://flutter.io/docs/development/tools/vs-code).

## Building

Android: `flutter build apk`
iOS: `flutter build ios`

If you have a connected device or emulator you can run and deploy the app with `flutter run`

## Have a question?

If you need any help, feel free to file an issue if you do not manage to find a solution.

## License

Blaise is released under the MIT License

### Update translations

```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localization.dart
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n \
   --no-use-deferred-loading lib/localization.dart lib/l10n/intl_*.arb
```
