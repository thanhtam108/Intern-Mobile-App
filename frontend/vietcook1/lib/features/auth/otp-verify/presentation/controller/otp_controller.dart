import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'dart:async';
import '../../../../../core/data/network/remote/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OtpController extends GetxController {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  final isLoading = false.obs;
  late final String email;

  final RxInt secondsLeft = 300.obs; // 5 phút = 300 giây
  Timer? _timer;

  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    startTimer();
  }

  void startTimer() {
    secondsLeft.value = 300;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  String get otp => otpControllers.map((c) => c.text).join();

  void verifyOtp() async {
    final otp = otpControllers.map((c) => c.text).join();
    if (otp.length != 6) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng nhập đủ 6 số OTP",
        backgroundColor: AppColors.error,
        colorText: AppColors.primary,
      );
      return;
    }

    isLoading.value = true;
    final result = await _authService.verifyOtp(email, otp);
    isLoading.value = false;

    result.when(
      onSuccess: (data) async {
        final accessToken = data['access_token'];
        final user = data['user'];
        await saveUserData(accessToken, user);
        Get.offAllNamed('/home', arguments: {
          'access_token': accessToken,
          'user': user,
        });
        Get.snackbar(
          "Thành công",
          "Xác thực OTP thành công! Đang chuyển hướng...",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
      onError: (error) {
        Get.snackbar(
          "Lỗi",
          error.message ?? "Xác thực OTP thất bại",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        // Clear tất cả các ô OTP để nhập lại
        otpControllers.forEach((controller) => controller.clear());
        // Focus vào ô đầu tiên
        focusNodes[0].requestFocus();
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

  Future<void> saveUserData(
      String accessToken, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('user', jsonEncode(user));
  }
}
