import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService;
  LoginController(this.authService);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  final isObscure = true.obs;

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void loginWithGoogle() {
    Get.snackbar('Thông báo', 'Chức năng đăng nhập Google đang phát triển');
  }

  void goToRegister() {
    Get.toNamed('/register');
  }

  Future<void> login() async {
    isLoading.value = true;
    try {
      final data = await authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      final token = data['access_token'];
      final user = data['user'];

      Get.snackbar('Thành công', 'Xin chào ${user['name']}');
      // Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Đăng nhập thất bại', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
