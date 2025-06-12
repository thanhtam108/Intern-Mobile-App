// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/register_controller.dart';

// class RegisterPage extends StatelessWidget {
//   // final controller = Get.put(RegisterController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Đăng ký")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Obx(() => Column(
//               children: [
//                 TextField(
//                   controller: controller.nameController,
//                   decoration: InputDecoration(labelText: "Tên "),
//                 ),
//                 TextField(
//                   controller: controller.emailController,
//                   decoration: InputDecoration(labelText: "Email"),
//                 ),
//                 TextField(
//                   controller: controller.passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: "Mật khẩu"),
//                 ),
//                 SizedBox(height: 20),
//                 controller.isLoading.value
//                     ? CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: controller.register,
//                         child: Text("Đăng ký"),
//                       )
//               ],
//             )),
//       ),
//     );
//   }
// }
