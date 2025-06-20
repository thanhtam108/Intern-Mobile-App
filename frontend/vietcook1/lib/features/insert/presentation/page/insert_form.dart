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
      appBar: AppBar(title: const Text("Đăng món ăn")),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Ảnh món ăn
                  GestureDetector(
                    onTap: () {
                      controller.pickImage(context: context);
                    },
                    child: Obx(() => Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: controller.imageFile.value != null
                              ? Image.file(
                                  File(controller.imageFile.value!.path))
                              : const Center(child: Text('Tải ảnh món ăn')),
                        )),
                  ),
                  const SizedBox(height: 16),

                  // 2. Tên món
                  TextField(
                    onChanged: (val) => controller.name.value = val,
                    decoration: const InputDecoration(labelText: 'Tên món ăn'),
                  ),

                  // 3. Mô tả
                  TextField(
                    onChanged: (val) => controller.description.value = val,
                    decoration:
                        const InputDecoration(labelText: 'Mô tả món ăn'),
                  ),

                  // 4. Dropdown loại món
                  Obx(() => DropdownButtonFormField<String>(
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
                        decoration:
                            const InputDecoration(labelText: 'Loại món'),
                      )),

                  // 5. Thời lượng
                  TextField(
                    onChanged: (val) => controller.duration.value = val,
                    decoration: const InputDecoration(
                        labelText: 'Thời gian nấu (vd: 45 phút)'),
                  ),

                  const SizedBox(height: 16),
                  const Text("Nguyên liệu",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ingredientController,
                          decoration: const InputDecoration(
                              hintText: 'Nhập nguyên liệu'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          controller.addIngredient(ingredientController.text);
                          ingredientController.clear();
                        },
                      )
                    ],
                  ),
                  Obx(() => Column(
                        children: controller.ingredients
                            .map((ing) => ListTile(
                                  title: Text(ing),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        controller.ingredients.remove(ing),
                                  ),
                                ))
                            .toList(),
                      )),
                  const SizedBox(height: 16),

                  const Text("Các bước nấu",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: stepTitleController,
                    decoration:
                        const InputDecoration(labelText: 'Tiêu đề bước'),
                  ),
                  TextField(
                    controller: stepDescController,
                    decoration: const InputDecoration(labelText: 'Mô tả bước'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.addStep(
                        stepTitleController.text,
                        stepDescController.text,
                      );
                      stepTitleController.clear();
                      stepDescController.clear();
                    },
                    child: const Text("Thêm bước"),
                  ),
                  Obx(() => Column(
                        children: controller.steps
                            .asMap()
                            .entries
                            .map((entry) => ListTile(
                                  title: Text(
                                      "${entry.key + 1}. ${entry.value.stepName}"),
                                  subtitle:
                                      Text(entry.value.stepDescription ?? ''),
                                ))
                            .toList(),
                      )),

                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.upload),
                      label: const Text("Đăng món ăn"),
                      onPressed: () {
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
                    ),
                  )
                ],
              ),
            )),
    );
  }
}
