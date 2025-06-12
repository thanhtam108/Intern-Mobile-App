import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/ui/common_button.dart';
import 'package:vietcook1/core/ui/common_card_container.dart';
import '../controller/otp_controller.dart';

// class OtpPage extends StatelessWidget {
//   final controller = Get.put(
//     // OtpController()
//     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        "Kiểm tra email của bạn",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B4664),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Mã xác nhận đã được gửi tới bạn",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      CommonCardContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) {
                            return SizedBox(
                              width: 40,
                              child: TextField(
                                controller: controller.otpControllers[index],
                                focusNode: controller.focusNodes[index],
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "-",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                ),
                                onChanged: (value) {
                                  if (value.length == 1 && index < 5) {
                                    controller.focusNodes[index + 1]
                                        .requestFocus();
                                  }
                                  if (value.isEmpty && index > 0) {
                                    controller.focusNodes[index - 1]
                                        .requestFocus();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Mã hết hạn trong:",
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 4),
                          Obx(() {
                            final minutes = (controller.secondsLeft.value ~/ 60)
                                .toString()
                                .padLeft(2, '0');
                            final seconds = (controller.secondsLeft.value % 60)
                                .toString()
                                .padLeft(2, '0');
                            return Text(
                              "$minutes:$seconds",
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CommonButton(
                        text: "Xác thực",
                        isLoading: controller.isLoading.value,
                        onPressed: controller.verifyOtp,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: controller.resendOtp,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Gửi lại mã",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
