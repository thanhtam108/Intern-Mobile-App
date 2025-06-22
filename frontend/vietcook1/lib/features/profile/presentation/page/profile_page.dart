import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/ui/common_button.dart';
import 'package:vietcook1/features/profile/presentation/components/profile_info.dart';
import 'package:vietcook1/features/profile/presentation/components/user_recipe_grid.dart';
import '../controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover Image
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/cover_image.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 7),
                        child: Container(
                          height: 28,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(
                                    0, 255, 255, 255), // Trắng trong suốt
                                Color.fromARGB(180, 255, 255, 255), // Trắng mờ
                                Color.fromARGB(255, 255, 255, 255), // Trắng đục
                              ],
                              stops: [0.0, 0.7, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {}, // Sửa thông tin cá nhân
                    ),
                  ),
                ],
              ),
            ),
            // Profile Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: GetBuilder<ProfileController>(
                id: 'profile_info',
                builder: (context) => ProfileInfo(
                    username: controller.user.name ?? 'Người dùng',
                    bio: controller.user.bio ?? 'Default bio',
                    profileImageUrl: controller.user.avatarUrl ??
                        'https://randomuser.me/api/portraits/men/32.jpg'),
              ),
            ),
            // User Recipe Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: CommonButton(
                text: 'Chỉnh sửa thông tin',
                onPressed: () {
                  Get.toNamed(Routes.editPersonalInfo);
                },
              ),
            ),
            UserRecipeGrid(),
          ],
        ),
      ),
    );
  }
}
