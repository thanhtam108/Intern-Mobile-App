import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/favorite_service.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/main/models/user_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';

class RecipeDetailController extends GetxController {
  final FavoriteService _faService;
  final RecipeService _recipeService;
  final UserService _userService;
  RecipeDetailController(
      this._recipeService, this._userService, this._faService);

  final Rxn<RecipeModel> recipe = Rxn<RecipeModel>();
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxBool isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    final recipeId = Get.arguments?['recipeId'] as String?;
    if (recipeId != null) {
      fetchRecipeById(recipeId);
    }
    getUser();
  }

  Future<void> getUser() async {
    final result = await _userService.getUser();
    if (result.status == Status.success && result.data != null) {
      user.value = result.data;
      checkIsFavorite();
    }
  }

  Future<void> fetchRecipeById(String id) async {
    final result = await _recipeService.fetchRecipeById(id);
    if (result.status == Status.success && result.data != null) {
      recipe.value = result.data;
      checkIsFavorite();
      update(['recipeDetails']);
    }
  }

  Future<void> checkIsFavorite() async {
    if (recipe.value == null) {
      isFavorite.value = false;
      return;
    }
    // Lấy danh sách id từ SharedPreferences
    final favIds =
        await SharedPrefsUtils.getStringList(SharePrefsConstants.favRecipes) ??
            [];
    isFavorite.value = favIds.contains(recipe.value!.id);
  }

  // Hàm toggle yêu thích
  Future<void> toggleFavorite() async {
    if (user.value == null || recipe.value == null) return;

    // Lấy danh sách id từ SharedPreferences
    final favIds =
        await SharedPrefsUtils.getStringList(SharePrefsConstants.favRecipes) ??
            [];

    if (isFavorite.value) {
      // Xóa khỏi bảng favorite (nếu có API)
      await _faService.removeFavorite(recipe.value!.id);
      favIds.remove(recipe.value!.id);
      isFavorite.value = false;
    } else {
      // Thêm vào bảng favorite (nếu có API)
      await _faService.addFavorite(recipe.value!.id);
      favIds.add(recipe.value!.id);
      isFavorite.value = true;
    }

    // Lưu lại vào SharedPreferences giống HomeController
    await SharedPrefsUtils.saveStringList(
        SharePrefsConstants.favRecipes, favIds);

    update(['recipeDetails']);
  }
}
