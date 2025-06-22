import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/features/splash/presentation/controller/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9BAE8C), Color(0xFFF3F6F3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Centered content with fade animation
          Center(
            child: Obx(() {
              return AnimatedOpacity(
                opacity: controller.fadeOpacity.value,
                duration: const Duration(seconds: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'lib/assets/icons/logo.png',
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // App name
                    const Text(
                      'VietCook',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
