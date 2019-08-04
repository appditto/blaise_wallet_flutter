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

  String get copied {
    return Intl.message("Copied",
        desc: 'A button to inform the user that something has been copied',
        name: 'copied');
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

  String get copiedAddress {
    return Intl.message("Address Copied",
        desc: 'A button to inform the user that the address has been copied',
        name: 'copiedAddress');
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
    return Intl.message(
        "Welcome to Blaise Wallet. To begin, you can create a new private key or import one.",
        desc: 'A paragraph that greets the user in the initial opening',
        name: 'welcomeParagraph');
  }

  String get newKeySecurityParagraph {
    return Intl.message(
        "In the next screen, you'll see your new private key. It is a password to access your funds. It is crucial that you back it up and never share it with anyone.",
        desc:
            'A paragraph that explains what users should do with their new private key',
        name: 'newKeySecurityParagraph');
  }

  String get uninstallDisclaimerParagraph {
    return Intl.message(
        "If you lose your device or uninstall Blaise Wallet, you'll need your private key to recover your funds.",
        desc:
            'A paragraph that gives a security disclaimer about what happens if the wallet is uninstalled',
        name: 'uninstallDisclaimerParagraph');
  }

  String get newKeyParagraph {
    return Intl.message(
        "Below is your new wallet’s private key. It is crucial that you backup your private key and never store it as plaintext or a screenshot. We recommend writing it on a piece of paper and storing it offline.",
        desc:
            'A paragraph that explains what users should do with their new private key',
        name: 'newKeyParagraph');
  }

  String get newKeyConfirmParagraph {
    return Intl.message(
        "Are you sure that you have backed up your new wallet’s private key?",
        desc: 'A paragraph to confirm if the new private key is backed up',
        name: 'newKeyConfirmParagraph');
  }

  String get newWalletGreetingParagraph {
    return Intl.message(
        "Welcome to <colored>Blaise Wallet</colored>.\nYou can start by getting an account.",
        desc: 'A paragraph to greet the user when a new wallet is created',
        name: 'newWalletGreetingParagraph');
  }

  String get getAccountFirstParagraph {
    return Intl.message("There are 2 options for getting your first account",
        desc:
            'The first paragraph of the explanation for the process of getting an account',
        name: 'getAccountFirstParagraph');
  }

  String get getAccountSecondParagraph {
    return Intl.message(
        "1- You can get a free account using your phone number. <colored>Only 1 account per phone number is allowed.</colored>",
        desc:
            'The second paragraph of the explanation for the process of getting an account',
        name: 'getAccountSecondParagraph');
  }

  String get getAccountThirdParagraph {
    return Intl.message(
        "2- You can buy as many accounts as you want for <colored>%1 PASCAL (%2).</colored>",
        desc:
            'The third paragraph of the explanation for the process of getting an account',
        name: 'getAccountThirdParagraph');
  }

  String get enterPhoneNumberParagraph {
    return Intl.message("Enter your phone number below.",
        desc:
            'A paragraph that tells users to enter their phone number to the text field below',
        name: 'enterPhoneNumberParagraph');
  }

  String get enterConfirmationCodeParagraph {
    return Intl.message(
        "We have sent you a confirmation code, please enter it below.",
        desc:
            'A paragraph that tells users to enter the confirmation code to the text field below',
        name: 'enterConfirmationCodeParagraph');
  }

  String get borrowAccountParagraph {
    return Intl.message(
        "To buy an account, first you’ll need to borrow one for free. If you send at least <colored>1% PASCAL (%2)</colored> to the account in the following 7 days, the account will be yours and <colored>%1 PASCAL</colored> will be deducted from your balance automatically. Otherwise, it’ll return back to us at the end of 7 days and won’t belong to your wallet anymore.",
        desc:
            'A paragraph that explains the process of borrowing & buying an account',
        name: 'borrowAccountParagraph');
  }

  String get importKeyParagraph {
    return Intl.message("Enter your private key below.",
        desc:
            'A paragraph that tells the user to enter their private key to the text field below',
        name: 'importKeyParagraph');
  }

  // Settings Related Paragraphs
  String get changeDaemonParagraph {
    return Intl.message(
        "Enter an address to use a different Pascal daemon for RPC requests.",
        desc:
            'A paragraph that tells the user to enter a new daemon address below',
        name: 'changeDaemonParagraph');
  }

  String get backupKeyFirstParagraph {
    return Intl.message("You have 2 options for backing up your private key:",
        desc:
            'The first paragraph of the explanation for the process of backing up the private key',
        name: 'backupKeyFirstParagraph');
  }

  String get backupKeySecondParagraph {
    return Intl.message(
        "1- Encrypted, which means it is protected by a password.",
        desc:
            'The second paragraph of the explanation for the process of backing up the private key',
        name: 'backupKeySecondParagraph');
  }

  String get backupKeyThirdParagraph {
    return Intl.message(
        "2- Unencrypted, which means it is raw and not protected by a password.",
        desc:
            'The third paragraph of the explanation for the process of backing up the private key',
        name: 'backupKeyThirdParagraph');
  }

  String get backupKeyFourthParagraph {
    return Intl.message(
        "We recommend storing the unencrypted version offline, by writing it on a piece of paper. You can store the encrypted version on a password manager for your convenience.",
        desc:
            'The fourth paragraph of the explanation for the process of backing up the private key',
        name: 'backupKeyFourthParagraph');
  }

  String get encryptKeyParagraph {
    return Intl.message("Create a new password to encrypt your private key.",
        desc:
            'A paragraph that tells the user to create a new password to encrypt their key',
        name: 'encryptKeyParagraph');
  }

  String get backupEncryptedKeyFirstParagraph {
    return Intl.message(
        "Below is your encrypted private key. It is protected by a password. You can store it safely on a password manager for your convenience.",
        desc:
            'A paragraph that explains how an encrypted private key can be backed up',
        name: 'backupEncryptedKeyFirstParagraph');
  }

  String get backupEncryptedKeySecondParagraph {
    return Intl.message(
        "Since it is encrypted with your password, if you lose or forget your password, you won't be able to decrypt it and access your funds.",
        desc:
            'A paragraph that gives a disclaimer about what would happen in case the password that was used to encrypt the private key is lost or forgotten',
        name: 'backupEncryptedKeySecondParagraph');
  }

  String get backupUnencryptedKeyParagraph {
    return Intl.message(
        "Below is your unencrypted private key. <colored>It is not protected by a password, which means it is crucial that you store it somewhere safe and offline.</colored> We recommend writing it on a piece of paper.",
        desc:
            'A paragraph that explains the process of backing up the unencrypted private key',
        name: 'backupUnencryptedKeyParagraph');
  }

  String get publicKeyParagraph {
    return Intl.message(
        "Below is your public key. As the name suggests, it is intended to be shared publicly and prove that a particular operation belongs to your private key.",
        desc: 'A paragraph that explains what a public key is',
        name: 'publicKeyParagraph');
  }

  String get logoutFirstDisclaimerParagraph {
    return Intl.message(
        "<colored>Logging out will remove your private key and all Blaise related data from this device.</colored> If your private key is not backed up, you will never be able to access your funds again. If your private key is backed up, you have nothing to worry about.",
        desc:
            'The first part of the disclaimer that is shown when the user tries to log out.',
        name: 'logoutFirstDisclaimerParagraph');
  }

  String get logoutSecondDisclaimerParagraph {
    return Intl.message(
        "Are you sure that you've backed up your private key? <colored>As long as you've backed up your private key, you have nothing to worry about.</colored>",
        desc:
            'The second part of the disclaimer that is shown when the user tries to log out.',
        name: 'logoutSecondDisclaimerParagraph');
  }
  // Settings related paragraphs END

  // Operation Related Paragraphs
  String get sendingConfirmParagraph {
    return Intl.message("Confirm the transaction details to send.",
        desc:
            'A paragraph that tells the user to confirm the info below to send',
        name: 'sendingConfirmParagraph');
  }

  String get sentParagraph {
    return Intl.message("Transaction has been sent succesfully.",
        desc:
            'A paragraph that informs the user that the transaction has been sent succesfully',
        name: 'sentParagraph');
  }

  String get changeNameParagraph {
    return Intl.message("Enter a name below to change your account's name.",
        desc:
            'A paragraph that tells the user to enter a new account name below',
        name: 'changeNameParagraph');
  }

  String get changingNameParagraph {
    return Intl.message("Confirm your new account name to proceed.",
        desc: 'A paragraph that tells the user to confirm the new account name',
        name: 'changingNameParagraph');
  }

  String get changedNameParagraph {
    return Intl.message("Your account name has been changed successfully.",
        desc:
            'A paragraph that informs the user that the account name has been changed successfully',
        name: 'changedNameParagraph');
  }

  String get transferParagraph {
    return Intl.message(
        "Enter a public key below to transfer the ownership of this account to it.",
        desc:
            'A paragraph that tells the user to enter a public key to the text field below to transfer the ownership of the account',
        name: 'transferParagraph');
  }

  String get transfferingParagraph {
    return Intl.message(
        "Confirm the public key below to transfer the ownership of this account to it.",
        desc:
            'A paragraph that tells the user to confirm the public key below to proceed with the transfer',
        name: 'transfferingParagraph');
  }

  String get transferredParagraph {
    return Intl.message(
        "Your account has been transferred successfully to the public key below.",
        desc:
            'A paragraph that informs the user that the account transfer has been completed successfully',
        name: 'transferredParagraph');
  }

  String get listForSaleParagraph {
    return Intl.message(
        "Enter a price and an account that will be receiving the payment to list this account for sale.",
        desc:
            'A paragraph that tells the user to enter a price and a receiver account to list the account for sale',
        name: 'listForSaleParagraph');
  }

  String get listingForSaleParagraph {
    return Intl.message(
        "Confirm the price and the account that will be receiving the payment.",
        desc:
            'A paragraph that tells the user to confirm the price and the receiver account',
        name: 'listingForSaleParagraph');
  }

  String get listedForSaleParagraph {
    return Intl.message(
        "Your account has been successfully listed for sale. We’ll let you know if someone buys it.",
        desc:
            'A paragraph that informs the user that the account has been listed for sale successfully',
        name: 'listedForSaleParagraph');
  }

  String get createPrivateSaleParagraph {
    return Intl.message(
        "Enter a price, a receiving account, and a public key below to create a private sale for this account.",
        desc:
            'A paragraph that tells the user to enter a price, a receiver account, and a public key to create a private sale for the account',
        name: 'createPrivateSaleParagraph');
  }

  String get creatingPrivateSaleParagraph {
    return Intl.message("Confirm the information below.",
        desc:
            'A paragraph that tells the user to confirm the information below.',
        name: 'creatingPrivateSaleParagraph');
  }

  String get createdPrivateSaleParagraph {
    return Intl.message(
        "The private sale has been created successfully. We’ll let you know if it is bought.",
        desc:
            'A paragraph that informs the user that the private sale has been created successfully',
        name: 'createdPrivateSaleParagraph');
  }

  String get delistFromSaleParagraph {
    return Intl.message(
        "Confirm that you would like to delist this account from sale.",
        desc:
            'A paragraph that tells the users to confirm that they would like to delist the account from sale.',
        name: 'delistFromSaleParagraph');
  }

  String get delistedFromSaleParagraph {
    return Intl.message(
        "Your account has been successfully delisted from sale.",
        desc:
            'A paragraph that informs the user that the account has been delisted from sale successfully',
        name: 'delistedFromSaleParagraph');
  }
  // Operation Related Paragraphs END

  String get feeRequiredParagraph {
    return Intl.message("This operation requires a fee.",
        desc: 'A paragraph to indicate that the operation requires a fee',
        name: 'feeRequiredParagraph');
  }

  String get feeConfirmAmountParagraph {
    return Intl.message(
        "Please confirm the addition of 0.0001 PASC fee to this operation to continue.",
        desc: 'A paragraph to tell the user to confirm the addition of a fee',
        name: 'feeSecondParagraph');
  }

  // PIN Screen
  String get enterPINToUnlockParagraph {
    return Intl.message("Enter PIN to Unlock Blaise",
        desc:
            'A paragraph that tells the user to enter the PIN to unlock the wallet',
        name: 'enterPINToUnlockParagraph');
  }

  String get authenticateToUnlockParagraph {
    return Intl.message("Authenticate to Unlock Blaise",
        desc:
            'A paragraph that tells the user to authenticate to unlock the wallet',
        name: 'authenticateToUnlockParagraph');
  }

  String get manyFailedAttemptsParagraph {
    return Intl.message("Too many failed unlock attempts",
        desc:
            'A paragraph to inform the user that there was too many failed unlock attempts',
        name: 'manyFailedAttemptsParagraph');
  }

  String get authenticateToChangeNameParagraph {
    return Intl.message("Authenticate to change account name to \"%1\"",
        desc:
            'A paragraph that tells the user to authenticate to change the name of the account',
        name: 'authenticateToChangeNameParagraph');
  }

  String get authenticateToDelistParagraph {
    return Intl.message("Authenticate to change account name to \"%1\"",
        desc:
            'A paragraph that tells the user to authenticate to delist the account from sale',
        name: 'authenticateToDelistParagraph');
  }
  String get authenticateToListForSaleParagraph {
    return Intl.message("Authenticate to list account for sale",
        desc:
            'A paragraph that tells the user to authenticate to list the account for sale',
        name: 'authenticateToListForSaleParagraph');
  }
  String get authenticateToCreatePrivateSaleParagraph {
    return Intl.message("Authenticate to create private sale",
        desc:
            'A paragraph that tells the user to authenticate to create a private sale for the account',
        name: 'authenticateToCreatePrivateSaleParagraph');
  }
  String get authenticateToTransferParagraph {
    return Intl.message("Authenticate to transfer account",
        desc:
            'A paragraph that tells the user to authenticate to transfer the ownership of the account',
        name: 'authenticateToTransferParagraph');
  }
  String get authenticateToSendParagraph {
    return Intl.message("Authenticate to send %1 Pascal",
        desc:
            'A paragraph that tells the user to authenticate to send a specified amount of Pascal',
        name: 'authenticateToSendParagraph');
  }
  String get authenticateToBackUpParagraph {
    return Intl.message("Authenticate to back up private key",
        desc:
            'A paragraph that tells the user to authenticate to back up the private key',
        name: 'authenticateToBackupParagraph');
  }
  String get invalidPINParagraph {
    return Intl.message("Invalid PIN",
        desc:
            'A paragraph that tells the user that the entered PIN is invalid',
        name: 'invalidPINParagraph');
  }
  String get noMatchPINParagraph {
    return Intl.message("PINs do not match",
        desc:
            'A paragraph that tells the user that the entered PINs do not match',
        name: 'noMatchPINParagraph');
  }
  String get confirmPINParagraph {
    return Intl.message("Confirm your PIN",
        desc:
            'A paragraph that tells the user to confirm the PIN',
        name: 'confirmPINParagraph');
  }
  String get enterPINParagraph {
    return Intl.message("Enter PIN",
        desc:
            'A paragraph that tells the user to enter the PIN',
        name: 'enterPINParagraph');
  }
  String get createPINParagraph {
    return Intl.message("Create a 6-digit PIN",
        desc:
            'A paragraph that tells the user to create a PIN',
        name: 'createPINParagraph');
  }
  // PIN Screen END

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
