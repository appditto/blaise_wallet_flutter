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

  String get keyCopiedButton {
    return Intl.message("Key Copied",
        desc: 'A button to inform the user that the key has been copied',
        name: 'keyCopiedButton');
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

  String get addADurationButton {
    return Intl.message("+ Add a Duration",
        desc: 'A button to add a duration to the sale',
        name: 'addADurationButton');
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
        desc: 'A button to encrypt the private key with a password', name: 'encryptButton');
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

  String get searchForNameButton {
    return Intl.message("Search For Name",
        desc: 'A button to search for an account name',
        name: 'searchForNameButton');
  }

  String get searchAccountNameButton {
    return Intl.message("Search Account Name",
        desc: 'A button to search an account name',
        name: 'searchAccountNameButton');
  }

  String get searchNameButton {
    return Intl.message("Search Name",
        desc: 'A button to search name', name: 'searchNameButton');
  }

  String get okayGoBackButton {
    return Intl.message("Okay, Go Back",
        desc: 'A button to confirm and go back', name: 'okayGoBackButton');
  }

  String get okayButton {
    return Intl.message("Okay",
      desc: 'A button that simply indicates a neutral action, like closing an informative dialog', name: 'okayButton');
  }

  String get nextButton {
    return Intl.message("Next",
        desc: 'A button to the next screen', name: 'nextButton');
  }
  String get receiveAccountButton {
    return Intl.message("Receive Account",
        desc: 'A button to open up the public key sheet(screen) that displays a QR code to receive an account', name: 'receiveAccountButton');
  }
  String get receiveAnAccountButton {
    return Intl.message("Receive an Account",
        desc: 'A button to open up the public key sheet(screen) that displays a QR code to receive an account', name: 'receiveAnAccountButton');
  }

  String get supportButton {
    return Intl.message("Support",
        desc: 'A button to open up the live support window', name: 'supportButton');
  }
  String get liveSupportButton {
    return Intl.message("Support",
        desc: 'A button to open up the live support window', name: 'liveSupportButton');
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

  String get newPrivateKeyParagraph {
    return Intl.message(
        "Below is your new wallet’s private key. It is crucial that you backup your private key and never store it as plaintext or a screenshot. We recommend writing it on a piece of paper and storing it offline.",
        desc:
            'A paragraph that explains what users should do with their new private key',
        name: 'newPrivateKeyParagraph');
  }

  String get newKeyBackUpConfirmParagraph {
    return Intl.message(
        "Are you sure that you have backed up your new wallet’s private key?",
        desc: 'A paragraph to confirm if the new private key is backed up',
        name: 'newKeyBackUpConfirmParagraph');
  }

  String get newWalletGreetingParagraph {
    return Intl.message(
        "Welcome to <colored>Blaise Wallet</colored>.\nYou can start by getting an account.",
        desc: 'A paragraph to greet the user when a new wallet is created',
        name: 'newWalletGreetingParagraph');
  }

  String get getAccountFirstParagraph {
    return Intl.message("There are 2 options for getting your first account:",
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
        "2- You can buy as many accounts as you want for <colored>%1 Pascal (%2).</colored>",
        desc:
            'The third paragraph of the explanation for the process of getting an account',
        name: 'getAccountThirdParagraph');
  }

  String get getAccountThirdParagraphAlternative {
    return Intl.message(
        "2- You can buy an account for <colored>%1 Pascal (%2).</colored><colored> Buying only 1 account is allowed per user.</colored>",
        desc:
            'The third paragraph of the explanation for the process of getting an account',
        name: 'getAccountThirdParagraphAlternative');
  }

  String get getAccountThirdParagraphAlternative2 {
    return Intl.message(
        "2- You can buy an account for <colored>%1 Pascal (%2).</colored><colored> You can buy up to %3 accounts.</colored>",
        desc:
            'The third paragraph of the explanation for the process of getting an account',
        name: 'getAccountThirdParagraphAlternative2');
  }

  String get enterPhoneNumberParagraph {
    return Intl.message("Enter your phone number below.",
        desc:
            'A paragraph that tells users to enter their phone number to the text field below',
        name: 'enterPhoneNumberParagraph');
  }

  String get invalidPhoneNumberParagraph {
    return Intl.message("Phone number is not valid",
      desc: 'User has entered an invalid phone number', name: 'invalidPhoneNumberParagraph');
  }

  String get enterConfirmationCodeParagraph {
    return Intl.message(
        "We have sent you a confirmation code, please enter it below.",
        desc:
            'A paragraph that tells users to enter the confirmation code to the text field below',
        name: 'enterConfirmationCodeParagraph');
  }

  String get confirmationCodeError {
    return Intl.message("Failed to verify code, ensure you've entered it correctly",
      desc: 'When a user enters their freepasa SMS code but it can\'t be verified',
      name: 'confirmationCodeError');
  }

  String get freepasaComplete {
    return Intl.message("Success, your new account will be available after 1 network confirmation",
      desc: 'After the freepasa process is complete',
      name: 'freepasaComplete');
  }

  String get unconfirmedAccountHeader {
    return Intl.message("Unconfirmed Account",
      desc: 'A user has an account in their wallet that has been transferred to them, but isnt confirmed yet. This is the info dialog header.',
      name: 'unconfirmedAccountHeader');
  }

  String get unconfirmedAccountParagraph {
    return Intl.message("This is an <colored>unconfirmed account</colored>. It has been transferred to you, but there needs to be 1 network confirmation before you can use it. This usually takes about 5 minutes, once it's complete you'll be able to use this account.",
      desc: 'Explaining that an account can\'t be used until 1 network confirmation to the user.',
      name: 'unconfirmedAccountParagraph');
  }


  String get borrowStarted {
    return Intl.message(
      "Purchase Started for %1",
      desc: "Users may see this after starting the account purchase process",
      name: 'borrowStarted'
    );
  }

  String get borrowAccountParagraph {
    return Intl.message(
        "To buy an account, first you’ll need to borrow one for free. If you send at least <colored>%1 Pascal (%2)</colored> to the account within <colored>%3 days</colored>, the account will be yours and <colored>%1 Pascal</colored> will be deducted from your balance automatically.\nOtherwise, it’ll return back to us at the end of <colored>%3 days</colored> and won’t belong to your wallet anymore.\nIt is recommended you only send a small amount of coins until you own the account.",
        desc:
            'A paragraph that explains the process of borrowing & buying an account',
        name: 'borrowAccountParagraph');
  }

  String get importPrivateKeyParagraph {
    return Intl.message("Enter your private key below.",
        desc:
            'A paragraph that tells the user to enter their private key to the text field below',
        name: 'importPrivateKeyParagraph');
  }

  String get looksLikeEncryptedKeyParagraph {
    return Intl.message(
        "This looks like an encrypted private key, please enter the password to decrypt and import it.",
        desc:
            'A paragraph that tells the user that the key looks like an encrypted one and it needs to be decrypted to import',
        name: 'looksLikeEncryptedKeyParagraph');
  }

  // Settings Related Paragraphs
  String get changeDaemonParagraph {
    return Intl.message(
        "Enter an address to use a different Pascal daemon for RPC requests.",
        desc:
            'A paragraph that tells the user to enter a new daemon address below',
        name: 'changeDaemonParagraph');
  }

  String get urlChangedToParagraph {
    return Intl.message("URL changed to %1",
        desc:
            'A paragraph that tells the user that the URL is changed to the entered URL',
        name: 'urlChangedToParagraph');
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

  String get borrowedAccountParagraph {
    return Intl.message(
        "This is a <colored>borrowed account</colored>.\nIf you send at least <colored>%1 Pascal</colored> to it in the next <colored>%2 days, %3 hours, and %4 minutes</colored>, it’ll be yours.",
        desc: 'A paragraph that explains what a borrowed account is',
        name: 'borrowedAccountParagraph');
  }

  String get borrowedAccountPaidParagraph {
    return Intl.message(
        "<colored>Your account has been purchased!</colored>\nThe transfer is currently processing. This process usually takes about <colored>15 minutes</colored>, in some cases it may take slightly longer.",
        desc: 'A paragraph that explains that the account has been purchased and transfer is currently processing',
        name: 'borrowedAccountPaidParagraph');
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
  String get noResultsFound {
    return Intl.message("No results found",
      desc: 'When searching for account name has returned 0 results',
      name: 'noResultsFound');
  }

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

  String get transferringParagraph {
    return Intl.message(
        "Confirm the public key below to transfer the ownership of this account to it.",
        desc:
            'A paragraph that tells the user to confirm the public key below to proceed with the transfer',
        name: 'transferringParagraph');
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
        "Please confirm the addition of %1 Pascal fee to this operation to continue.",
        desc: 'A paragraph to tell the user to confirm the addition of a fee',
        name: 'feeConfirmAmountParagraph');
  }

  String get keyTypeNotSupportedParagraph {
    return Intl.message(
        "This type of private key is not yet supported by Blaise. You may create a new private key and transfer your accounts to it using a different wallet.",
        desc:
            'A paragraph to tell the user that the private key type is not supported',
        name: 'keyTypeNotSupportedParagraph');
  }

  // PIN Screen
  String get enterPINToUnlockParagraph {
    return Intl.message("Enter PIN to unlock Blaise",
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
    return Intl.message("Authenticate to delist the account from sale",
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
        name: 'authenticateToBackUpParagraph');
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

  String get addedToContactsParagraph {
    return Intl.message("%1 added to contacts",
        desc:
            'A paragraph that tells the user that the contact has been added to contacts',
        name: 'addedToContactsParagraph');
  }

  String get removedFromContactsParagraph {
    return Intl.message("Removed %1 from contacts",
        desc:
            'A paragraph that tells the user that the contact has been removed from contacts',
        name: 'removedFromContactsParagraph');
  }

  String get failedToRemoveFromContactsParagraph {
    return Intl.message("Failed to remove %1 from contacts",
        desc:
            'A paragraph that tells the user that the contact removel process is failed',
        name: 'failedToRemoveFromContactsParagraph');
  }

  String get successfullyImportedContactsParagraph {
    return Intl.message("Successfully imported %1 contacts",
        desc:
            'A paragraph to tell the user that a specific number of contacts was successfully imported',
        name: 'successfullyImportedContactsParagraph');
  }

  String get checkOutBlaiseParagraph {
    return Intl.message(
        "Check out Blaise! Simple, sleek & secure Pascal wallet for iOS and Android: https://blaisewallet.com",
        desc:
            'A paragraph that is shared when the user shares Blaise with others via the option in the settings',
        name: 'checkOutBlaiseParagraph');
  }

  String get newAccountParagraph {
    return Intl.message(
        "This is your new account.\nOnce you receive <colored>Pascal</colored>, operations will show up like below.",
        desc:
            'A paragraph that is shown in the operations list of a new account as an explainer',
        name: 'newAccountParagraph');
  }
  // **** PARAGRAPHS END **** //

  // **** HEADERS **** //
  // Settings Headers
  String get settingsHeader {
    return Intl.message("Settings",
        desc: 'Header for the settings', name: 'settingsHeader');
  }

  String get preferencesHeader {
    return Intl.message("Preferences",
        desc: 'Header for the preferences section', name: 'preferencesHeader');
  }

  String get currencyHeader {
    return Intl.message("Currency",
        desc: 'Header for the currencies', name: 'currencyHeader');
  }

  String get languageHeader {
    return Intl.message("Language",
        desc: 'Header for the languages', name: 'languageHeader');
  }

  String get languageColonHeader {
    return Intl.message("Language:",
        desc: 'Header for the language option on welcome page', name: 'languageColonHeader');
  }

  String get systemDefaultHeader {
    return Intl.message("System Default",
        desc: 'Header for system default', name: 'systemDefaultHeader');
  }

  String get themeHeader {
    return Intl.message("Theme",
        desc: 'Header for the themes', name: 'themeHeader');
  }

  String get themeLightHeader {
    return Intl.message("Light",
        desc: 'Header for the light theme', name: 'themeLightHeader');
  }

  String get themeDarkHeader {
    return Intl.message("Dark",
        desc: 'Header for the dark theme', name: 'themeDarkHeader');
  }

  String get themeCopperHeader {
    return Intl.message("Copper",
        desc: 'Header for the copper theme', name: 'themeCopperHeader');
  }

  String get notificationsHeader {
    return Intl.message("Notifications",
        desc: 'Header for the notifications', name: 'notificationsHeader');
  }

  String get securityHeader {
    return Intl.message("Security",
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
        desc: 'Header for instantly locking option', name: 'lockInstantHeader');
  }

  String get lock1Header {
    return Intl.message("After %1 minute",
        desc: 'Header for locking after 1 minute option', name: 'lock1Header');
  }

  String get lock5Header {
    return Intl.message("After %1 minutes",
        desc: 'Header for locking after 5 minutes option', name: 'lock5Header');
  }

  String get lock15Header {
    return Intl.message("After %1 minutes",
        desc: 'Header for locking after 15 minutes option',
        name: 'lock15Header');
  }

  String get lock30Header {
    return Intl.message("After %1 minutes",
        desc: 'Header for locking after 30 minutes option',
        name: 'lock30Header');
  }

  String get lock60Header {
    return Intl.message("After %1 minutes",
        desc: 'Header for locking after 60 minutes option',
        name: 'lock60Header');
  }

  String get daemonHeader {
    return Intl.message("Daemon",
        desc: 'Header for Pascal daemon setting', name: 'daemonHeader');
  }

  String get defaultHeader {
    return Intl.message("Default",
        desc: 'Header for default option', name: 'defaultHeader');
  }

  String get manageHeader {
    return Intl.message("Manage",
        desc: 'Header for the manage section', name: 'manageHeader');
  }

  String get contactsHeader {
    return Intl.message("Contacts",
        desc: 'Header for the contacts section in settings',
        name: 'contactsHeader');
  }

  String get backUpPrivateKeyHeader {
    return Intl.message("Back Up Private Key",
        desc: 'Header for the back up private key option in settings',
        name: 'backUpPrivateKeyHeader');
  }

  String get viewPublicKeyHeader {
    return Intl.message("View Public Key",
        desc: 'Header for the view public key option in settings',
        name: 'viewPublicKeyHeader');
  }

  String get shareHeader {
    return Intl.message("Share Blaise",
        desc: 'Header for the share Blaise option in settings',
        name: 'shareHeader');
  }

  String get logoutHeader {
    return Intl.message("Logout",
        desc: 'Header for the logout option in settings', name: 'logoutHeader');
  }

  String get privacyPolicyHeader {
    return Intl.message("Privacy Policy",
        desc: 'Header for the privacy policy option in settings',
        name: 'privacyPolicyHeader');
  }

  // Settings Headers END

  // Operations List Headers
  String get changeAccountNameHeader {
    return Intl.message("Change Account Name",
        desc:
            'Header for the change account name option in other operations list',
        name: 'changeAccountNameHeader');
  }

  String get transferAccountHeader {
    return Intl.message("Transfer Account",
        desc: 'Header for the transfer account option in other operations list',
        name: 'transferAccountHeader');
  }

  String get listAccountForSaleHeader {
    return Intl.message("List Account For Sale",
        desc:
            'Header for the list account for sale option in other operations list',
        name: 'listAccountForSaleHeader');
  }

  String get createPrivateSaleHeader {
    return Intl.message("Create Private Sale",
        desc:
            'Header for the create private sale option in other operations list',
        name: 'createPrivateSaleHeader');
  }

  String get delistFromSaleHeader {
    return Intl.message("Delist From Sale",
        desc: 'Header for the delist from sale option in other operations list',
        name: 'delistFromSaleHeader');
  }
  // Operations List Headers END

  // Sheet Headers
  String get getAccountSheetHeader {
    return Intl.message("Get Account",
        desc: 'Header for the get account sheet (screen)',
        name: 'getAccountSheetHeader');
  }

  String get freeAccountSheetHeader {
    return Intl.message("Free Account",
        desc: 'Header for the free account sheet (screen)',
        name: 'freeAccountSheetHeader');
  }

  String get buyAccountSheetHeader {
    return Intl.message("Buy Account",
        desc: 'Header for the buy account sheet (screen)',
        name: 'buyAccountSheetHeader');
  }

  String get sendSheetHeader {
    return Intl.message("Send",
        desc: 'Header for send sheet (screen)', name: 'sendSheetHeader');
  }

  String get sendingSheetHeader {
    return Intl.message("Sending",
        desc: 'Header for sending sheet (screen)', name: 'sendingSheetHeader');
  }

  String get sentSheetHeader {
    return Intl.message("Sent",
        desc: 'Header for sent sheet (screen)', name: 'sentSheetHeader');
  }

  String get requestSheetHeader {
    return Intl.message("Request",
        desc: 'Header for request sheet (screen)', name: 'requestSheetHeader');
  }

  String get changeNameSheetHeader {
    return Intl.message("Change Name",
        desc: 'Header for change name sheet (screen)',
        name: 'changeNameSheetHeader');
  }

  String get changingNameSheetHeader {
    return Intl.message("Changing",
        desc: 'Header for name changing sheet (screen)',
        name: 'changingNameSheetHeader');
  }

  String get changedNameSheetHeader {
    return Intl.message("Changed",
        desc: 'Header for name changed sheet (screen)',
        name: 'changedNameSheetHeader');
  }

  String get transferSheetHeader {
    return Intl.message("Transfer",
        desc: 'Header for transfer sheet (screen)',
        name: 'transferSheetHeader');
  }

  String get transferringSheetHeader {
    return Intl.message("Transferring",
        desc: 'Header for transferring sheet (screen)',
        name: 'transferringSheetHeader');
  }

  String get transferredSheetHeader {
    return Intl.message("Transferred",
        desc: 'Header for transferred sheet (screen)',
        name: 'transferredSheetHeader');
  }

  String get listForSaleSheetHeader {
    return Intl.message("List For Sale",
        desc: 'Header for list for sale sheet (screen)',
        name: 'listForSaleSheetHeader');
  }

  String get listingForSaleSheetHeader {
    return Intl.message("Listing",
        desc: 'Header for listing for sale sheet (screen)',
        name: 'listingForSaleSheetHeader');
  }

  String get listedForSaleSheetHeader {
    return Intl.message("Listed",
        desc: 'Header for listed for sale sheet (screen)',
        name: 'listedForSaleSheetHeader');
  }

  String get createPrivateSaleSheetHeader {
    return Intl.message("Private Sale",
        desc: 'Header for create private sale sheet (screen)',
        name: 'createPrivateSaleSheetHeader');
  }

  String get creatingPrivateSaleSheetHeader {
    return Intl.message("Creating",
        desc: 'Header for creating private sale sheet (screen)',
        name: 'creatingPrivateSaleSheetHeader');
  }

  String get createdPrivateSaleSheetHeader {
    return Intl.message("Created",
        desc: 'Header for created private sale sheet (screen)',
        name: 'createdPrivateSaleSheetHeader');
  }

  String get delistingSheetHeader {
    return Intl.message("Delisting",
        desc: 'Header for delisting sheet (screen)',
        name: 'delistingSheetHeader');
  }

  String get delistedSheetHeader {
    return Intl.message("Delisted",
        desc: 'Header for delisted sheet (screen)',
        name: 'delistedSheetHeader');
  }

  String get addContactSheetHeader {
    return Intl.message("Add Contact",
        desc: 'Header for add contact sheet (screen)',
        name: 'addContactSheetHeader');
  }

  String get contactSheetHeader {
    return Intl.message("Contact",
        desc: 'Header for contact details sheet (screen)',
        name: 'contactSheetHeader');
  }

  String get publicKeySheetHeader {
    return Intl.message("Public Key",
        desc: 'Header for public key sheet (screen)',
        name: 'publicKeySheetHeader');
  }

  String get privateKeySheetHeader {
    return Intl.message("Private Key",
        desc: 'Header for private key sheet (screen)',
        name: 'privateKeySheetHeader');
  }

  String get backUpSheetHeader {
    return Intl.message("Back Up",
        desc: 'Header for back up sheet (screen)', name: 'backUpSheetHeader');
  }

  String get encryptSheetHeader {
    return Intl.message("Encrypt",
        desc: 'Header for encrypt sheet (screen)', name: 'encryptSheetHeader');
  }

  String get changeDaemonSheetHeader {
    return Intl.message("Change Daemon",
        desc: 'Header for change daemon sheet (screen)',
        name: 'changeDaemonSheetHeader');
  }
  // Sheet Headers END

  // Full screen Headers
  String get securityFirstHeader {
    return Intl.message("Security First!",
        desc: 'Header for security first screen', name: 'securityFirstHeader');
  }

  String get newPrivateKeyHeader {
    return Intl.message("New Private Key",
        desc: 'Header for new private key screen', name: 'newPrivateKeyHeader');
  }

  String get importPrivateKeyHeader {
    return Intl.message("Import Private Key",
        desc: 'Header for import private key screen',
        name: 'importPrivateKeyHeader');
  }

  String get decryptAndImportKeyHeader {
    return Intl.message("Decrypt & Import",
        desc: 'Header for decrypt & import private key screen',
        name: 'decryptAndImportKeyHeader');
  }

  String get backUpKeyHeader {
    return Intl.message("Back Up Your Key!",
        desc: 'Header for back up your key screen', name: 'backUpKeyHeader');
  }

  String get lockedHeader {
    return Intl.message("Locked",
        desc: 'Header for locked screen', name: 'lockedHeader');
  }
  // Full screen Headers END

  // Text Field Headers
  String get privateKeyTextFieldHeader {
    return Intl.message("Private Key",
        desc: 'Header for private key text field',
        name: 'privateKeyTextFieldHeader');
  }

  String get passwordTextFieldHeader {
    return Intl.message("Password",
        desc: 'Header for password text field',
        name: 'passwordTextFieldHeader');
  }

  String get newPasswordTextFieldHeader {
    return Intl.message("New Password",
        desc: 'Header for new password text field',
        name: 'newPasswordTextFieldHeader');
  }

  String get confirmPasswordTextFieldHeader {
    return Intl.message("Confirm Password",
        desc: 'Header for confirm password text field',
        name: 'confirmPasswordTextFieldHeader');
  }

  String get confirmTextFieldHeader {
    return Intl.message("Confirm",
        desc: 'Header for confirm text field', name: 'confirmTextFieldHeader');
  }

  String get countryCodeTextFieldHeader {
    return Intl.message("Country Code",
        desc: 'Header for country code text field',
        name: 'countryCodeTextFieldHeader');
  }

  String get phoneNumberTextFieldHeader {
    return Intl.message("Phone Number",
        desc: 'Header for phone number text field',
        name: 'phoneNumberTextFieldHeader');
  }

  String get confirmationCodeTextFieldHeader {
    return Intl.message("Confirmation Code",
        desc: 'Header for confirmation code text field',
        name: 'confirmationCodeTextFieldHeader');
  }

  String get accountTextFieldHeader {
    return Intl.message("Account",
        desc: 'Header for account text field', name: 'accountTextFieldHeader');
  }

  String get addressTextFieldHeader {
    return Intl.message("Address",
        desc: 'Header for address text field', name: 'addressTextFieldHeader');
  }

  String get contactNameTextFieldHeader {
    return Intl.message("Contact Name",
        desc: 'Header for contact name text field',
        name: 'contactNameTextFieldHeader');
  }

  String get amountTextFieldHeader {
    return Intl.message("Amount",
        desc: 'Header for amount text field', name: 'amountTextFieldHeader');
  }

  String get payloadTextFieldHeader {
    return Intl.message("Payload",
        desc: 'Header for payload text field', name: 'payloadTextFieldHeader');
  }

  String get nameTextFieldHeader {
    return Intl.message("Name",
        desc: 'Header for name text field', name: 'nameTextFieldHeader');
  }

  String get newAccountNameTextFieldHeader {
    return Intl.message("New Account Name",
        desc: 'Header for new account name text field',
        name: 'newAccountNameTextFieldHeader');
  }

  String get publicKeyTextFieldHeader {
    return Intl.message("Public Key",
        desc: 'Header for public key text field',
        name: 'publicKeyTextFieldHeader');
  }

  String get priceTextFieldHeader {
    return Intl.message("Price",
        desc: 'Header for price text field', name: 'priceTextFieldHeader');
  }

  String get receivingAccountTextFieldHeader {
    return Intl.message("Receiving Account",
        desc: 'Header for receiving account text field',
        name: 'receivingAccountTextFieldHeader');
  }

  String get durationTextFieldHeader {
    return Intl.message("Duration",
        desc: 'Header for duration text field',
        name: 'durationTextFieldHeader');
  }

  String get feeTextFieldHeader {
    return Intl.message("Fee",
        desc: 'Header for fee text field', name: 'feeTextFieldHeader');
  }
  // Text Field Headers END

  // Dialog Headers
  String get otherOperationsHeader {
    return Intl.message("Other Operations",
        desc: 'Header for other operations dialog',
        name: 'otherOperationsHeader');
  }

  String get warningHeader {
    return Intl.message("Warning",
        desc: 'Header for warning dialog', name: 'warningHeader');
  }

  String get areYouSureHeader {
    return Intl.message("Are You Sure?",
        desc: 'Header for are you sure dialog', name: 'areYouSureHeader');
  }

  String get addFeeHeader {
    return Intl.message("Add Fee",
        desc: 'Header for add fee dialog', name: 'addFeeHeader');
  }

  String get keyTypeNotSupportedHeader {
    return Intl.message("Key Not Supported",
        desc: 'Header for key not supported dialog',
        name: 'keyTypeNotSupportedHeader');
  }

  String get accountToSendFromHeader {
    return Intl.message("Account to Send From",
        desc: 'Header for account to send from dialog',
        name: 'accountToSendFromHeader');
  }
  // Dialog Headers END

  // Operation List Item Headers
  String get sentHeader {
    return Intl.message("Sent",
        desc: 'Header for sent type operation list item', name: 'sentHeader');
  }

  String get receivedHeader {
    return Intl.message("Received",
        desc: 'Header for received type operation list item',
        name: 'receivedHeader');
  }

  String get nameChangedHeader {
    return Intl.message("Name Changed",
        desc: 'Header for listed for sale type operation list item',
        name: 'nameChangedHeader');
  }

  String get listedForSaleHeader {
    return Intl.message("Listed For Sale",
        desc: 'Header for listed for sale type operation list item',
        name: 'listedForSaleHeader');
  }

  String get privateSaleHeader {
    return Intl.message("Private Sale",
        desc: 'Header for private sale type operation list item',
        name: 'privateSaleHeader');
  }

  String get delistedFromSaleHeader {
    return Intl.message("Delisted From Sale",
        desc: 'Header for delisted from sale type operation list item',
        name: 'delistedFromSaleHeader');
  }

  String get delistedHeader {
    return Intl.message("Delisted",
        desc: 'Header for delisted type operation list item',
        name: 'delistedHeader');
  }

  String get undefinedHeader {
    return Intl.message("Undefined",
        desc: 'Header for undefined type operation list item',
        name: 'undefinedHeader');
  }

  String get transferredHeader {
    return Intl.message("Transferred",
        desc: 'Header for transferred type operation list item',
        name: 'transferredHeader');
  }
  // Operation List Item Headers END

  // Live chat
  String get connectingHeader {
    return Intl.message(
        "Connecting",
        desc:
            'A header to let the user now that Blaise is currently connecting to (or loading) live chat.',
        name: 'connectingHeader');
  }

  // Miscellaneous Headers
  String get balanceHeader {
    return Intl.message("Balance",
        desc: 'Header for balance', name: 'balanceHeader');
  }

  String get totalBalanceHeader {
    return Intl.message("Total Balance",
        desc: 'Header for total balance', name: 'totalBalanceHeader');
  }

  String get accountBalanceHeader {
    return Intl.message("Account Balance",
        desc: 'Header for account balance', name: 'accountBalanceHeader');
  }

  String get accountsHeader {
    return Intl.message("Accounts",
        desc: 'Header for accounts', name: 'accountsHeader');
  }

  String get operationsHeader {
    return Intl.message("Operations",
        desc: 'Header for operations', name: 'operationsHeader');
  }

  String get encryptThePayloadHeader {
    return Intl.message("Encrypt the Payload",
        desc: 'Header for encrypt the payload switch',
        name: 'encryptThePayloadHeader');
  }

  String get encryptPayloadHeader {
    return Intl.message("Encrypt Payload",
        desc: 'Header for encrypt payload switch',
        name: 'encryptPayloadHeader');
  }

  String get forSaleHeader {
    return Intl.message("For Sale",
        desc: 'Header of for sale tag', name: 'forSaleHeader');
  }

  String get borrowedHeader {
    return Intl.message("Borrowed",
        desc: 'Header for borrowed tag', name: 'borrowedHeader');
  }

  String get borrowedTransferredHeader {
    return Intl.message("Transfer Pending",
        desc: 'Header for borrowed tag, after account is transferred but not confirmed', name: 'borrowedTransferredHeader');
  }

  String get borrowedAccountHeader {
    return Intl.message("Borrowed Account",
        desc: 'Header for borrowed account tag', name: 'borrowedAccountHeader');
  }

  String get feeColonHeader {
    return Intl.message("Fee:",
        desc: 'Header for fee amount', name: 'feeColonHeader');
  }

  String get pendingHeader {
    return Intl.message("Pending",
        desc: 'Header to indicate that an operation is pending',
        name: 'pendingHeader');
  }

  String get onHeader {
    return Intl.message("On",
        desc: "A header to indicate that something is on", name: "onHeader");
  }

  String get offHeader {
    return Intl.message("Off",
        desc: "A header to indicate that something is off", name: "offHeader");
  }
  // Miscellaneous Headers

  // **** HEADERS END **** //

  // **** ERROR TEXT **** //
  String get priceRequiredError {
    return Intl.message("Price is required",
        desc: 'Error that tells the user that the price is required',
        name: 'priceRequiredError');
  }

  String get amountRequiredError {
    return Intl.message("Amount is required",
        desc: 'Error that tells the user that the amount is required',
        name: 'amountRequiredError');
  }

  String get nameRequiredError {
    return Intl.message("Name is required",
        desc: 'Error that tells the user that the name is required',
        name: 'nameRequiredError');
  }

  String get zeroPriceError {
    return Intl.message("Price can't be 0",
        desc: 'Error that tells the user that the price cant be zero',
        name: 'zeroPriceError');
  }

  String get zeroAmountError {
    return Intl.message("Amount can't be 0",
        desc: 'Error that tells the user that the amount cant be zero',
        name: 'zeroAmountError');
  }

  String get invalidAccountNameError {
    return Intl.message("Invalid account name",
        desc: 'Error that tells the user that the account name is invalid',
        name: 'invalidAccountNameError');
  }

  String get invalidReceivingAccountError {
    return Intl.message("Invalid receiving account",
        desc: 'Error that tells the user that the receiving account is invalid',
        name: 'invalidReceivingAccountError');
  }

  String get invalidPublicKeyError {
    return Intl.message("Invalid public key",
        desc: 'Error that tells the user that the public key is invalid',
        name: 'invalidPublicKeyError');
  }

  String get invalidPrivateKeyError {
    return Intl.message("Invalid private key",
        desc: 'Error that tells the user that the private key is invalid',
        name: 'invalidPrivateKeyError');
  }

  String get invalidAddressError {
    return Intl.message("Invalid address",
        desc: 'Error that tells the user that the address is invalid',
        name: 'invalidAddressError');
  }

  String get invalidAccountError {
    return Intl.message("Invalid account",
        desc: 'Error that tells the user that the account is invalid',
        name: 'invalidAccountError');
  }

  String get invalidDestinationError {
    return Intl.message("Invalid destination",
        desc: 'Error that tells the user that the destination is invalid',
        name: 'invalidDestinationError');
  }

  String get insufficientBalanceError {
    return Intl.message("Insufficient balance",
        desc: 'Error that tells the user that the balance is insufficient',
        name: 'insufficientBalanceError');
  }

  String get threeCharacterNameError {
    return Intl.message("Must be at least 3 characters",
        desc:
            'Error that tells the user that the account name cant be shorter than 3 characters',
        name: 'threeCharacterNameError');
  }

  String get contactDoesntExistError {
    return Intl.message("Contact doesn't exist",
        desc: 'Error that tells the user that the contact doesnt exist',
        name: 'contactDoesntExistError');
  }

  String get contactAlreadyExistsError {
    return Intl.message("Contact already exists",
        desc: 'Error that tells the user that the contact already exists',
        name: 'contactAlreadyExistsError');
  }

  String get cantSendToYourselfError {
    return Intl.message("Can't send to yourself",
        desc: 'Error that tells the user that you cant send to yourself',
        name: 'cantSendToYourselfError');
  }

  String get somethingWentWrongError {
    return Intl.message("Something went wrong, please try again later",
        desc: 'Error that tells the user that something went wrong',
        name: 'somethingWentWrongError');
  }

  String get failedToEncryptPayloadError {
    return Intl.message("Failed to encrypt the payload",
        desc: 'Error that tells the user that payload encrypt is failed',
        name: 'failedToEncryptPayloadError');
  }

  String get emptyPasswordError {
    return Intl.message("Password can't be empty",
        desc: 'Error that tells the user that the password cant be empty',
        name: 'emptyPasswordError');
  }

  String get noMatchPasswordError {
    return Intl.message("Passwords don't match",
        desc: 'Error that tells the user that the passwords dont match',
        name: 'noMatchPasswordError');
  }

  String get invalidPasswordError {
    return Intl.message("Invalid password",
        desc: 'Error that tells the user that the password is invalid',
        name: 'invalidPasswordError');
  }

  String get didNotGetResponseError {
    return Intl.message("Did not get a response from server",
        desc:
            'Error that tells the user that there is no response from the server',
        name: 'didNotGetResponseError');
  }

  String get noContactsToExportError {
    return Intl.message("No contacts to export",
        desc: 'Error that tells the user that there is no contacts to export',
        name: 'noContactsToExportError');
  }

  String get noContactsToImportError {
    return Intl.message("No contacts to import",
        desc: 'Error that tells the user that there is no contacts to import',
        name: 'noContactsToImportError');
  }

  String get failedToImportContactsError {
    return Intl.message("Failed to import contacts",
        desc: 'Error that tells the user that there is no contacts to export',
        name: 'failedToImportContactsError');
  }
  // **** ERROR TEXT END **** //

  // **** OPDETAILS **** //
  String get blockchainRewardOPDetails {
    return Intl.message("Blockchain Reward (%1)",
        desc: 'Operation details header for blockchain reward',
        name: 'blockchainRewardOPDetails');
  }

  String get transactionOPDetails {
    return Intl.message("Transaction (%1)",
        desc: 'Operation details header for transaction',
        name: 'transactionOPDetails');
  }

  String get changeKeyOPDetails {
    return Intl.message("Change key (%1)",
        desc: 'Operation details header for change key',
        name: 'changeKeyOPDetails');
  }

  String get recoverFundsOPDetails {
    return Intl.message("Recover Funds (%1)",
        desc: 'Operation details header for recover funds',
        name: 'recoverFundsOPDetails');
  }

  String get listAccountForSaleOPDetails {
    return Intl.message("List Account for Sale (%1)",
        desc: 'Operation details header for list account for sale',
        name: 'listAccountForSaleOPDetails');
  }

  String get delistAccountOPDetails {
    return Intl.message("Delist Account (%1)",
        desc: 'Operation details header for delist account',
        name: 'delistAccountOPDetails');
  }

  String get buyAccountOPDetails {
    return Intl.message("Buy Account (%1)",
        desc: 'Operation details header for buy account',
        name: 'buyAccountOPDetails');
  }

  String get changeKeySignedOPDetails {
    return Intl.message("Change Key Signed (%1)",
        desc: 'Operation details header for change key signed',
        name: 'changeKeySignedOPDetails');
  }

  String get changeAccountInfoOPDetails {
    return Intl.message("Change Account Info (%1)",
        desc: 'Operation details header for change account info',
        name: 'changeAccountInfoOPDetails');
  }

  String get multioperationOPDetails {
    return Intl.message("Multioperation (%1)",
        desc: 'Operation details header for multioperation',
        name: 'multioperationOPDetails');
  }

  String get unknownOPDetails {
    return Intl.message("Unknown (%1)",
        desc: 'Operation details header for unknown', name: 'unknownOPDetails');
  }

  String get sendingAccountOPDetails {
    return Intl.message("Sending Account",
        desc: 'Operation details header for sending account',
        name: 'sendingAccountOPDetails');
  }

  String get receivingAccountOPDetails {
    return Intl.message("Receiving Account",
        desc: 'Operation details header for receiving account',
        name: 'receivingAccountOPDetails');
  }

  String get changingAccountOPDetails {
    return Intl.message("Changing Account",
        desc: 'Operation details header for changing account',
        name: 'changingAccountOPDetails');
  }

  String get sendAmountOPDetails {
    return Intl.message("Send Amount",
        desc: 'Operation details header for send amount',
        name: 'sendAmountOPDetails');
  }

  String get payloadOPDetails {
    return Intl.message("Payload",
        desc: 'Operation details header for payload', name: 'payloadOPDetails');
  }

  String get newPublicKeyOPDetails {
    return Intl.message("New Public Key",
        desc: 'Operation details header for new public key',
        name: 'newPublicKeyOPDetails');
  }

  String get newNameOPDetails {
    return Intl.message("New Name",
        desc: 'Operation details header for new name',
        name: 'newNameOPDetails');
  }

  String get sellerAccountOPDetails {
    return Intl.message("Seller Account",
        desc: 'Operation details header for seller account',
        name: 'sellerAccountOPDetails');
  }

  String get accountPriceOPDetails {
    return Intl.message("Account Price",
        desc: 'Operation details header for account price',
        name: 'accountPriceOPDetails');
  }

  String get lockedUntilBlockOPDetails {
    return Intl.message("Locked Until Block",
        desc: 'Operation details header for locked until block',
        name: 'lockedUntilBlockOPDetails');
  }

  String get blockOPDetails {
    return Intl.message("block",
        desc: 'Operation details header for block', name: 'blockOPDetails');
  }

  String get optxtOPDetails {
    return Intl.message("optxt",
        desc: 'Operation details header for optxt', name: 'optxtOPDetails');
  }

  String get timeOPDetails {
    return Intl.message("time",
        desc: 'Operation details header for time', name: 'timeOPDetails');
  }

  String get naOPDetails {
    return Intl.message("N/A",
        desc: 'Operation details header for N/A', name: 'naOPDetails');
  }

  String get ophashOPDetails {
    return Intl.message("ophash",
        desc: 'Operation details header for ophash', name: 'ophashOPDetails');
  }

  String get optypeOPDetails {
    return Intl.message("optype",
        desc: 'Operation details header for optype', name: 'optypeOPDetails');
  }

  String get maturationOPDetails {
    return Intl.message("maturation",
        desc: 'Operation details header for maturation',
        name: 'maturationOPDetails');
  }

  String get nullOPDetails {
    return Intl.message("null",
        desc: 'Operation details header for null', name: 'nullOPDetails');
  }

  String get feeOPDetails {
    return Intl.message("fee",
        desc: 'Operation details header for fee', name: 'feeOPDetails');
  }

  String get opblockOPDetails {
    return Intl.message("opblock",
        desc: 'Operation details header for opblock', name: 'opblockOPDetails');
  }

  String get noperationOPDetails {
    return Intl.message("n_operation",
        desc: 'Operation details header for n_operation',
        name: 'noperationOPDetails');
  }

  String get accountOPDetails {
    return Intl.message("account",
        desc: 'Operation details header for account', name: 'accountOPDetails');
  }

  String get signeraccountOPDetails {
    return Intl.message("signer_account",
        desc: 'Operation details header for signer_account',
        name: 'signeraccountOPDetails');
  }
  // **** OPDETAILS END**** //
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
