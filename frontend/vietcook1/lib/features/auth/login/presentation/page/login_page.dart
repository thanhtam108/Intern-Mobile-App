import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(127, 145, 100, 1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Chào mừng\nbạn quay lại!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(46, 62, 92, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(127, 145, 100, 1),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Cùng khám phá các món ăn\nngon chấn động tam giới nào!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2D6D4A),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              hintText: 'Email hoặc Số điện thoại',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: controller.passwordController,
                            obscureText: controller.isObscure.value,
                            decoration: InputDecoration(
                              hintText: 'Mật khẩu',
                              suffixIcon: IconButton(
                                icon: Icon(controller.isObscure.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () => controller.toggleObscure(),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Quên mật khẩu',
                                  style: TextStyle(color: Colors.blueGrey)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF90A57D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  onPressed: controller.login,
                                  child: const Text(
                                    'Đăng nhập',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                          const SizedBox(height: 16),
                          const Center(child: Text('hoặc')),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.g_mobiledata,
                                size: 28, color: Colors.red),
                            label: const Text('Đăng nhập với Google'),
                            onPressed: controller.loginWithGoogle,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 14),
                                children: [
                                  const TextSpan(
                                      text: 'Bạn chưa có tài khoản? '),
                                  TextSpan(
                                    text: 'Đăng ký',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF90A57D),
                                    ),
                                    // Điều hướng đến trang đăng ký
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = controller.goToRegister,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
