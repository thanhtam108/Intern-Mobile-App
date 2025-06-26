import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/favorite_service.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';

class FavoriteRecipesController extends GetxController {
  final FavoriteService _faService;
  final RecipeService _recipeService;
  FavoriteRecipesController(this._faService, this._recipeService);
  List<RecipeModel> favoriteRecipes = [];
  final List<String> favoriteRecipeIds = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  bool isFavorite(String recipeId) {
    return favoriteRecipeIds.contains(recipeId);
  }

  Future<void> toggleFavorite(String recipeId) async {
    if (isFavorite(recipeId)) {
      // Gọi API xóa khỏi favorite
      final result = await _faService.removeFavorite(recipeId);
      if (result.status == Status.success) {
        favoriteRecipeIds.remove(recipeId);
        await SharedPrefsUtils.saveStringList(
          SharePrefsConstants.favRecipes,
          favoriteRecipeIds,
        );
        update(['updateHome']);
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
      final result = await _faService.addFavorite(recipeId);
      if (result.status == Status.success) {
        favoriteRecipeIds.add(recipeId);
        await SharedPrefsUtils.saveStringList(
          SharePrefsConstants.favRecipes,
          favoriteRecipeIds,
        );
        update(['updateHome']);
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

  Future<void> fetchFavorites() async {
    isLoading = true;
    final ids = await SharedPrefsUtils.getStringList(
      SharePrefsConstants.favRecipes,
    );
    if (ids.isNotEmpty) {
      List<RecipeModel> recipes = [];
      for (final id in ids) {
        final recipeResult = await _recipeService.fetchRecipeById(id);
        if (recipeResult.status == Status.success &&
            recipeResult.data != null) {
          recipes.add(recipeResult.data!);
        }
      }
      favoriteRecipes = recipes;
      update(['favorite_recipes']);
      isLoading = false;
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch favorite ids',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> removeFromFavorite(String recipeId) async {
    // Gọi service để bỏ thích
    final result = await _faService.removeFavorite(recipeId);
    if (result.status == Status.success) {
      // Xóa khỏi danh sách local
      favoriteRecipes.removeWhere((r) => r.id == recipeId);
      update(['favorite_recipes']);
      // Nếu cần đồng bộ với SharedPrefs, hãy cập nhật ở đây
    } else {
      Get.snackbar(
        'Lỗi',
        'Không thể bỏ yêu thích. Vui lòng thử lại!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
