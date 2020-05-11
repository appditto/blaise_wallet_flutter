// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "accountBalanceHeader" : MessageLookupByLibrary.simpleMessage("Account Balance"),
    "accountOPDetails" : MessageLookupByLibrary.simpleMessage("account"),
    "accountPriceOPDetails" : MessageLookupByLibrary.simpleMessage("Account Price"),
    "accountTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Account"),
    "accountToSendFromHeader" : MessageLookupByLibrary.simpleMessage("Account to Send From"),
    "accountsHeader" : MessageLookupByLibrary.simpleMessage("Accounts"),
    "addADurationButton" : MessageLookupByLibrary.simpleMessage("+ Add a Duration"),
    "addAPayloadButton" : MessageLookupByLibrary.simpleMessage("+ Add a Payload"),
    "addContactButton" : MessageLookupByLibrary.simpleMessage("Add Contact"),
    "addContactSheetHeader" : MessageLookupByLibrary.simpleMessage("Add Contact"),
    "addFeeHeader" : MessageLookupByLibrary.simpleMessage("Add Fee"),
    "addToContactsButton" : MessageLookupByLibrary.simpleMessage("Add to Contacts"),
    "addedToContactsParagraph" : MessageLookupByLibrary.simpleMessage("%1 added to contacts"),
    "addressTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Address"),
    "amountRequiredError" : MessageLookupByLibrary.simpleMessage("Amount is required"),
    "amountTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Amount"),
    "areYouSureHeader" : MessageLookupByLibrary.simpleMessage("Are You Sure?"),
    "authenticateOnLaunchHeader" : MessageLookupByLibrary.simpleMessage("Authenticate on Launch"),
    "authenticateToBackUpParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to back up private key"),
    "authenticateToChangeNameParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to change account name to \"%1\""),
    "authenticateToCreatePrivateSaleParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to create private sale"),
    "authenticateToDelistParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to delist the account from sale"),
    "authenticateToListForSaleParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to list account for sale"),
    "authenticateToSendParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to send %1 Pascal"),
    "authenticateToTransferParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to transfer account"),
    "authenticateToUnlockParagraph" : MessageLookupByLibrary.simpleMessage("Authenticate to Unlock Blaise"),
    "authenticationBiometricsHeader" : MessageLookupByLibrary.simpleMessage("Biometrics"),
    "authenticationMethodHeader" : MessageLookupByLibrary.simpleMessage("Authentication Method"),
    "authenticationPINHeader" : MessageLookupByLibrary.simpleMessage("PIN"),
    "automaticallyLockHeader" : MessageLookupByLibrary.simpleMessage("Automatically Lock"),
    "backUpKeyHeader" : MessageLookupByLibrary.simpleMessage("Back Up Your Key!"),
    "backUpPrivateKeyHeader" : MessageLookupByLibrary.simpleMessage("Back Up Private Key"),
    "backUpSheetHeader" : MessageLookupByLibrary.simpleMessage("Back Up"),
    "backupEncryptedKeyFirstParagraph" : MessageLookupByLibrary.simpleMessage("Below is your encrypted private key. It is protected by a password. You can store it safely on a password manager for your convenience."),
    "backupEncryptedKeySecondParagraph" : MessageLookupByLibrary.simpleMessage("Since it is encrypted with your password, if you lose or forget your password, you won\'t be able to decrypt it and access your funds."),
    "backupKeyFirstParagraph" : MessageLookupByLibrary.simpleMessage("You have 2 options for backing up your private key:"),
    "backupKeyFourthParagraph" : MessageLookupByLibrary.simpleMessage("We recommend storing the unencrypted version offline, by writing it on a piece of paper. You can store the encrypted version on a password manager for your convenience."),
    "backupKeySecondParagraph" : MessageLookupByLibrary.simpleMessage("1- Encrypted, which means it is protected by a password."),
    "backupKeyThirdParagraph" : MessageLookupByLibrary.simpleMessage("2- Unencrypted, which means it is raw and not protected by a password."),
    "backupUnencryptedKeyParagraph" : MessageLookupByLibrary.simpleMessage("Below is your unencrypted private key. <colored>It is not protected by a password, which means it is crucial that you store it somewhere safe and offline.</colored> We recommend writing it on a piece of paper."),
    "balanceHeader" : MessageLookupByLibrary.simpleMessage("Balance"),
    "blockOPDetails" : MessageLookupByLibrary.simpleMessage("block"),
    "blockchainRewardOPDetails" : MessageLookupByLibrary.simpleMessage("Blockchain Reward (%1)"),
    "borrowAccountParagraph" : MessageLookupByLibrary.simpleMessage("To buy an account, first you’ll need to borrow one for free. If you send at least <colored>%1 Pascal (%2)</colored> to the account within <colored>%3 days</colored>, the account will be yours and <colored>%1 Pascal</colored> will be deducted from your balance automatically.\nOtherwise, it’ll return back to us at the end of <colored>%3 days</colored> and won’t belong to your wallet anymore.\nIt is recommended you only send a small amount of coins until you own the account."),
    "borrowAnAccountButton" : MessageLookupByLibrary.simpleMessage("Borrow An Account"),
    "borrowStarted" : MessageLookupByLibrary.simpleMessage("Purchase Started for %1"),
    "borrowedAccountHeader" : MessageLookupByLibrary.simpleMessage("Borrowed Account"),
    "borrowedAccountPaidParagraph" : MessageLookupByLibrary.simpleMessage("<colored>Your account has been purchased!</colored>\nThe transfer is currently processing. This process usually takes about <colored>15 minutes</colored>, in some cases it may take slightly longer."),
    "borrowedAccountParagraph" : MessageLookupByLibrary.simpleMessage("This is a <colored>borrowed account</colored>.\nIf you send at least <colored>%1 Pascal</colored> to it in the next <colored>%2 days, %3 hours, and %4 minutes</colored>, it’ll be yours."),
    "borrowedHeader" : MessageLookupByLibrary.simpleMessage("Borrowed"),
    "borrowedTransferredHeader" : MessageLookupByLibrary.simpleMessage("Transfer Pending"),
    "buyAccountOPDetails" : MessageLookupByLibrary.simpleMessage("Buy Account (%1)"),
    "buyAccountSheetHeader" : MessageLookupByLibrary.simpleMessage("Buy Account"),
    "buyAnAccountButton" : MessageLookupByLibrary.simpleMessage("Buy an Account"),
    "cancelButton" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "cantSendToYourselfError" : MessageLookupByLibrary.simpleMessage("Can\'t send to yourself"),
    "changeAccountInfoOPDetails" : MessageLookupByLibrary.simpleMessage("Change Account Info (%1)"),
    "changeAccountNameHeader" : MessageLookupByLibrary.simpleMessage("Change Account Name"),
    "changeDaemonButton" : MessageLookupByLibrary.simpleMessage("Change Daemon"),
    "changeDaemonParagraph" : MessageLookupByLibrary.simpleMessage("Enter an address to use a different Pascal daemon for RPC requests."),
    "changeDaemonSheetHeader" : MessageLookupByLibrary.simpleMessage("Change Daemon"),
    "changeKeyOPDetails" : MessageLookupByLibrary.simpleMessage("Change key (%1)"),
    "changeKeySignedOPDetails" : MessageLookupByLibrary.simpleMessage("Change Key Signed (%1)"),
    "changeNameButton" : MessageLookupByLibrary.simpleMessage("Change Name"),
    "changeNameParagraph" : MessageLookupByLibrary.simpleMessage("Enter a name below to change your account\'s name."),
    "changeNameSheetHeader" : MessageLookupByLibrary.simpleMessage("Change Name"),
    "changedNameParagraph" : MessageLookupByLibrary.simpleMessage("Your account name has been changed successfully."),
    "changedNameSheetHeader" : MessageLookupByLibrary.simpleMessage("Changed"),
    "changingAccountOPDetails" : MessageLookupByLibrary.simpleMessage("Changing Account"),
    "changingNameParagraph" : MessageLookupByLibrary.simpleMessage("Confirm your new account name to proceed."),
    "changingNameSheetHeader" : MessageLookupByLibrary.simpleMessage("Changing"),
    "checkOutBlaiseParagraph" : MessageLookupByLibrary.simpleMessage("Check out Blaise! Simple, sleek & secure Pascal wallet for iOS and Android: https://blaisewallet.com"),
    "closeButton" : MessageLookupByLibrary.simpleMessage("Close"),
    "confirmButton" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPINParagraph" : MessageLookupByLibrary.simpleMessage("Confirm your PIN"),
    "confirmPasswordTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmationCodeError" : MessageLookupByLibrary.simpleMessage("Failed to verify code, ensure you\'ve entered it correctly"),
    "confirmationCodeTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Confirmation Code"),
    "connectingHeader" : MessageLookupByLibrary.simpleMessage("Connecting"),
    "contactAlreadyExistsError" : MessageLookupByLibrary.simpleMessage("Contact already exists"),
    "contactDoesntExistError" : MessageLookupByLibrary.simpleMessage("Contact doesn\'t exist"),
    "contactNameTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Contact Name"),
    "contactSheetHeader" : MessageLookupByLibrary.simpleMessage("Contact"),
    "contactsHeader" : MessageLookupByLibrary.simpleMessage("Contacts"),
    "copiedAddressButton" : MessageLookupByLibrary.simpleMessage("Address Copied"),
    "copiedButton" : MessageLookupByLibrary.simpleMessage("Copied"),
    "copyAddressButton" : MessageLookupByLibrary.simpleMessage("Copy Address"),
    "copyButton" : MessageLookupByLibrary.simpleMessage("Copy"),
    "copyEncryptedKeyButton" : MessageLookupByLibrary.simpleMessage("Copy Encrypted Key"),
    "copyKeyButton" : MessageLookupByLibrary.simpleMessage("Copy Key"),
    "copyPublicKeyButton" : MessageLookupByLibrary.simpleMessage("Copy Public Key"),
    "copyUnencryptedKeyButton" : MessageLookupByLibrary.simpleMessage("Copy Unencrypted Key"),
    "countryCodeTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Country Code"),
    "createPINParagraph" : MessageLookupByLibrary.simpleMessage("Create a 6-digit PIN"),
    "createPrivateSaleButton" : MessageLookupByLibrary.simpleMessage("Create Private Sale"),
    "createPrivateSaleHeader" : MessageLookupByLibrary.simpleMessage("Create Private Sale"),
    "createPrivateSaleParagraph" : MessageLookupByLibrary.simpleMessage("Enter a price, a receiving account, and a public key below to create a private sale for this account."),
    "createPrivateSaleSheetHeader" : MessageLookupByLibrary.simpleMessage("Private Sale"),
    "createdPrivateSaleParagraph" : MessageLookupByLibrary.simpleMessage("The private sale has been created successfully. We’ll let you know if it is bought."),
    "createdPrivateSaleSheetHeader" : MessageLookupByLibrary.simpleMessage("Created"),
    "creatingPrivateSaleParagraph" : MessageLookupByLibrary.simpleMessage("Confirm the information below."),
    "creatingPrivateSaleSheetHeader" : MessageLookupByLibrary.simpleMessage("Creating"),
    "currencyHeader" : MessageLookupByLibrary.simpleMessage("Currency"),
    "daemonHeader" : MessageLookupByLibrary.simpleMessage("Daemon"),
    "decryptAndImportKeyHeader" : MessageLookupByLibrary.simpleMessage("Decrypt & Import"),
    "defaultHeader" : MessageLookupByLibrary.simpleMessage("Default"),
    "deletePrivateKeyAndLogoutButton" : MessageLookupByLibrary.simpleMessage("Delete Private Key\nAnd Logout"),
    "delistAccountOPDetails" : MessageLookupByLibrary.simpleMessage("Delist Account (%1)"),
    "delistFromSaleHeader" : MessageLookupByLibrary.simpleMessage("Delist From Sale"),
    "delistFromSaleParagraph" : MessageLookupByLibrary.simpleMessage("Confirm that you would like to delist this account from sale."),
    "delistedFromSaleHeader" : MessageLookupByLibrary.simpleMessage("Delisted From Sale"),
    "delistedFromSaleParagraph" : MessageLookupByLibrary.simpleMessage("Your account has been successfully delisted from sale."),
    "delistedHeader" : MessageLookupByLibrary.simpleMessage("Delisted"),
    "delistedSheetHeader" : MessageLookupByLibrary.simpleMessage("Delisted"),
    "delistingSheetHeader" : MessageLookupByLibrary.simpleMessage("Delisting"),
    "didNotGetResponseError" : MessageLookupByLibrary.simpleMessage("Did not get a response from server"),
    "durationTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Duration"),
    "emptyPasswordError" : MessageLookupByLibrary.simpleMessage("Password can\'t be empty"),
    "encryptButton" : MessageLookupByLibrary.simpleMessage("Encrypt"),
    "encryptKeyParagraph" : MessageLookupByLibrary.simpleMessage("Create a new password to encrypt your private key."),
    "encryptPayloadHeader" : MessageLookupByLibrary.simpleMessage("Encrypt Payload"),
    "encryptSheetHeader" : MessageLookupByLibrary.simpleMessage("Encrypt"),
    "encryptThePayloadHeader" : MessageLookupByLibrary.simpleMessage("Encrypt the Payload"),
    "encryptedKeyButton" : MessageLookupByLibrary.simpleMessage("Encrypted Key"),
    "enterConfirmationCodeParagraph" : MessageLookupByLibrary.simpleMessage("We have sent you a confirmation code, please enter it below."),
    "enterPINParagraph" : MessageLookupByLibrary.simpleMessage("Enter PIN"),
    "enterPINToUnlockParagraph" : MessageLookupByLibrary.simpleMessage("Enter PIN to unlock Blaise"),
    "enterPhoneNumberParagraph" : MessageLookupByLibrary.simpleMessage("Enter your phone number below."),
    "failedToEncryptPayloadError" : MessageLookupByLibrary.simpleMessage("Failed to encrypt the payload"),
    "failedToImportContactsError" : MessageLookupByLibrary.simpleMessage("Failed to import contacts"),
    "failedToRemoveFromContactsParagraph" : MessageLookupByLibrary.simpleMessage("Failed to remove %1 from contacts"),
    "feeColonHeader" : MessageLookupByLibrary.simpleMessage("Fee:"),
    "feeConfirmAmountParagraph" : MessageLookupByLibrary.simpleMessage("Please confirm the addition of %1 Pascal fee to this operation to continue."),
    "feeOPDetails" : MessageLookupByLibrary.simpleMessage("fee"),
    "feeRequiredParagraph" : MessageLookupByLibrary.simpleMessage("This operation requires a fee."),
    "feeTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Fee"),
    "forSaleHeader" : MessageLookupByLibrary.simpleMessage("For Sale"),
    "freeAccountSheetHeader" : MessageLookupByLibrary.simpleMessage("Free Account"),
    "freepasaComplete" : MessageLookupByLibrary.simpleMessage("Success, your new account will be available after 1 network confirmation"),
    "getAFreeAccountButton" : MessageLookupByLibrary.simpleMessage("Get a Free Account"),
    "getAccountFirstParagraph" : MessageLookupByLibrary.simpleMessage("There are 2 options for getting your first account:"),
    "getAccountSecondParagraph" : MessageLookupByLibrary.simpleMessage("1- You can get a free account using your phone number. <colored>Only 1 account per phone number is allowed.</colored>"),
    "getAccountSheetHeader" : MessageLookupByLibrary.simpleMessage("Get Account"),
    "getAccountThirdParagraph" : MessageLookupByLibrary.simpleMessage("2- You can buy as many accounts as you want for <colored>%1 Pascal (%2).</colored>"),
    "getAccountThirdParagraphAlternative" : MessageLookupByLibrary.simpleMessage("2- You can buy an account for <colored>%1 Pascal (%2).</colored><colored> Buying only 1 account is allowed per user.</colored>"),
    "getAccountThirdParagraphAlternative2" : MessageLookupByLibrary.simpleMessage("2- You can buy an account for <colored>%1 Pascal (%2).</colored><colored> You can buy up to %3 accounts.</colored>"),
    "getAnAccountButton" : MessageLookupByLibrary.simpleMessage("Get an Account"),
    "goBackButton" : MessageLookupByLibrary.simpleMessage("Go Back"),
    "gotItButton" : MessageLookupByLibrary.simpleMessage("Got It!"),
    "hideButton" : MessageLookupByLibrary.simpleMessage("Hide"),
    "iHaveBackedItUpButton" : MessageLookupByLibrary.simpleMessage("I\'ve Backed It Up"),
    "importButton" : MessageLookupByLibrary.simpleMessage("Import"),
    "importPrivateKeyButton" : MessageLookupByLibrary.simpleMessage("Import Private Key"),
    "importPrivateKeyHeader" : MessageLookupByLibrary.simpleMessage("Import Private Key"),
    "importPrivateKeyParagraph" : MessageLookupByLibrary.simpleMessage("Enter your private key below."),
    "insufficientBalanceError" : MessageLookupByLibrary.simpleMessage("Insufficient balance"),
    "invalidAccountError" : MessageLookupByLibrary.simpleMessage("Invalid account"),
    "invalidAccountNameError" : MessageLookupByLibrary.simpleMessage("Invalid account name"),
    "invalidAddressError" : MessageLookupByLibrary.simpleMessage("Invalid address"),
    "invalidDestinationError" : MessageLookupByLibrary.simpleMessage("Invalid destination"),
    "invalidPINParagraph" : MessageLookupByLibrary.simpleMessage("Invalid PIN"),
    "invalidPasswordError" : MessageLookupByLibrary.simpleMessage("Invalid password"),
    "invalidPhoneNumberParagraph" : MessageLookupByLibrary.simpleMessage("Phone number is not valid"),
    "invalidPrivateKeyError" : MessageLookupByLibrary.simpleMessage("Invalid private key"),
    "invalidPublicKeyError" : MessageLookupByLibrary.simpleMessage("Invalid public key"),
    "invalidReceivingAccountError" : MessageLookupByLibrary.simpleMessage("Invalid receiving account"),
    "keyCopiedButton" : MessageLookupByLibrary.simpleMessage("Key Copied"),
    "keyTypeNotSupportedHeader" : MessageLookupByLibrary.simpleMessage("Key Not Supported"),
    "keyTypeNotSupportedParagraph" : MessageLookupByLibrary.simpleMessage("This type of private key is not yet supported by Blaise. You may create a new private key and transfer your accounts to it using a different wallet."),
    "languageColonHeader" : MessageLookupByLibrary.simpleMessage("Language:"),
    "languageHeader" : MessageLookupByLibrary.simpleMessage("Language"),
    "listAccountForSaleHeader" : MessageLookupByLibrary.simpleMessage("List Account For Sale"),
    "listAccountForSaleOPDetails" : MessageLookupByLibrary.simpleMessage("List Account for Sale (%1)"),
    "listForSaleButton" : MessageLookupByLibrary.simpleMessage("List for Sale"),
    "listForSaleParagraph" : MessageLookupByLibrary.simpleMessage("Enter a price and an account that will be receiving the payment to list this account for sale."),
    "listForSaleSheetHeader" : MessageLookupByLibrary.simpleMessage("List For Sale"),
    "listedForSaleHeader" : MessageLookupByLibrary.simpleMessage("Listed For Sale"),
    "listedForSaleParagraph" : MessageLookupByLibrary.simpleMessage("Your account has been successfully listed for sale. We’ll let you know if someone buys it."),
    "listedForSaleSheetHeader" : MessageLookupByLibrary.simpleMessage("Listed"),
    "listingForSaleParagraph" : MessageLookupByLibrary.simpleMessage("Confirm the price and the account that will be receiving the payment."),
    "listingForSaleSheetHeader" : MessageLookupByLibrary.simpleMessage("Listing"),
    "liveSupportButton" : MessageLookupByLibrary.simpleMessage("Support"),
    "lock15Header" : MessageLookupByLibrary.simpleMessage("After %1 minutes"),
    "lock1Header" : MessageLookupByLibrary.simpleMessage("After %1 minute"),
    "lock30Header" : MessageLookupByLibrary.simpleMessage("After %1 minutes"),
    "lock5Header" : MessageLookupByLibrary.simpleMessage("After %1 minutes"),
    "lock60Header" : MessageLookupByLibrary.simpleMessage("After %1 minutes"),
    "lockInstantHeader" : MessageLookupByLibrary.simpleMessage("Instantly"),
    "lockedHeader" : MessageLookupByLibrary.simpleMessage("Locked"),
    "lockedUntilBlockOPDetails" : MessageLookupByLibrary.simpleMessage("Locked Until Block"),
    "logoutFirstDisclaimerParagraph" : MessageLookupByLibrary.simpleMessage("<colored>Logging out will remove your private key and all Blaise related data from this device.</colored> If your private key is not backed up, you will never be able to access your funds again. If your private key is backed up, you have nothing to worry about."),
    "logoutHeader" : MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutSecondDisclaimerParagraph" : MessageLookupByLibrary.simpleMessage("Are you sure that you\'ve backed up your private key? <colored>As long as you\'ve backed up your private key, you have nothing to worry about.</colored>"),
    "looksLikeEncryptedKeyParagraph" : MessageLookupByLibrary.simpleMessage("This looks like an encrypted private key, please enter the password to decrypt and import it."),
    "manageHeader" : MessageLookupByLibrary.simpleMessage("Manage"),
    "manyFailedAttemptsParagraph" : MessageLookupByLibrary.simpleMessage("Too many failed unlock attempts"),
    "maturationOPDetails" : MessageLookupByLibrary.simpleMessage("maturation"),
    "multioperationOPDetails" : MessageLookupByLibrary.simpleMessage("Multioperation (%1)"),
    "naOPDetails" : MessageLookupByLibrary.simpleMessage("N/A"),
    "nameChangedHeader" : MessageLookupByLibrary.simpleMessage("Name Changed"),
    "nameRequiredError" : MessageLookupByLibrary.simpleMessage("Name is required"),
    "nameTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Name"),
    "newAccountNameTextFieldHeader" : MessageLookupByLibrary.simpleMessage("New Account Name"),
    "newAccountParagraph" : MessageLookupByLibrary.simpleMessage("This is your new account.\nOnce you receive <colored>Pascal</colored>, operations will show up like below."),
    "newKeyBackUpConfirmParagraph" : MessageLookupByLibrary.simpleMessage("Are you sure that you have backed up your new wallet’s private key?"),
    "newKeySecurityParagraph" : MessageLookupByLibrary.simpleMessage("In the next screen, you\'ll see your new private key. It is a password to access your funds. It is crucial that you back it up and never share it with anyone."),
    "newNameOPDetails" : MessageLookupByLibrary.simpleMessage("New Name"),
    "newPasswordTextFieldHeader" : MessageLookupByLibrary.simpleMessage("New Password"),
    "newPrivateKeyButton" : MessageLookupByLibrary.simpleMessage("New Private Key"),
    "newPrivateKeyHeader" : MessageLookupByLibrary.simpleMessage("New Private Key"),
    "newPrivateKeyParagraph" : MessageLookupByLibrary.simpleMessage("Below is your new wallet’s private key. It is crucial that you backup your private key and never store it as plaintext or a screenshot. We recommend writing it on a piece of paper and storing it offline."),
    "newPublicKeyOPDetails" : MessageLookupByLibrary.simpleMessage("New Public Key"),
    "newWalletGreetingParagraph" : MessageLookupByLibrary.simpleMessage("Welcome to <colored>Blaise Wallet</colored>.\nYou can start by getting an account."),
    "nextButton" : MessageLookupByLibrary.simpleMessage("Next"),
    "noContactsToExportError" : MessageLookupByLibrary.simpleMessage("No contacts to export"),
    "noContactsToImportError" : MessageLookupByLibrary.simpleMessage("No contacts to import"),
    "noGoBackButton" : MessageLookupByLibrary.simpleMessage("No, Go Back"),
    "noHeader" : MessageLookupByLibrary.simpleMessage("No"),
    "noMatchPINParagraph" : MessageLookupByLibrary.simpleMessage("PINs do not match"),
    "noMatchPasswordError" : MessageLookupByLibrary.simpleMessage("Passwords don\'t match"),
    "noResultsFound" : MessageLookupByLibrary.simpleMessage("No results found"),
    "noperationOPDetails" : MessageLookupByLibrary.simpleMessage("n_operation"),
    "notificationsHeader" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "nullOPDetails" : MessageLookupByLibrary.simpleMessage("null"),
    "offHeader" : MessageLookupByLibrary.simpleMessage("Off"),
    "okayButton" : MessageLookupByLibrary.simpleMessage("Okay"),
    "okayGoBackButton" : MessageLookupByLibrary.simpleMessage("Okay, Go Back"),
    "onHeader" : MessageLookupByLibrary.simpleMessage("On"),
    "opblockOPDetails" : MessageLookupByLibrary.simpleMessage("opblock"),
    "openInExplorerButton" : MessageLookupByLibrary.simpleMessage("Open in Explorer"),
    "operationDetailsButton" : MessageLookupByLibrary.simpleMessage("Operation Details"),
    "operationsHeader" : MessageLookupByLibrary.simpleMessage("Operations"),
    "ophashOPDetails" : MessageLookupByLibrary.simpleMessage("ophash"),
    "optxtOPDetails" : MessageLookupByLibrary.simpleMessage("optxt"),
    "optypeOPDetails" : MessageLookupByLibrary.simpleMessage("optype"),
    "otherOperationsHeader" : MessageLookupByLibrary.simpleMessage("Other Operations"),
    "passwordTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Password"),
    "payloadOPDetails" : MessageLookupByLibrary.simpleMessage("Payload"),
    "payloadTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Payload"),
    "pendingHeader" : MessageLookupByLibrary.simpleMessage("Pending"),
    "phoneNumberTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "preferencesHeader" : MessageLookupByLibrary.simpleMessage("Preferences"),
    "priceRequiredError" : MessageLookupByLibrary.simpleMessage("Price is required"),
    "priceTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Price"),
    "privacyPolicyHeader" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privateKeySheetHeader" : MessageLookupByLibrary.simpleMessage("Private Key"),
    "privateKeyTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Private Key"),
    "privateSaleHeader" : MessageLookupByLibrary.simpleMessage("Private Sale"),
    "publicKeyParagraph" : MessageLookupByLibrary.simpleMessage("Below is your public key. As the name suggests, it is intended to be shared publicly and prove that a particular operation belongs to your private key."),
    "publicKeySheetHeader" : MessageLookupByLibrary.simpleMessage("Public Key"),
    "publicKeyTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Public Key"),
    "receiveAccountButton" : MessageLookupByLibrary.simpleMessage("Receive Account"),
    "receiveAnAccountButton" : MessageLookupByLibrary.simpleMessage("Receive an Account"),
    "receiveButton" : MessageLookupByLibrary.simpleMessage("Receive"),
    "receivedHeader" : MessageLookupByLibrary.simpleMessage("Received"),
    "receivingAccountOPDetails" : MessageLookupByLibrary.simpleMessage("Receiving Account"),
    "receivingAccountTextFieldHeader" : MessageLookupByLibrary.simpleMessage("Receiving Account"),
    "recoverFundsOPDetails" : MessageLookupByLibrary.simpleMessage("Recover Funds (%1)"),
    "removedFromContactsParagraph" : MessageLookupByLibrary.simpleMessage("Removed %1 from contacts"),
    "requestButton" : MessageLookupByLibrary.simpleMessage("Request"),
    "requestSheetHeader" : MessageLookupByLibrary.simpleMessage("Request"),
    "scanQRCodeButton" : MessageLookupByLibrary.simpleMessage("Scan QR Code"),
    "searchAccountNameButton" : MessageLookupByLibrary.simpleMessage("Search Account Name"),
    "searchForNameButton" : MessageLookupByLibrary.simpleMessage("Search For Name"),
    "searchNameButton" : MessageLookupByLibrary.simpleMessage("Search Name"),
    "securityFirstHeader" : MessageLookupByLibrary.simpleMessage("Security First!"),
    "securityHeader" : MessageLookupByLibrary.simpleMessage("Security"),
    "sellerAccountOPDetails" : MessageLookupByLibrary.simpleMessage("Seller Account"),
    "sendAmountOPDetails" : MessageLookupByLibrary.simpleMessage("Send Amount"),
    "sendButton" : MessageLookupByLibrary.simpleMessage("Send"),
    "sendConfirmationButton" : MessageLookupByLibrary.simpleMessage("Send Confirmation"),
    "sendSheetHeader" : MessageLookupByLibrary.simpleMessage("Send"),
    "sendingAccountOPDetails" : MessageLookupByLibrary.simpleMessage("Sending Account"),
    "sendingConfirmParagraph" : MessageLookupByLibrary.simpleMessage("Confirm the transaction details to send."),
    "sendingSheetHeader" : MessageLookupByLibrary.simpleMessage("Sending"),
    "sentHeader" : MessageLookupByLibrary.simpleMessage("Sent"),
    "sentParagraph" : MessageLookupByLibrary.simpleMessage("Transaction has been sent succesfully."),
    "sentSheetHeader" : MessageLookupByLibrary.simpleMessage("Sent"),
    "setToDefaultButton" : MessageLookupByLibrary.simpleMessage("Set to Default"),
    "settingsHeader" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shareHeader" : MessageLookupByLibrary.simpleMessage("Share Blaise"),
    "showButton" : MessageLookupByLibrary.simpleMessage("Show"),
    "signeraccountOPDetails" : MessageLookupByLibrary.simpleMessage("signer_account"),
    "somethingWentWrongError" : MessageLookupByLibrary.simpleMessage("Something went wrong, please try again later"),
    "successfullyImportedContactsParagraph" : MessageLookupByLibrary.simpleMessage("Successfully imported %1 contacts"),
    "supportButton" : MessageLookupByLibrary.simpleMessage("Support"),
    "systemDefaultHeader" : MessageLookupByLibrary.simpleMessage("System Default"),
    "themeCopperHeader" : MessageLookupByLibrary.simpleMessage("Copper"),
    "themeDarkHeader" : MessageLookupByLibrary.simpleMessage("Dark"),
    "themeHeader" : MessageLookupByLibrary.simpleMessage("Theme"),
    "themeLightHeader" : MessageLookupByLibrary.simpleMessage("Light"),
    "threeCharacterNameError" : MessageLookupByLibrary.simpleMessage("Must be at least 3 characters"),
    "timeOPDetails" : MessageLookupByLibrary.simpleMessage("time"),
    "totalBalanceHeader" : MessageLookupByLibrary.simpleMessage("Total Balance"),
    "transactionOPDetails" : MessageLookupByLibrary.simpleMessage("Transaction (%1)"),
    "transferAccountHeader" : MessageLookupByLibrary.simpleMessage("Transfer Account"),
    "transferButton" : MessageLookupByLibrary.simpleMessage("Transfer"),
    "transferParagraph" : MessageLookupByLibrary.simpleMessage("Enter a public key below to transfer the ownership of this account to it."),
    "transferSheetHeader" : MessageLookupByLibrary.simpleMessage("Transfer"),
    "transferredHeader" : MessageLookupByLibrary.simpleMessage("Transferred"),
    "transferredParagraph" : MessageLookupByLibrary.simpleMessage("Your account has been transferred successfully to the public key below."),
    "transferredSheetHeader" : MessageLookupByLibrary.simpleMessage("Transferred"),
    "transferringParagraph" : MessageLookupByLibrary.simpleMessage("Confirm the public key below to transfer the ownership of this account to it."),
    "transferringSheetHeader" : MessageLookupByLibrary.simpleMessage("Transferring"),
    "unconfirmedAccountHeader" : MessageLookupByLibrary.simpleMessage("Unconfirmed Account"),
    "unconfirmedAccountParagraph" : MessageLookupByLibrary.simpleMessage("This is an <colored>unconfirmed account</colored>. It has been transferred to you, but there needs to be 1 network confirmation before you can use it. This usually takes about 5 minutes, once it\'s complete you\'ll be able to use this account."),
    "undefinedHeader" : MessageLookupByLibrary.simpleMessage("Undefined"),
    "unencryptedKeyButton" : MessageLookupByLibrary.simpleMessage("Unencrypted Key"),
    "uninstallDisclaimerParagraph" : MessageLookupByLibrary.simpleMessage("If you lose your device or uninstall Blaise Wallet, you\'ll need your private key to recover your funds."),
    "unknownOPDetails" : MessageLookupByLibrary.simpleMessage("Unknown (%1)"),
    "unlockButton" : MessageLookupByLibrary.simpleMessage("Unlock"),
    "unlockWithBiometricsButton" : MessageLookupByLibrary.simpleMessage("Unlock with Biometrics"),
    "unlockWithPINButton" : MessageLookupByLibrary.simpleMessage("Unlock with PIN"),
    "urlChangedToParagraph" : MessageLookupByLibrary.simpleMessage("URL changed to %1"),
    "viewPublicKeyHeader" : MessageLookupByLibrary.simpleMessage("View Public Key"),
    "warningHeader" : MessageLookupByLibrary.simpleMessage("Warning"),
    "welcomeParagraph" : MessageLookupByLibrary.simpleMessage("Welcome to Blaise Wallet. To begin, you can create a new private key or import one."),
    "yesAddFeeButton" : MessageLookupByLibrary.simpleMessage("Yes, Add Fee"),
    "yesHeader" : MessageLookupByLibrary.simpleMessage("Yes"),
    "yesImSureButton" : MessageLookupByLibrary.simpleMessage("Yes, I\'m Sure"),
    "zeroAmountError" : MessageLookupByLibrary.simpleMessage("Amount can\'t be 0"),
    "zeroPriceError" : MessageLookupByLibrary.simpleMessage("Price can\'t be 0")
  };
}
