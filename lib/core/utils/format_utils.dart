class FormatUtils {
  static String formatIrishPhoneNumber(String input) {
    // Remove all non-digit characters
    String digits = input.replaceAll(RegExp(r'\D'), '');

    // Handle numbers starting with '08'
    if (digits.startsWith('08') && digits.length == 10) {
      return '+353${digits.substring(1)}';
    }

    // Handle already formatted E.164: +3538xxxxxxxx
    if (digits.startsWith('353') && digits.length == 12) {
      return '+$digits';
    }

    // Not a valid Irish mobile number pattern
    throw FormatException('Invalid Irish phone number format.');
  }
}
