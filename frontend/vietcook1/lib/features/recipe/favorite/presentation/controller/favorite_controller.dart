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
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
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
}
