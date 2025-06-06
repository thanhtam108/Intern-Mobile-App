import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/data/network/remote/auth_service.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final isLoading = false.obs;
  late final String email;

  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  void verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      Get.snackbar("Lỗi", "Vui lòng nhập OTP");
      return;
    }

    isLoading.value = true;
    final result = await _authService.verifyOtp(email, otp);
    isLoading.value = false;

    result.when(
      onSuccess: (token) async {
        await _authService.saveToken(token);
        Get.offAllNamed('/recipes');
      },
      onError: (error) {
        Get.snackbar("Sai OTP", error.message ?? "Xác thực OTP thất bại");
      },
    );
  }

  void resendOtp() async {
    final result = await _authService.resendOtp(email);
    result.when(
      onSuccess: (_) {
        Get.snackbar("Thông báo", "OTP mới đã được gửi");
      },
      onError: (error) {
        Get.snackbar("Lỗi", error.message ?? "Gửi lại OTP thất bại");
      },
    );
  }
}
