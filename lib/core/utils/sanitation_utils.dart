class SanitationUtils {
  static String sanitiseMobileNumber(String rawNumber) {
    return rawNumber.replaceAll(RegExp(r'\s+|-'), '');
  }
}
