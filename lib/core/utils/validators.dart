class Validators {
  /// Normalizes Arabic-Indic digits (٠-٩) to Western Arabic digits (0-9).
  static String normalizeDigits(String input) {
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    const english = '0123456789';
    String result = input;
    for (int i = 0; i < arabic.length; i++) {
      result = result.replaceAll(arabic[i], english[i]);
    }
    return result;
  }

  /// Validates Egyptian mobile phone numbers in multiple standard formats:
  /// - 11 digits starting with 010, 011, 012, 015 (e.g. 01012345678)
  /// - 10 digits without leading 0 (e.g. 1012345678, 1110057671)
  /// - With country code (+201012345678, 00201012345678, 201012345678)
  /// - Arabic-Indic numerals supported (e.g. ٠١٠١٢٣٤٥٦٧٨)
  static bool isValidEgyptianPhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) return false;
    String cleaned = normalizeDigits(phone.trim()).replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (cleaned.startsWith('+20')) {
      cleaned = cleaned.substring(3);
    } else if (cleaned.startsWith('0020')) {
      cleaned = cleaned.substring(4);
    } else if (cleaned.startsWith('20') && cleaned.length == 12) {
      cleaned = cleaned.substring(2);
    }

    if (cleaned.length == 11 && cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1);
    }

    // Must be exactly 10 digits starting with 10, 11, 12, or 15
    final regex = RegExp(r'^1[0125]\d{8}$');
    return regex.hasMatch(cleaned);
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'رقم الموبايل مطلوب';
    }
    if (!isValidEgyptianPhone(phone)) {
      return 'رقم موبايل مصري غير صحيح (مثل: 01012345678)';
    }
    return null;
  }

  /// Full name must contain at least first and last name (2 words)
  static bool isValidFullName(String? name) {
    if (name == null) return false;
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    return parts.length >= 2 && parts.every((p) => p.length >= 2);
  }

  static String? validateFullName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'الاسم بالكامل مطلوب';
    }
    if (!isValidFullName(name)) {
      return 'يرجى إدخال الاسم بالكامل (الاسم واسم العائلة)';
    }
    return null;
  }

  /// Email validation (optional in Sikka registration)
  static bool isValidEmail(String? email, {bool isOptional = true}) {
    if (email == null || email.trim().isEmpty) {
      return isOptional;
    }
    final trimmed = email.trim();
    final regex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
    );
    return regex.hasMatch(trimmed);
  }

  static String? validateEmail(String? email, {bool isOptional = true}) {
    if (email == null || email.trim().isEmpty) {
      return isOptional ? null : 'البريد الإلكتروني مطلوب';
    }
    if (!isValidEmail(email, isOptional: isOptional)) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  /// Password must be at least 6 characters
  static bool isValidPassword(String? password) {
    if (password == null) return false;
    return password.length >= 6;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (!isValidPassword(password)) {
      return 'كلمة المرور يجب أن تتكون من 6 أحرف على الأقل';
    }
    return null;
  }

  /// Confirm password check
  static bool doPasswordsMatch(String? password, String? confirmPassword) {
    if (password == null || confirmPassword == null) return false;
    return confirmPassword.isNotEmpty && confirmPassword == password;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (password != confirmPassword) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  /// Password strength calculation (0.0 to 1.0)
  static double calculatePasswordStrength(String? password) {
    if (password == null || password.isEmpty) return 0.0;
    if (password.length < 6) return 0.25;

    double strength = 0.4;
    if (password.length >= 8) strength += 0.2;
    if (RegExp(r'[A-Z]').hasMatch(password) && RegExp(r'[a-z]').hasMatch(password)) {
      strength += 0.2;
    }
    if (RegExp(r'[0-9]').hasMatch(password)) {
      strength += 0.1;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      strength += 0.1;
    }
    return strength.clamp(0.0, 1.0);
  }
}
