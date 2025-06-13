import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/ui/common_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Ảnh minh họa
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 75),
                  child: Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.asset(
                        'lib/assets/images/onboarding.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bắt đầu hành trình',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Không chỉ là công thức, đó là hành trình tạo nên hạnh phúc trong từng bữa ăn.',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.textGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    CommonButton(
                      text: 'Bắt đầu',
                      onPressed: () {
                        // Chuyển sang màn hình tiếp theo
                        Get.toNamed('/register');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
