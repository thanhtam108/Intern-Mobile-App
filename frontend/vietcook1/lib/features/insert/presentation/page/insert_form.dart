import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import '../controller/insert_controller.dart';

class InsertRecipePage extends GetView<InsertRecipeController> {
  InsertRecipePage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController stepDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F3),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Get.back(),
          child: const Text('Huỷ',
              style: TextStyle(
                  color: AppColors.secondary, fontWeight: FontWeight.bold)),
        ),
        toolbarHeight: 48,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ảnh món ăn
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => controller.pickImage(context: context),
                        child: Obx(() => Container(
                              height: 110,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: controller.imageFile.value != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        File(controller.imageFile.value!.path),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 110,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                color: Colors.grey,
                                                fontSize: 12)),
                                      ],
                                    ),
                            )),
                      ),
                    ),
                  ),
                  // Tên món ăn
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Tên món ăn',
                        hintText: 'Nhập tên món ăn',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  // Mô tả
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: TextField(
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: 'Mô tả',
                        hintText: 'Mô tả một chút về món ăn',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  // Loại món ăn
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        )),
                  ),
                  // Thời lượng nấu
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: TextField(
                      controller: durationController,
                      decoration: InputDecoration(
                        labelText: 'Thời lượng nấu (phút)',
                        hintText: 'Nhập thời gian cần để nấu',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  // Nguyên liệu
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Nguyên liệu',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary)),
                        TextButton.icon(
                          onPressed: () {
                            // Xử lý thêm nhóm nguyên liệu nếu muốn
                          },
                          icon: const Icon(Icons.add,
                              size: 18, color: Color(0xFF7BA23F)),
                          label: const Text('Nhóm',
                              style: TextStyle(color: Color(0xFF7BA23F))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ...controller.ingredients.map((ingredient) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TextField(
                                controller:
                                    TextEditingController(text: ingredient),
                                readOnly: true,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.drag_indicator,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: ingredientController,
                                decoration: InputDecoration(
                                  hintText: 'Nhập tên nguyên liệu',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                              ),
                              onPressed: () {
                                if (ingredientController.text
                                    .trim()
                                    .isNotEmpty) {
                                  controller.ingredients
                                      .add(ingredientController.text.trim());
                                  ingredientController.clear();
                                }
                              },
                              child: const Text(
                                'Thêm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Bước thực hiện
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: const Text('Bước thực hiện',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.primary,
                          child: Text('${controller.steps.length + 1}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: stepDescController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: 'Nhập vào các bước làm món ăn',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.camera_alt,
                              color: AppColors.primary),
                          onPressed: () {
                            // Xử lý thêm ảnh cho bước nếu muốn
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          if (stepDescController.text.trim().isNotEmpty) {
                            controller.addStep(
                                '', stepDescController.text.trim());
                            stepDescController.clear();
                          }
                        },
                        child: const Text(
                          'Thêm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // Danh sách các bước đã thêm
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Obx(() => Column(
                          children: controller.steps
                              .asMap()
                              .entries
                              .map((entry) => ListTile(
                                    leading: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: AppColors.primary,
                                      child: Text('${entry.key + 1}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ),
                                    title:
                                        Text(entry.value.stepDescription ?? ''),
                                  ))
                              .toList(),
                        )),
                  ),
                  // Nút đăng tải
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1A2B3C),
                              side: const BorderSide(color: Color(0xFF1A2B3C)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Trở lại',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9BAE8C),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {
                              controller.name.value = nameController.text;
                              controller.description.value =
                                  descController.text;
                              controller.duration.value =
                                  durationController.text;
                              if (controller.user?.id != null) {
                                controller.submitRecipe(controller.user!.id!);
                              } else {
                                Get.snackbar(
                                  'Lỗi',
                                  'Vui lòng đăng nhập để đăng món ăn',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            child: const Text('Đăng tải',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
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
