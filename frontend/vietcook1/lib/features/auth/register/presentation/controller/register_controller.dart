import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

import '../../../../../core/data/network/exceptions/app_exception.dart';
import '../../../../../core/data/network/remote/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService;
  RegisterController(this._authService);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final isLoading = false.obs;

  final hasMinLength = false.obs;
  final hasNumber = false.obs;
  final hasLetter = false.obs;
  final rePasswordError = RxnString();

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      nameController.text = "Test User";
      emailController.text = "yolotrainlalua2003@gmail.com";
      passwordController.text = "12345678";
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.onClose();
  }

  // Hàm kiểm tra điều kiện mật khẩu
  void onPasswordChanged(String value) {
    hasMinLength.value = value.length >= 6;
    hasNumber.value = value.contains(RegExp(r'[0-9]'));
    hasLetter.value = value.contains(RegExp(r'[a-zA-Z]'));
  }

  // void onRePasswordChanged(String value) {
  //   if (value.isNotEmpty && value != passwordController.text) {
  //     Get.snackbar(
  //       "Lỗi",
  //       "Mật khẩu xác nhận không khớp",
  //       backgroundColor: AppColors.error,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  void onRePasswordChanged(String value) {
    if (value.isNotEmpty && value != passwordController.text) {
      rePasswordError.value = "Mật khẩu xác nhận không khớp";
    } else {
      rePasswordError.value = null;
    }
  }

  void register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final rePassword = rePasswordController.text;

    if (!_validateFields(name, email, password, rePassword)) return;

    isLoading.value = true;

    final result = await _authService.register(name, email, password);

    isLoading.value = false;

    _handleRegisterResponse(result);
  }

  bool _validateFields(
      String name, String email, String password, String rePassword) {
    if (name.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập tên",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }
    if (email.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập email hoặc số điện thoại",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập mật khẩu",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }
    if (rePassword.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập lại mật khẩu",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }
    if (password != rePassword) {
      Get.snackbar(
        "Lỗi",
        "Mật khẩu xác nhận không khớp",
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void _handleRegisterResponse(Result result) {
    if (result.status == Status.success) {
      final email = emailController.text.trim();
      Get.snackbar("Thành công",
          result.data ?? "Vui lòng kiểm tra email để xác nhận OTP");
      Get.toNamed('/verify-otp', arguments: {'email': email});
    } else {
      final AppException? error = result.exp;
      Get.snackbar(
          backgroundColor: AppColors.error,
          colorText: Colors.white,
          "Lỗi Đăng ký",
          error?.message ?? "Đã xảy ra lỗi không xác định.");
    }
  }
}
