import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/category_model.dart';
import 'package:vietcook1/core/data/network/remote/category_service.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

class CategoryController extends GetxController {
  final RecipeService _recipeService;
  final CategoryService _categoryService;
  CategoryController(this._recipeService, this._categoryService);
  List<RecipeModel> cateRecipes = [];
  CategoryModel? category;

  @override
  void onInit() {
    super.onInit();
    fetchRecipesbyCategory(Get.arguments['categoryId']);
    fetchCategoryById(Get.arguments['categoryId']);
  }

  Future<void> fetchRecipesbyCategory(String categoryId) async {
    try {
      final result = await _recipeService.fetchRecipesByCategoryId(categoryId);
      print('Category recipes fetch result: ${result.data}');
      if (result.data != null) {
        cateRecipes.assignAll(result.data!);

        update(['category_recipes']);
      } else {
        Get.snackbar(
          'Error',
          'Không thể tải công thức theo danh mục',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Đã xảy ra lỗi khi tải công thức',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchCategoryById(String id) async {
    try {
      print('Category fetch result: ${id}');
      final result = await _categoryService.fetchCategoryById(id);
      print('Category fetch result: ${result.data?.id ?? 'null'}');
      if (result.status == Status.success && result.data != null) {
        category = result.data;
        update(['category_details']);
      } else {
        Get.snackbar(
          'Error',
          'Không thể tải danh mục',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Đã xảy ra lỗi khi tải danh mục: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
