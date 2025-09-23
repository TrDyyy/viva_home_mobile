class ValidationUtils {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Simple email regex validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Required field validation
  static String? required(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  // Number validation
  static String? number(String? value, {bool allowDecimal = false}) {
    if (value == null || value.isEmpty) {
      return "Number is required";
    }
    final regex = allowDecimal ? RegExp(r'^\d*\.?\d+$') : RegExp(r'^\d+$');
    if (!regex.hasMatch(value)) {
      return "Please enter a valid number";
    }
    return null;
  }

  static String? validateRequiredOption<T>(T? value, {String? message}) {
    if (value == null) {
      return message ?? 'This field is required';
    }
    return null;
  }
}
