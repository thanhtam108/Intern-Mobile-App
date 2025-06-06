import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import '../../../../../core/data/network/exceptions/app_exception.dart';
import '../../../../../core/data/network/remote/auth_service.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final AuthService _authService = Get.find<AuthService>(); // DI

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!_validateFields(name, email, password)) return;

    isLoading.value = true;

    final result = await _authService.register(name, email, password);

    isLoading.value = false;

    _handleRegisterResponse(result);
  }

  bool _validateFields(String name, String email, String password) {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Không được để trống các trường",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void _handleRegisterResponse(Result result) {
    if (result.status == Status.success) {
      final userData = result.data?['user'] as Map<String, dynamic>?;
      final email = userData?['email'];

      if (email != null) {
        Get.snackbar(
            "Thành công",
            result.data?['message'] ??
                "Vui lòng kiểm tra email để xác nhận OTP");
        Get.toNamed('/verify-otp', arguments: email);
      } else {
        Get.snackbar("Lỗi", "Không tìm thấy email trong phản hồi");
      }
    } else {
      final AppException? error = result.exp;
      Get.snackbar(
          "Lỗi Đăng ký", error?.message ?? "Đã xảy ra lỗi không xác định.");
    }
  }
}
