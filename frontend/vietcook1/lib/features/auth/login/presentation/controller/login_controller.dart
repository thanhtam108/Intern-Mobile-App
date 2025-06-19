// import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/auth/login/models/token_model.dart';
// import '../../../../../core/data/network/exceptions/app_exception.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final AuthService _authService;
  LoginController(this._authService);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  TokenModel? tokenModel;

  final isObscure = true.obs;
  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      emailController.text = 'newuser@gmail.com';
      passwordController.text = '123456';
    }
  }

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

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!validateFields(email, password)) return;
    isLoading.value = true;

    final result = await _authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (result.status == Status.success) {
      tokenModel = result.data;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.token, tokenModel!.toJson());
      Get.offAllNamed(Routes.main);
      print('Login result: ${result.data?.accessToken}');
    } else {}

    isLoading.value = false;
  }
}
