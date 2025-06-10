import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/ui/common_button.dart';
import 'package:vietcook1/core/ui/common_card_container.dart';
import 'package:vietcook1/core/ui/text_field_widget.dart';
import 'package:vietcook1/core/ui/password_requirement_widget.dart';
import '../controller/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                "Chào mừng bạn mới!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: CommonCardContainer(
                  padding: const EdgeInsets.all(24),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Đăng ký",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Cùng khám phá các món ăn ngon chấn động tam giới nào!",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 24),
                          CommonTextField(
                            controller: controller.nameController,
                            labelText: "Tên",
                            hintText: "Nhập tên của bạn",
                          ),
                          const SizedBox(height: 12),
                          CommonTextField(
                            controller: controller.emailController,
                            labelText: "Email hoặc Số điện thoại",
                            hintText: "Email hoặc Số điện thoại",
                          ),
                          const SizedBox(height: 12),
                          CommonTextField(
                            controller: controller.passwordController,
                            labelText: "Mật khẩu",
                            hintText: "Nhập mật khẩu",
                            obscureText: true,
                            onChanged: (value) {
                              controller.onPasswordChanged(value);
                            },
                          ),
                          const SizedBox(height: 12),
                          CommonTextField(
                            controller: controller.rePasswordController,
                            labelText: "Nhập lại Mật khẩu",
                            hintText: "Nhập lại mật khẩu",
                            obscureText: true,
                            onChanged: (value) {
                              controller.onRePasswordChanged(value);
                            },
                          ),
                          Obx(() => controller.rePasswordError.value != null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, left: 8),
                                  child: Text(
                                    controller.rePasswordError.value!,
                                    style: const TextStyle(
                                        color: AppColors.error, fontSize: 13),
                                  ),
                                )
                              : const SizedBox.shrink()),
                          const SizedBox(height: 16),
                          PasswordRequirementWidget(
                            hasMinLength: controller.hasMinLength.value,
                            hasNumber: controller.hasNumber.value,
                          ),
                          const SizedBox(height: 24),
                          CommonButton(
                            text: "Đăng ký",
                            isLoading: controller.isLoading.value,
                            onPressed: controller.register,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
