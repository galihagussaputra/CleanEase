class AppValidator {
  // Empty Validator
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Invalid Email Address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }

    return null;
  }

  static String? validateStrongPassword(String? value) {
    final requiredError = validatePassword(value);
    if (requiredError != null) return requiredError;
    final password = value!;

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }

    if (!RegExp(r'^\+?[\d\s()\-]+$').hasMatch(value.trim())) {
      return 'Invalid phone number';
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8 || digits.length > 15) {
      return 'Invalid phone number';
    }

    return null;
  }
}
