class ValidationUtils {
  // Kiểm tra email hợp lệ
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  // Kiểm tra số điện thoại hợp lệ
  static bool isValidPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^\d{10,11}$');
    return regex.hasMatch(phoneNumber);
  }

  // Kiểm tra độ dài mật khẩu
  static bool isValidPassword(String password) {
    return password.length >= 8;
  }
}