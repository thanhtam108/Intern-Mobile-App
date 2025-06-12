// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../core/data/network/remote/auth_service.dart';

// class OtpController extends GetxController {
//   final otpController = TextEditingController();
//   final isLoading = false.obs;
//   late final String email;

//   @override
//   void onInit() {
//     super.onInit();
//     email = Get.arguments['email'];
//   }

//   void verifyOtp() async {
//     final otp = otpController.text.trim();
//     if (otp.isEmpty) {
//       Get.snackbar("Lỗi", "Vui lòng nhập OTP");
//       return;
//     }

//     isLoading.value = true;
//     try {
//       final token = await AuthService().verifyOtp(email, otp);
//       await AuthService().saveToken(token);
//       Get.offAllNamed('/recipes'); // chuyển đến trang chính
//     } catch (e) {
//       Get.snackbar("Sai OTP", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void resendOtp() async {
//     try {
//       await AuthService().resendOtp(email);
//       Get.snackbar("Thông báo", "OTP mới đã được gửi");
//     } catch (e) {
//       Get.snackbar("Lỗi", e.toString());
//     }
//   }
// }
