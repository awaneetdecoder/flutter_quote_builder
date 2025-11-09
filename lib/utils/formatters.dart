// FIX: Changed 'packages' to 'package'
import 'package:intl/intl.dart';

class Formatters {
  // This ensures we get the $ and the correct decimal places.
  static final currency = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
  );

  // You also had an error on this line, it's fixed by the import.
  static final percent = NumberFormat.decimalPercentPattern(
    locale: 'en_US',
    decimalDigits: 0,
  );

  // --- FIX: ADD THIS MISSING METHOD ---
  /// Helper to convert a number to a string, removing trailing .0
  static String numToString(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    }
    return number.toString();
  }
  // --- END OF FIX ---
}