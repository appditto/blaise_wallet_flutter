import 'package:blaise_wallet_flutter/util/number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// For Pascal Accounts
class PascalAccountFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Ensure only one - is present
    if (newValue.text.isNotEmpty && newValue.text.allMatches('-').length > 1) {
      return oldValue;
    } else if (newValue.text.isNotEmpty && newValue.text.contains('-')) {
      // Ensure only two digits after "-"
      if (newValue.text.length - newValue.text.indexOf('-') > 3) {
        return oldValue;
      }  
    }
    return newValue;
  }
}

/// For Pascal Names
class PascalNameFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Ensure first character is not a number
    if (newValue.text.startsWith(RegExp(r"[0-9]"))) {
      return oldValue;
    }
    return newValue;
  }
}

/// For phone numbers
/// Ensures no more than 20 digits
/// Ensures hyphens only occur after a number
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Check digit count, 20 is max
    if (newValue.text.replaceAll(RegExp(r"[^0-9]"), "").length > 20) {
      return oldValue;
    }
    // Ensure only 1 hyphen after a number
    if (newValue.text.endsWith("-") && oldValue.text.endsWith("-")) {
      return oldValue;
    }
    return newValue;
  }
}

/// Input formatter for Crpto/Fiat amounts
class CurrencyFormatter extends TextInputFormatter {

  String commaSeparator;
  String decimalSeparator;
  int maxDecimalDigits;

  CurrencyFormatter({this.commaSeparator = ",", this.decimalSeparator = ".", this.maxDecimalDigits = NumberUtil.maxDecimalDigits});

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    bool returnOriginal = true;
    if (newValue.text.contains(decimalSeparator) || newValue.text.contains(commaSeparator)) {
      returnOriginal = false;
    }

    // If no text, or text doesnt contain a period of comma, no work to do here
    if(newValue.selection.baseOffset == 0 || returnOriginal) {
      return newValue;
    }

    String workingText = newValue.text.replaceAll(commaSeparator, decimalSeparator);
    // if contains more than 2 decimals in newValue, return oldValue
    if (decimalSeparator.allMatches(workingText).length > 1) {
      return newValue.copyWith(
        text: oldValue.text,
        selection: new TextSelection.collapsed(offset: oldValue.text.length));
    } else if (workingText.startsWith(decimalSeparator)) {
      workingText = "0" + workingText;
    }

    List<String> splitStr = workingText.split(decimalSeparator);
    // If this string contains more than 1 decimal, move all characters to after the first decimal
    if (splitStr.length > 2) {
      returnOriginal = false;
      splitStr.forEach((val) {
        if (splitStr.indexOf(val) > 1) {
          splitStr[1] += val;
        }
      });
    }
    if (splitStr[1].length <= maxDecimalDigits) {
      if (workingText == newValue.text) {
        return newValue;
      } else {
        return newValue.copyWith(
          text: workingText,
          selection: new TextSelection.collapsed(offset: workingText.length));
       }
    }
    String newText = splitStr[0] + decimalSeparator + splitStr[1].substring(0, maxDecimalDigits);
    return newValue.copyWith(
      text: newText,
      selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class LocalCurrencyFormatter extends TextInputFormatter {
  NumberFormat currencyFormat;
  bool active;

  LocalCurrencyFormatter({this.currencyFormat, this.active});

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      // Return empty string
      return newValue.copyWith(
        text: "",
        selection: new TextSelection.collapsed(offset: 0));
    }
    // Ensure our input is in the right formatting here
    if (active) {
      // Make local currency = amount with correct decimal separator
      String curText = newValue.text;
      String shouldBeText = NumberUtil.sanitizeNumber(curText.replaceAll(",", "."));
      shouldBeText = shouldBeText.replaceAll(".", currencyFormat.symbols.DECIMAL_SEP);
      if (shouldBeText != curText) {
        return newValue.copyWith(
          text: shouldBeText,
          selection: TextSelection.collapsed(offset: shouldBeText.length));
      }
    } else {
      // Make crypto amount formatted as US locale
      String curText = newValue.text;
      String shouldBeText = NumberUtil.sanitizeNumber(curText.replaceAll(",", "."));
      if (shouldBeText != curText) {
        return newValue.copyWith(
          text: shouldBeText,
          selection: TextSelection.collapsed(offset: shouldBeText.length));
      }
    }
    return newValue;
  }
}


/// Ensures input is always uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// Ensures input is always lowercase
class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toLowerCase(),
      selection: newValue.selection,
    );
  }
}