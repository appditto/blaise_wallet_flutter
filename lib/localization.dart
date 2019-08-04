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
  String get newPrivateKeyButton {
    return Intl.message("New Private Key",
        desc: 'A button that creates a new private key',
        name: 'newPrivateKeyButton');
  }

  String get importPrivateKeyButton {
    return Intl.message("Import Private Key",
        desc: 'A button that imports a private key',
        name: 'importPrivateKeyButton');
  }

  String get gotItButton {
    return Intl.message("Got It!",
        desc: 'A button that implies a message is understood',
        name: 'gotItButton');
  }

  String get goBackButton {
    return Intl.message("Go Back",
        desc: 'A button to go back to previous screen', name: 'goBackButton');
  }

  String get copyButton {
    return Intl.message("Copy",
        desc: 'A button to copy something', name: 'copyButton');
  }

  String get copiedButton {
    return Intl.message("Copied",
        desc: 'A button to inform the user that something has been copied',
        name: 'copiedButton');
  }

  String get iHaveBackedItUpButton {
    return Intl.message("I've Backed It Up",
        desc: 'A button to confirm that something is backed up',
        name: 'iHaveBackedItUpButton');
  }

  String get yesImSureButton {
    return Intl.message("Yes, I'm Sure",
        desc: 'A button to confirm if the user is sure',
        name: 'yesImSureButton');
  }

  String get noGoBackButton {
    return Intl.message("No, Go Back",
        desc:
            'A button to go back to previous screen if the user didnt do what the question asks',
        name: 'noGoBackButton');
  }

  String get getAnAccountButton {
    return Intl.message("Get an Account",
        desc: 'A button to start the process of getting an account',
        name: 'getAnAccountButton');
  }

  String get getAFreeAccountButton {
    return Intl.message("Get a Free Account",
        desc: 'A button to start the process of getting a free account',
        name: 'getAFreeAccountButton');
  }

  String get buyAnAccountButton {
    return Intl.message("Buy an Account",
        desc: 'A button to start the process of buying an account',
        name: 'buyAnAccountButton');
  }

  String get sendConfirmationButton {
    return Intl.message("Send Confirmation",
        desc: 'A button to request a confirmation to be sent',
        name: 'sendConfirmationButton');
  }

  String get confirmButton {
    return Intl.message("Confirm",
        desc: 'A button to confirm that a process should be executed',
        name: 'confirmButton');
  }

  String get borrowAnAccountButton {
    return Intl.message("Borrow An Account",
        desc: 'A button to borrow an account', name: 'borrowAnAccountButton');
  }

  String get importButton {
    return Intl.message("Import",
        desc: 'A button to import something', name: 'importButton');
  }

  String get receiveButton {
    return Intl.message("Receive",
        desc: 'A button to receive Pascal', name: 'receiveButton');
  }

  String get sendButton {
    return Intl.message("Send",
        desc: 'A button to send Pascal', name: 'sendButton');
  }

  String get copyAddressButton {
    return Intl.message("Copy Address",
        desc: 'A button to copy an address', name: 'copyAddressButton');
  }

  String get copiedAddressButton {
    return Intl.message("Address Copied",
        desc: 'A button to inform the user that the address has been copied',
        name: 'copiedAddressButton');
  }

  String get addToContactsButton {
    return Intl.message("Add to Contacts",
        desc: 'A button to add an account to contacts',
        name: 'addToContactsButton');
  }

  String get operationDetailsButton {
    return Intl.message("Operation Details",
        desc: 'A button to view the details of an operation',
        name: 'operationDetailsButton');
  }

  String get openInExplorerButton {
    return Intl.message("Open in Explorer",
        desc:
            'A button to view the details of an operation on the Pascal explorer',
        name: 'openInExplorerButton');
  }

  String get requestButton {
    return Intl.message("Request",
        desc: 'A button to request something', name: 'requestButton');
  }

  String get addAPayloadButton {
    return Intl.message("+ Add a Payload",
        desc: 'A button to add a payload (note) to an operation',
        name: 'addAPayloadButton');
  }

  String get scanQRCodeButton {
    return Intl.message("Scan QR Code",
        desc: 'A button to scan a QR Code', name: 'scanQRCodeButton');
  }

  String get cancelButton {
    return Intl.message("Cancel",
        desc: 'A button to cancel a process', name: 'cancelButton');
  }

  String get closeButton {
    return Intl.message("Close",
        desc: 'A button to close a screen or a pop-up', name: 'closeButton');
  }

  String get changeNameButton {
    return Intl.message("Change Name",
        desc: 'A button to change the name of an account',
        name: 'changeNameButton');
  }

  String get transferButton {
    return Intl.message("Transfer",
        desc: 'A button to transfer the ownership of an account',
        name: 'transferButton');
  }

  String get listForSaleButton {
    return Intl.message("List for Sale",
        desc: 'A button to list an account for sale',
        name: 'listForSaleButton');
  }

  String get createPrivateSaleButton {
    return Intl.message("Create Private Sale",
        desc: 'A button to create a private sale for the account',
        name: 'createPrivateSaleButton');
  }

  String get yesAddFeeButton {
    return Intl.message("Yes, Add Fee",
        desc: 'A button to confirm the addition of a fee to an operation',
        name: 'yesAddFeeButton');
  }

  String get unlockButton {
    return Intl.message("Unlock",
        desc: 'A button to unlock the wallet', name: 'unlockButton');
  }

  String get unlockWithBiometricsButton {
    return Intl.message("Unlock with Biometrics",
        desc: 'A button to unlock the wallet using biometrics',
        name: 'unlockWithBiometricsButton');
  }

  String get unlockWithPINButton {
    return Intl.message("Unlock with PIN",
        desc: 'A button to unlock the wallet using PIN',
        name: 'unlockWithPINButton');
  }

  String get setToDefaultButton {
    return Intl.message("Set to Default",
        desc: 'A button to set something to its default',
        name: 'setToDefaultButton');
  }

  String get changeDaemonButton {
    return Intl.message("Change Daemon",
        desc: 'A button to change the Pascal daemon for RPC requests',
        name: 'changeDaemonButton');
  }

  String get addContactButton {
    return Intl.message("Add Contact",
        desc: 'A button to add a contact', name: 'addContactButton');
  }

  String get encryptedKeyButton {
    return Intl.message("Encrypted Key",
        desc: 'A button to view the encrypted key', name: 'encryptedKeyButton');
  }

  String get unencryptedKeyButton {
    return Intl.message("Unencrypted Key",
        desc: 'A button to view the unencrypted key',
        name: 'unencryptedKeyButton');
  }

  String get encryptButton {
    return Intl.message("Encrypt",
        desc: 'A button to view the unencrypted key', name: 'encryptButton');
  }

  String get showButton {
    return Intl.message("Show",
        desc: 'A button to show something that is hidden', name: 'showButton');
  }

  String get hideButton {
    return Intl.message("Hide",
        desc: 'A button to hide something that is shown', name: 'hideButton');
  }

  String get copyEncryptedKeyButton {
    return Intl.message("Copy Encrypted Key",
        desc: 'A button to copy an encrypted key',
        name: 'copyEncryptedKeyButton');
  }

  String get copyUnencryptedKeyButton {
    return Intl.message("Copy Unencrypted Key",
        desc: 'A button to copy an unencrypted key',
        name: 'copyUnencryptedKeyButton');
  }

  String get copyKeyButton {
    return Intl.message("Copy Key",
        desc: 'A button to copy a key (private or public key)',
        name: 'copyKeyButton');
  }

  String get copyPublicKeyButton {
    return Intl.message("Copy Public Key",
        desc: 'A button to copy a public key', name: 'copyPublicKeyButton');
  }

  String get deletePrivateKeyAndLogoutButton {
    return Intl.message("Delete Private Key\nAnd Logout",
        desc: 'A button to delete the private key and logout',
        name: 'deletePrivateKeyAndLogoutButton');
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
        desc: 'A paragraph that tells the user that the entered PIN is invalid',
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
        desc: 'A paragraph that tells the user to confirm the PIN',
        name: 'confirmPINParagraph');
  }

  String get enterPINParagraph {
    return Intl.message("Enter PIN",
        desc: 'A paragraph that tells the user to enter the PIN',
        name: 'enterPINParagraph');
  }

  String get createPINParagraph {
    return Intl.message("Create a 6-digit PIN",
        desc: 'A paragraph that tells the user to create a PIN',
        name: 'createPINParagraph');
  }
  // PIN Screen END
  // **** PARAGRAPHS END **** //

  // **** HEADERS **** //
  // Settings Headers
  String get settingsHeader {
    return Intl.message("Settings",
        desc: 'Header for the settings', name: 'settings');
  }

  String get preferencesHeader {
    return Intl.message("Preferences",
        desc: 'Header for the preferences section', name: 'preferences');
  }

  String get currencyHeader {
    return Intl.message("Currency",
        desc: 'Header for the currencies', name: 'currency');
  }

  String get languageHeader {
    return Intl.message("Language",
        desc: 'Header for the languages', name: 'language');
  }

  String get themeHeader {
    return Intl.message("theme", desc: 'Header for the themes', name: 'theme');
  }

  String get themeLightHeader {
    return Intl.message("Light",
        desc: 'Header for the light theme', name: 'themeLight');
  }

  String get themeDarkHeader {
    return Intl.message("Dark",
        desc: 'Header for the dark theme', name: 'themeDark');
  }

  String get themeCopperHeader {
    return Intl.message("Copper",
        desc: 'Header for the copper theme', name: 'themeCopper');
  }

  String get securityHeader {
    return Intl.message("Copper",
        desc: 'Header for the security section', name: 'securityHeader');
  }

  String get authenticationMethodHeader {
    return Intl.message("Authentication Method",
        desc: 'Header for the authentication method',
        name: 'authenticationMethodHeader');
  }

  String get authenticationPINHeader {
    return Intl.message("PIN",
        desc: 'Header for the PIN authentication method',
        name: 'authenticationPINHeader');
  }

  String get authenticationBiometricsHeader {
    return Intl.message("Biometrics",
        desc: 'Header for the biometric authentication method',
        name: 'authenticationBiometricsHeader');
  }

  String get authenticateOnLaunchHeader {
    return Intl.message("Authenticate on Launch",
        desc: 'Header for the authenticate on launch option',
        name: 'authenticateOnLaunchHeader');
  }

  String get yesHeader {
    return Intl.message("Yes",
        desc: 'Header for the yes option', name: 'yesHeader');
  }

  String get noHeader {
    return Intl.message("No",
        desc: 'Header for the no option', name: 'noHeader');
  }

  String get automaticallyLockHeader {
    return Intl.message("Automatically Lock",
        desc: 'Header for the automatically lock option',
        name: 'automaticallyLockHeader');
  }

  String get lockInstantHeader {
    return Intl.message("Instantly",
        desc: 'Header for instantly locking option',
        name: 'lockInstantHeader');
  }

  String get lock1Header {
    return Intl.message("After 1% minute",
        desc: 'Header for locking after 1 minute option',
        name: 'lock1Header');
  }

  String get lock5Header {
    return Intl.message("After 1% minutes",
        desc: 'Header for locking after 5 minutes option',
        name: 'lock5Header');
  }

  String get lock15Header {
    return Intl.message("After 1% minutes",
        desc: 'Header for locking after 15 minutes option',
        name: 'lock15Header');
  }

  String get lock30Header {
    return Intl.message("After 1% minutes",
        desc: 'Header for locking after 30 minutes option',
        name: 'lock30Header');
  }

  String get lock60Header {
    return Intl.message("After 1% minutes",
        desc: 'Header for locking after 60 minutes option',
        name: 'lock60Header');
  }
  String get daemonHeader {
    return Intl.message("Daemon",
        desc: 'Header for Pascal daemon setting',
        name: 'daemonHeader');
  }
  String get defaultHeader {
    return Intl.message("Default",
        desc: 'Header for default option',
        name: 'defaultHeader');
  }
  String get manageHeader {
    return Intl.message("Manage",
        desc: 'Header for the manage section', name: 'manageHeader');
  }
  String get contactsHeader {
    return Intl.message("Contacts",
        desc: 'Header for the contacts section in settings', name: 'contactsHeader');
  }
  String get backUpPrivateKeyHeader {
    return Intl.message("Back Up Private Key",
        desc: 'Header for the back up private key option in settings', name: 'backUpPrivateKeyHeader');
  }
  String get viewPublicKeyHeader {
    return Intl.message("View Public Key",
        desc: 'Header for the view public key option in settings', name: 'viewPublicKeyHeader');
  }
  String get shareHeader {
    return Intl.message("Share Blaise",
        desc: 'Header for the share Blaise option in settings', name: 'shareHeader');
  }
  String get logoutHeader {
    return Intl.message("Logout",
        desc: 'Header for the logout option in settings', name: 'logoutHeader');
  }
  String get privacyPolicyHeader {
    return Intl.message("Privacy Policy",
        desc: 'Header for the privacy policy option in settings', name: 'privacyPolicyHeader');
  }
  // Settings Headers END

  // Sheet Headers
  String get getAccountHeader {
    return Intl.message("Get Account",
        desc: 'Header for the get account sheet (screen)', name: 'getAccountHeader');
  }
  String get freeAccountHeader {
    return Intl.message("Free Account",
        desc: 'Header for the free account sheet (screen)', name: 'freeAccountHeader');
  }
  String get buyAccountHeader {
    return Intl.message("Buy Account",
        desc: 'Header for the buy account sheet (screen)', name: 'buyAccountHeader');
  }
  String get sendHeader {
    return Intl.message("Send",
        desc: 'Header for send sheet (screen)', name: 'sendHeader');
  }
  String get sendingHeader {
    return Intl.message("Sending",
        desc: 'Header for sending sheet (screen)', name: 'sendingHeader');
  }
  String get sentHeader {
    return Intl.message("Sent",
        desc: 'Header for sent sheet (screen)', name: 'sentHeader');
  }
  String get requestHeader {
    return Intl.message("Request",
        desc: 'Header for request sheet (screen)', name: 'requestHeader');
  }
  String get changeNameHeader {
    return Intl.message("Change Name",
        desc: 'Header for change name sheet (screen)', name: 'changeNameHeader');
  }
  String get changingNameHeader {
    return Intl.message("Changing",
        desc: 'Header for name changing sheet (screen)', name: 'changingNameHeader');
  }
  String get changedNameHeader {
    return Intl.message("Changed",
        desc: 'Header for name changed sheet (screen)', name: 'changedNameHeader');
  }
  String get transferHeader {
    return Intl.message("Transfer",
        desc: 'Header for transfer sheet (screen)', name: 'transferHeader');
  }
  String get transferringHeader {
    return Intl.message("Transferring",
        desc: 'Header for transferring sheet (screen)', name: 'transferringHeader');
  }
  String get transferredHeader {
    return Intl.message("Transferred",
        desc: 'Header for transferred sheet (screen)', name: 'transferredHeader');
  }
  String get listForSaleHeader {
    return Intl.message("List For Sale",
        desc: 'Header for list for sale sheet (screen)', name: 'listForSaleHeader');
  }
  String get listingForSaleHeader {
    return Intl.message("Listing",
        desc: 'Header for listing for sale sheet (screen)', name: 'listingForSaleHeader');
  }
  String get listedForSaleHeader {
    return Intl.message("Listed",
        desc: 'Header for listed for sale sheet (screen)', name: 'listedForSaleHeader');
  }
  String get createPrivateSaleHeader {
    return Intl.message("Private Sale",
        desc: 'Header for create private sale sheet (screen)', name: 'createPrivateSaleHeader');
  }
  String get creatingPrivateSaleHeader {
    return Intl.message("Creating",
        desc: 'Header for creating private sale sheet (screen)', name: 'creatingPrivateSaleHeader');
  }
  String get createdPrivateSaleHeader {
    return Intl.message("Created",
        desc: 'Header for created private sale sheet (screen)', name: 'createdPrivateSaleHeader');
  }
  String get delistingHeader {
    return Intl.message("Delisting",
        desc: 'Header for delisting sheet (screen)', name: 'delistingHeader');
  }
  String get delistedHeader {
    return Intl.message("Delisted",
        desc: 'Header for delisted sheet (screen)', name: 'delistedHeader');
  }
  String get addContactHeader {
    return Intl.message("Add Contact",
        desc: 'Header for add contact sheet (screen)', name: 'addcontactHeader');
  }
  String get contactHeader {
    return Intl.message("Contact",
        desc: 'Header for contact details sheet (screen)', name: 'contactHeader');
  }
  String get privateKeyHeader {
    return Intl.message("Private Key",
        desc: 'Header for private key sheet (screen)', name: 'privateKeyHeader');
  }
  String get backUpHeader {
    return Intl.message("BACK UP",
        desc: 'Header for back up sheet (screen)', name: 'backUpHeader');
  }
  String get encryptHeader {
    return Intl.message("Encrypt",
        desc: 'Header for encrypt sheet (screen)', name: 'encryptHeader');
  }
  String get changeDaemonHeader {
    return Intl.message("Change Daemon",
        desc: 'Header for change daemon sheet (screen)', name: 'changeDaemonHeader');
  }
  // Sheet Headers END


  // **** HEADERS END **** //

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
