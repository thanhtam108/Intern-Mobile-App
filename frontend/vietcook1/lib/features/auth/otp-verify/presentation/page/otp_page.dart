// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/otp_controller.dart';

// class OtpPage extends StatelessWidget {
//   final controller = Get.put(
//     // OtpController()
//     );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Xác minh OTP")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Obx(() => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Nhập mã OTP được gửi đến email: ${controller.email}"),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: controller.otpController,
//                   decoration: InputDecoration(labelText: "Mã OTP"),
//                 ),
//                 SizedBox(height: 20),
//                 controller.isLoading.value
//                     ? Center(child: CircularProgressIndicator())
//                     : Column(
//                         children: [
//                           ElevatedButton(
//                             onPressed: controller.verifyOtp,
//                             child: Text("Xác minh"),
//                           ),
//                           TextButton(
//                             onPressed: controller.resendOtp,
//                             child: Text("Gửi lại OTP"),
//                           )
//                         ],
//                       )
//               ],
//             )),
//       ),
//     );
//   }
// }
