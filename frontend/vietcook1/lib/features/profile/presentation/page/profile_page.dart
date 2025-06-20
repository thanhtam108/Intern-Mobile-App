import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Stack(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1504674900247-0877df9cc836'), // Ảnh bìa mặc định
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
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
            // Profile Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: ProfileInfo(
                  username: controller.userdata.name ?? 'Người dùng',
                  bio: controller.userdata.bio ?? 'Default bio',
                  profileImageUrl: controller.userdata.avatarUrl ??
                      'https://randomuser.me/api/portraits/men/32.jpg'),
            ),
            // User Recipe Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: const CommonButton(
                text: 'Theo dõi',
                onPressed: AboutDialog.new,
              ),
            ),
            const UserRecipeGrid(),
          ],
        ),
      ),
    );
  }
}
