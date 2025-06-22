import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/insert_controller.dart';

class InsertRecipePage extends GetView<InsertRecipeController> {
  InsertRecipePage({super.key});

  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController stepTitleController = TextEditingController();
  final TextEditingController stepDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Get.back(),
          child: const Text('Huỷ',
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ),
        toolbarHeight: 48,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stepper
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 12),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _StepCircle(isActive: true, number: 1),
                          _StepperLine(),
                          _StepCircle(isActive: false, number: 2),
                        ],
                      ),
                    ),
                  ),
                  // Ảnh món ăn
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.pickImage(context: context);
                      },
                      child: Obx(() => Container(
                            height: 120,
                            width: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: controller.imageFile.value != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      File(controller.imageFile.value!.path),
                                      fit: BoxFit.cover,
                                      width: 220,
                                      height: 120,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.image,
                                          size: 40, color: Colors.grey),
                                      SizedBox(height: 8),
                                      Text('Thêm ảnh',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 4),
                                      Text('(tối đa 12 Mb)',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tên món ăn
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (val) => controller.name.value = val,
                      decoration: InputDecoration(
                        labelText: 'Tên món ăn',
                        hintText: 'Nhập tên món ăn',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Mô tả
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (val) => controller.description.value = val,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        hintText: 'Mô tả một chút về món ăn',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Dropdown loại món
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(() => DropdownButtonFormField<String>(
                          value: controller.categoryId.value.isEmpty
                              ? null
                              : controller.categoryId.value,
                          items: controller.categories
                              .map((category) => DropdownMenuItem(
                                    value: category.id,
                                    child: Text(category.name),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              controller.categoryId.value = value ?? '',
                          decoration: InputDecoration(
                            labelText: 'Loại món ăn',
                            hintText: 'Chọn loại',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        )),
                  ),
                  const SizedBox(height: 24),
                  // Nút kế tiếp
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9BAE8C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // Xử lý chuyển bước tiếp theo
                        },
                        child: const Text('Kế tiếp',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Indicator
                  Center(
                    child: Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )),
    );
  }
}

// Stepper circle widget
class _StepCircle extends StatelessWidget {
  final bool isActive;
  final int number;
  const _StepCircle({required this.isActive, required this.number});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF7BA23F) : Colors.white,
        border: Border.all(
          color: isActive ? const Color(0xFF7BA23F) : Colors.grey,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// Stepper line widget
class _StepperLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 2,
      color: const Color(0xFF7BA23F),
    );
  }
}
