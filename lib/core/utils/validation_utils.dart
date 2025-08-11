import 'package:email_validator/email_validator.dart';

class ValidationUtils {
  static bool validateFullName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return false;
    }

    final trimmedName = fullName.trim();

    if (trimmedName.length < 5) {
      return false;
    }

    final nameParts = trimmedName.split(RegExp(r'\s+'));
    if (nameParts.length < 2) {
      return false;
    }

    final nameRegex = RegExp(r"^[\p{L}'-]+$", unicode: true);

    for (final part in nameParts) {
      if (part.length < 2) {
        return false;
      }
      if (!nameRegex.hasMatch(part)) {
        return false;
      }
    }
    return true;
  }

  static bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  static bool validatePassword(String password) {
    if (password.length < 6) return false; // Too short
    if (!RegExp(r'[A-Za-z]').hasMatch(password)) return false; // No letters
    if (!RegExp(r'[0-9]').hasMatch(password)) return false; // No numbers
    return true; //
  }

  static bool validateMobileNumber(String mobileNumber) {
    final regex = RegExp(r'^(?:\+353|0)8[3-9]\d{7}$');
    return regex.hasMatch(mobileNumber);
  }

  static bool validateIrishLandline(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\s+|-'), '');
    final regex = RegExp(r'^(?:\+353|0)[1-9]\d{1,3}\d{5,7}$');
    return regex.hasMatch(cleaned);
  }
}
