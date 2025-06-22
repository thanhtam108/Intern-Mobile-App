import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/features/edit_profile/presentation/controller/edit_profile_controller.dart';

class EditPersonalInfo extends GetView<EditProfileController> {
  EditPersonalInfo({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Gán sẵn dữ liệu ban đầu
    nameController.text = controller.user.name ?? '';
    bioController.text = controller.user.bio ?? '';
    emailController.text = controller.user.email ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F3),
      body: GetBuilder<EditProfileController>(
        id: 'tochanged_info',
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover + Avatar
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('lib/assets/images/cover_image.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Get.toNamed(Routes.home),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.check, color: Colors.white),
                        onPressed: () {
                          controller.updateUser(
                            name: nameController.text,
                            bio: bioController.text,
                            email: emailController.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Avatar section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              controller.user.avatarUrl ??
                                  'https://via.placeholder.com/150'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, size: 20),
                              onPressed: () {
                                controller.pickImage(context: context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.user.name ?? 'Người dùng',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(controller.user.bio ?? '',
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),

              // Họ tên
              _buildLabel('Họ và Tên'),
              _buildTextField(nameController, 'Tên của bạn'),

              // Tiểu sử
              _buildLabel('Tiểu sử'),
              _buildTextField(bioController, 'Một chút về bạn'),

              // Email
              _buildLabel('Email'),
              _buildTextField(emailController, 'Email của bạn', enabled: false),

              const SizedBox(height: 24),

              // Nút lưu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9BAE8C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      controller.updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        email: emailController.text,
                      );
                    },
                    child: const Text('Lưu thay đổi'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 16, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
