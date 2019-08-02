import 'dart:async';

import 'package:blaise_wallet_flutter/model/available_languages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:natrium_wallet_flutter/model/available_language.dart';

import 'l10n/messages_all.dart';

/// Localization
class AppLocalization {
  static Locale currentLocale = Locale('en', 'US');

  static Future<AppLocalization> load(Locale locale) {
    currentLocale = locale;
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  /// -- GENERIC ITEMS
  String get translatableString {
    return Intl.message('Hi, I\'m a translatable string',
        desc: 'sample', name: 'translatableString');
  }

  String get systemDefault {
    return Intl.message("System Default",
        desc: 'settings_default_language_string', name: 'systemDefault');
  }

  // **** BUTTONS **** //
  String get newPrivateKey {
    return Intl.message("New Private Key",
        desc: 'A button that creates a new private key', name: 'newPrivateKey');
  }

  String get importPrivateKey {
    return Intl.message("Import Private Key",
        desc: 'A button that imports a private key', name: 'importPrivateKey');
  }

  String get gotIt {
    return Intl.message("Got It!",
        desc: 'A button that implies a message is understood', name: 'gotIt');
  }

  String get goBack {
    return Intl.message("Go Back",
        desc: 'A button to go back to previous screen', name: 'goBack');
  }

  String get copy {
    return Intl.message("Copy",
        desc: 'A button to copy something', name: 'copy');
  }

  String get iHaveBackedItUp {
    return Intl.message("I've Backed It Up",
        desc: 'A button to confirm that something is backed up',
        name: 'iHaveBackedItUp');
  }

  String get yesImSure {
    return Intl.message("Yes, I'm Sure",
        desc: 'A button to confirm if the user is sure', name: 'yesImSure');
  }

  String get noGoBack {
    return Intl.message("No, Go Back",
        desc:
            'A button to go back to previous screen if the user didnt do what the question asks',
        name: 'noGoBack');
  }

  String get getAnAccount {
    return Intl.message("Get an Account",
        desc: 'A button to start the process of getting an account',
        name: 'getAnAccount');
  }

  String get getAFreeAccount {
    return Intl.message("Get a Free Account",
        desc: 'A button to start the process of getting a free account',
        name: 'getAFreeAccount');
  }

  String get buyAnAccount {
    return Intl.message("Buy an Account",
        desc: 'A button to start the process of buying an account',
        name: 'buyAnAccount');
  }

  String get sendConfirmation {
    return Intl.message("Send Confirmation",
        desc: 'A button to request a confirmation to be sent',
        name: 'sendConfirmation');
  }

  String get confirm {
    return Intl.message("Confirm",
        desc: 'A button to confirm that a process should be executed',
        name: 'confirm');
  }

  String get borrowAnAccount {
    return Intl.message("Borrow An Account",
        desc: 'A button to borrow an account', name: 'borrowAnAccount');
  }

  String get import {
    return Intl.message("Import",
        desc: 'A button to import something', name: 'import');
  }

  String get receive {
    return Intl.message("Receive",
        desc: 'A button to receive Pascal', name: 'receive');
  }

  String get send {
    return Intl.message("Send", desc: 'A button to send Pascal', name: 'send');
  }

  String get copyAddress {
    return Intl.message("Copy Address",
        desc: 'A button to copy an address', name: 'copyAddress');
  }

  String get addToContacts {
    return Intl.message("Add to Contacts",
        desc: 'A button to add an account to contacts', name: 'addToContacts');
  }

  String get operationDetails {
    return Intl.message("Operation Details",
        desc: 'A button to view the details of an operation',
        name: 'operationDetails');
  }

  String get openInExplorer {
    return Intl.message("Open in Explorer",
        desc:
            'A button to view the details of an operation on the Pascal explorer',
        name: 'openInExplorer');
  }

  String get request {
    return Intl.message("Request",
        desc: 'A button to request something', name: 'request');
  }

  String get addAPayload {
    return Intl.message("Add a Payload",
        desc: 'A button to add a payload (note) to an operation',
        name: 'addAPayload');
  }

  String get scanQRCode {
    return Intl.message("Scan QR Code",
        desc: 'A button to scan a QR Code', name: 'scanQRCode');
  }

  String get cancel {
    return Intl.message("Cancel",
        desc: 'A button to cancel a process', name: 'cancel');
  }

  String get close {
    return Intl.message("Close",
        desc: 'A button to close a screen or a pop-up', name: 'close');
  }

  String get changeName {
    return Intl.message("Change Name",
        desc: 'A button to change the name of an account', name: 'changeName');
  }

  String get transfer {
    return Intl.message("Transfer",
        desc: 'A button to transfer the ownership of an account',
        name: 'transfer');
  }

  String get listForSale {
    return Intl.message("List for Sale",
        desc: 'A button to list an account for sale', name: 'listForSale');
  }

  String get createPrivateSale {
    return Intl.message("Create Private Sale",
        desc: 'A button to create a private sale for the account',
        name: 'createPrivateSale');
  }

  String get yesAddFee {
    return Intl.message("Yes, Add Fee",
        desc: 'A button to confirm the addition of a fee to an operation',
        name: 'yesAddFee');
  }

  String get unlock {
    return Intl.message("Unlock",
        desc: 'A button to unlock the wallet', name: 'unlock');
  }

  String get unlockWithBiometrics {
    return Intl.message("Unlock with Biometrics",
        desc: 'A button to unlock the wallet using biometrics',
        name: 'unlockWithBiometrics');
  }

  String get unlockWithPIN {
    return Intl.message("Unlock with PIN",
        desc: 'A button to unlock the wallet using PIN', name: 'unlockWithPIN');
  }

  String get setToDefault {
    return Intl.message("Set to Default",
        desc: 'A button to set something to its default', name: 'setToDefault');
  }

  String get changeDaemon {
    return Intl.message("Change Daemon",
        desc: 'A button to change the Pascal daemon for RPC requests',
        name: 'changeDaemon');
  }

  String get addContact {
    return Intl.message("Add Contact",
        desc: 'A button to add a contact', name: 'addContact');
  }

  String get encryptedKey {
    return Intl.message("Encrypted Key",
        desc: 'A button to view the encrypted key', name: 'encryptedKey');
  }

  String get unencryptedKey {
    return Intl.message("Unencrypted Key",
        desc: 'A button to view the unencrypted key', name: 'unencryptedKey');
  }

  String get encrypt {
    return Intl.message("Encrypt",
        desc: 'A button to view the unencrypted key', name: 'encrypt');
  }

  String get show {
    return Intl.message("Show",
        desc: 'A button to show something that is hidden', name: 'show');
  }

  String get hide {
    return Intl.message("Hide",
        desc: 'A button to hide something that is shown', name: 'hide');
  }

  String get copyEncryptedKey {
    return Intl.message("Copy Encrypted Key",
        desc: 'A button to copy an encrypted key', name: 'copyEncryptedKey');
  }

  String get copyUnencryptedKey {
    return Intl.message("Copy Unencrypted Key",
        desc: 'A button to copy an unencrypted key',
        name: 'copyUnencryptedKey');
  }

  String get copyKey {
    return Intl.message("Copy Key",
        desc: 'A button to copy a key (private or public key)',
        name: 'copyKey');
  }

  String get copyPublicKey {
    return Intl.message("Copy Public Key",
        desc: 'A button to copy a public key', name: 'copyPublicKey');
  }

  String get deletePrivateKeyAndLogout {
    return Intl.message("Delete Private Key\nAnd Logout",
        desc: 'A button to delete the private key and logout',
        name: 'deletePrivateKeyAndLogout');
  }
  // **** BUTTONS END **** //

  // **** PARAGRAPHS **** //
  String get welcomeParagraph {
    return Intl.message("Welcome to Blaise Wallet. To begin, you can create a new private key or import one.",
        desc: 'A paragraph that greets the user in the initial opening',
        name: 'welcomeParagraph');
  }

  String get newKeySecurityParagraph {
    return Intl.message("In the next screen, you'll see your new private key. It is a password to access your funds. It is crucial that you back it up and never share it with anyone.",
        desc: 'A paragraph that explains what users should do with their new private key',
        name: 'newKeySecurityParagraph');
  }

  String get uninstallDisclaimerParagraph {
    return Intl.message("If you lose your device or uninstall Blaise Wallet, you'll need your private key to recover your funds.",
        desc: 'A paragraph that gives a security disclaimer about what happens if the wallet is uninstalled',
        name: 'uninstallDisclaimerParagraph');
  }

  String get newKeyParagraph {
    return Intl.message("Below is your new wallet’s private key. It is crucial that you backup your private key and never store it as plaintext or a screenshot. We recommend writing it on a piece of paper and storing it offline.",
        desc: 'A paragraph that explains what users should do with their new private key',
        name: 'newKeyParagraph');
  }

  String get newKeyConfirmParagraph {
    return Intl.message("Are you sure that you have backed up your new wallet’s private key?",
        desc: 'A paragraph to confirm if the new private key is backed up',
        name: 'newKeyConfirmParagraph');
  }

  String get newWalletGreetingParagraph {
    return Intl.message("Welcome to <colored>Blaise Wallet</colored>.\nYou can start by getting an account.",
        desc: 'A paragraph to greet the user when a new wallet is created',
        name: 'newWalletGreetingParagraph');
  }

  String get getAccountFirstParagraph {
    return Intl.message("There are 2 options for getting your first account\n\n",
        desc: 'The first paragraph of the explanation for the process of getting an account',
        name: 'getAccountFirstParagraph');
  }

  String get getAccountSecondParagraph {
    return Intl.message("1- You can get a free account using your phone number. <colored>Only 1 account per phone number is allowed.</colored>\n\n",
        desc: 'The second paragraph of the explanation for the process of getting an account',
        name: 'getAccountSecondParagraph');
  }

  String get getAccountThirdParagraph {
    return Intl.message("2- You can buy as many accounts as you want for <colored>%1 PASCAL (%2).</colored>",
        desc: 'The third paragraph of the explanation for the process of getting an account',
        name: 'getAccountThirdParagraph');
  }

  String get enterPhoneNumberParagraph {
    return Intl.message("Enter your phone number below.",
        desc: 'A paragraph that tells users to enter their phone number to the text field below',
        name: 'enterPhoneNumberParagraph');
  }

  String get enterConfirmationCodeParagraph {
    return Intl.message("We have sent you a confirmation code, please enter it below.",
        desc: 'A paragraph that tells users to enter the confirmation code to the text field below',
        name: 'enterConfirmationCodeParagraph');
  }

  String get borrowAccountParagraph {
    return Intl.message("To buy an account, first you’ll need to borrow one for free. If you send at least <colored>1% PASCAL (%2)</colored> to the account in the following 7 days, the account will be yours and <colored>%1 PASCAL</colored> will be deducted from your balance automatically. Otherwise, it’ll return back to us at the end of 7 days and won’t belong to your wallet anymore.",
        desc: 'A paragraph that explains the process of borrowing & buying an account',
        name: 'borrowAccountParagraph');
  }
  // **** PARAGRAPHS END **** //

  String get onStr {
    return Intl.message("On", desc: "On", name: "onStr");
  }

  String get offStr {
    return Intl.message("Off", desc: "Off", name: "offStr");
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  final LanguageSetting languageSetting;

  const AppLocalizationsDelegate(this.languageSetting);

  @override
  bool isSupported(Locale locale) {
    return languageSetting != null;
  }

  @override
  Future<AppLocalization> load(Locale locale) {
    if (languageSetting.language == AvailableLanguage.DEFAULT) {
      return AppLocalization.load(locale);
    }
    return AppLocalization.load(Locale(languageSetting.getLocaleString()));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return true;
  }
}
