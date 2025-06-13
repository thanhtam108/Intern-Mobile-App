import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vietcook1/features/splash/presentation/controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit(); // Initialize the controller
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for splash screen content
            const Text('Splash Screen'),
            const SizedBox(height: 20),
            // You can add a logo or any other widget here
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Loading complete!'),
            ),
          ],
        ),
      ),
    );
  }
}
