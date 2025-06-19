import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/category_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/category_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/features/main/models/user_model.dart';
import '../../models/insert_recipe_model.dart';
import 'package:vietcook1/core/data/local/models/step_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/utils/firebase_upload_helper.dart';
import 'package:vietcook1/core/utils/shared_preferences _utils.dart';

class InsertRecipeController extends GetxController {
  final RecipeService _recipeService;
  final CategoryService _categoryService;
  final UserService _userService;
  UserModel? user;
  List<CategoryModel> categories = [];
  InsertRecipeController(
      this._recipeService, this._categoryService, this._userService);
  // RxBool isTablet = false.obs;
  @override
  void onInit() async {
    super.onInit();
    getUser();
    getCategories();
    if (kDebugMode) {
      // For testing purposes, pre-fill some fields
      name.value = 'Bánh mì';
      description.value = 'Món ăn truyền thống Việt Nam';
      ingredients.addAll(['Bánh mì', 'Thịt nướng', 'Rau sống']);
      duration.value = '30 phút';
      steps.addAll([
        StepModel(
            stepName: 'Chuẩn bị nguyên liệu',
            stepDescription: 'Chuẩn bị bánh mì, thịt nướng và rau sống'),
        StepModel(
            stepName: 'Nướng thịt',
            stepDescription: 'Nướng thịt trên bếp than hoa')
      ]);
    }
  }

  // Rx variables for form fields
  final name = ''.obs;
  final description = ''.obs;
  final ingredients = <String>[].obs;
  final duration = ''.obs;
  final categoryId = ''.obs;
  final steps = <StepModel>[].obs;

  final imageFile = Rxn<File>();
  final isLoading = false.obs;

  final picker = ImagePicker();

  // Pick main recipe image
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  // Add a new ingredient
  Future<void> addIngredient(String ingredient) async {
    final trimmed = ingredient.trim();
    if (trimmed.isNotEmpty && !ingredients.contains(trimmed)) {
      ingredients.add(trimmed);
    }
  }

  // Add a new step with optional image
  void addStep(String name, String description, [String? imageUrl]) {
    final trimmedName = name.trim();
    final trimmedDescription = description.trim();

    if (trimmedName.isEmpty || trimmedDescription.isEmpty) {
      Get.snackbar('Lỗi', 'Bước nấu ăn cần có tiêu đề và mô tả');
      return;
    }

    steps.add(StepModel(
      stepName: trimmedName,
      stepDescription: trimmedDescription,
      imageUrl: imageUrl,
    ));
  }

  void getUser() async {
    final result = await _userService.getUser();
    if (result.status == Status.success) {
      user = result.data;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user, user!.toJson());

      print('User: ${user?.name}');
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch user data',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      final result = await _categoryService.fetchCategories();

      if (result.status == Status.success) {
        categories = result.data ?? [];
        if (categories.isNotEmpty) {
          // Tự động chọn category đầu tiên nếu có
          categoryId.value = categories[0].id;
        }
      } else {
        Get.snackbar(
          'Lỗi',
          'Không thể tải danh mục món ăn',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã xảy ra lỗi khi tải danh mục: ${e.toString()}',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Upload image to Firebase and return URL
  Future<String?> uploadImage(File file, String path) async {
    return await FirebaseUploadHelper.uploadImage(file: file, path: path);
  }

  // Submit recipe to backend
  Future<void> submitRecipe(String userId) async {
    try {
      // 1. Validate input
      if (name.value.trim().isEmpty ||
          description.value.trim().isEmpty ||
          duration.value.trim().isEmpty ||
          categoryId.value.isEmpty ||
          ingredients.isEmpty ||
          steps.isEmpty) {
        Get.snackbar(
          'Lỗi',
          'Vui lòng điền đầy đủ thông tin món ăn',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
        return;
      }

      // 2. Check image
      if (imageFile.value == null) {
        Get.snackbar(
          'Lỗi',
          'Vui lòng chọn ảnh món ăn',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      // 3. Upload image
      final uploadedImageUrl = await uploadImage(imageFile.value!, 'recipes');
      if (uploadedImageUrl == null) {
        throw Exception('Không thể tải ảnh lên');
      }

      // 4. Create recipe model
      final recipe = InsertRecipeModel(
        name: name.value.trim(),
        description: description.value.trim(),
        ingredients: ingredients.toList(),
        userId: userId,
        view: 0,
        duration: duration.value.trim(),
        category: categoryId.value,
        imageUrl: uploadedImageUrl,
        steps: steps.toList(),
      );

      // 5. Submit to backend
      final result = await _recipeService.createRecipe(recipe);

      if (result.status == Status.success) {
        Get.snackbar(
          'Thành công',
          'Món ăn đã được đăng thành công',
          backgroundColor: AppColors.success,
          colorText: Colors.white,
        );
        Get.back(); // Quay về trang trước
      } else {
        throw Exception(result.data ?? 'Không thể đăng món ăn');
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        e.toString(),
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Luôn tắt loading khi kết thúc
    }
  }
}
