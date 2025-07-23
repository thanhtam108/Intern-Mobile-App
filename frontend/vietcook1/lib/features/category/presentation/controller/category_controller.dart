import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/category_model.dart';
import 'package:vietcook1/core/data/network/remote/category_service.dart';
import 'package:vietcook1/core/data/network/remote/favorite_service.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';

class RecipesbyCategoryArg {
  final String name;
  final String categoryId;
  RecipesbyCategoryArg({required this.name, required this.categoryId});
}

class CategoryController extends GetxController {
  final RecipeService _recipeService;
  final CategoryService _categoryService;
  final FavoriteService _favoriteService;
  CategoryController(
      this._recipeService, this._categoryService, this._favoriteService);
  List<RecipeModel> cateRecipes = [];
  bool isLoading = true;

  final RecipesbyCategoryArg args = Get.arguments;

  final List<String> favoriteRecipeIds = [];

  @override
  void onInit() {
    super.onInit();
    fetchRecipesbyCategory(args.categoryId);
    SharedPrefsUtils.getStringList(SharePrefsConstants.favRecipes).then((value) {
      favoriteRecipeIds.clear();
      favoriteRecipeIds.addAll(value);
      update(['category_recipes']);
    });
  }

  Future<void> fetchRecipesbyCategory(String categoryId) async {
    try {
      isLoading = true;
      final result = await _recipeService.fetchRecipesByCategoryId(categoryId);
      isLoading = false;
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

  bool isFavorite(String recipeId) {
    return favoriteRecipeIds.contains(recipeId);
  }

  Future<void> toggleFavorite(String recipeId) async {
    if (isFavorite(recipeId)) {
      // Gọi API xóa khỏi favorite
      final result = await _favoriteService.removeFavorite(recipeId);
      if (result.status == Status.success) {
        favoriteRecipeIds.remove(recipeId);
        await SharedPrefsUtils.saveStringList(
          SharePrefsConstants.favRecipes,
          favoriteRecipeIds,
        );
        update(['category_recipes']);
      } else {
        Get.snackbar(
          'Lỗi',
          'Không thể bỏ yêu thích. Vui lòng thử lại!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      // Gọi API thêm vào favorite
      final result = await _favoriteService.addFavorite(recipeId);
      if (result.status == Status.success) {
        favoriteRecipeIds.add(recipeId);
        await SharedPrefsUtils.saveStringList(
          SharePrefsConstants.favRecipes,
          favoriteRecipeIds,
        );
        update(['category_recipes']);
      } else {
        Get.snackbar(
          'Lỗi',
          'Không thể thêm vào yêu thích. Vui lòng thử lại!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  // Future<void> fetchCategoryById(String id) async {
  //   try {
  //     print('Category fetch result: ${id}');
  //     final result = await _categoryService.fetchCategoryById(id);
  //     print('Category fetch result: ${result.data?.id ?? 'null'}');
  //     if (result.status == Status.success && result.data != null) {
  //       category = result.data;
  //       update(['category_details']);
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Không thể tải danh mục',
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Đã xảy ra lỗi khi tải danh mục: ${e.toString()}',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
}
