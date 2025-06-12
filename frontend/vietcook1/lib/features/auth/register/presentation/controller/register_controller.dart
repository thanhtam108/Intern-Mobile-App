// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vietcook1/core/data/network/model/result_dto.dart';
// import '../../../../../core/data/network/remote/auth_service.dart';

// class RegisterController extends GetxController {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final isLoading = false.obs;

//   void register() async {
//     final name = nameController.text.trim();
//     final email = emailController.text.trim();
//     print('Email entered: $email');
//     final password = passwordController.text;

//     if (email.isEmpty || password.isEmpty) {
//       Get.snackbar("Lỗi", "Không được để trống");
//       return;
//     }

//     isLoading.value = true;
//     final result = await AuthService().register(name, email, password);
//     if (result.status == Status.success) {
//       result.data
//         isLoading.value = true;
//       print(result.data);
//     } else {
//       result.data.exp.mess
//     }
//   }
// }
