import 'dart:math';

import 'package:decimal/decimal.dart';

class NumberUtil {
  static const int maxDecimalDigits = 4;

  /// Truncate a Decimal to a specific amount of digits
  ///
  /// @param input 1.059
  /// @return double value 1.05
  ///
  static double truncateDecimal(Decimal input, {int digits = maxDecimalDigits}) {
    return (input * Decimal.fromInt(pow(10, digits))).truncateToDouble() / pow(10, digits);
  }

  /// Sanitize a number as something that can actually
  /// be parsed. Expects "." to be decimal separator
  /// @param amount $1,512
  /// @returns 1.512
  static String sanitizeNumber(String input, {int maxDecimalDigits = maxDecimalDigits}) {
    String sanitized = "";
    List<String> splitStr = input.split(".");
    if (splitStr.length > 1) {
      if (splitStr[1].length > maxDecimalDigits) {
        splitStr[1] = splitStr[1].substring(0, maxDecimalDigits);
        input = splitStr[0] + "." + splitStr[1];
      }
    }
    for (int i=0; i< input.length; i++) {
      try {
        if (input[i] == ".") {
          sanitized = sanitized + input[i];
        } else {
          int.parse(input[i]);
          sanitized = sanitized + input[i];
        }
      } catch (e) { }
    }
    return sanitized;
  }
}