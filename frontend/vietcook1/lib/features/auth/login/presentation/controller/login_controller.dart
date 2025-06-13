import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import '../../../../../core/data/network/exceptions/app_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final AuthService _authService;
  LoginController(this._authService);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  final isObscure = true.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void loginWithGoogle() {
    Get.snackbar(
        backgroundColor: AppColors.secondary,
        'Thông báo',
        'Chức năng đăng nhập Google đang phát triển');
  }

  void goToRegister() {
    Get.toNamed('/register');
  }

  bool validateFields(String email, String password) {
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
    return true;
  }

  Future<void> saveUserData(
      String accessToken, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('user', jsonEncode(user));
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!validateFields(email, password)) return;
    isLoading.value = true;

    final result = await _authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    isLoading.value = false;
    result.when(
      onSuccess: (data) async {
        final accessToken = data['access_token'];
        final user = data['user'];
        await saveUserData(accessToken, user);

        Get.snackbar('Thành công', 'Xin chào ${user['name']}');
        Get.offAllNamed('/home', arguments: {
          'access_token': accessToken,
          'user': user,
        });
      },
      onError: (error) {
        Get.snackbar(
          "Lỗi",
          error.message ?? "Đăng nhập thất bại",
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      },
    );
  }
}
