import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/favorite_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/main/models/user_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';

class ProfileController extends GetxController {
  final RecipeService _recipeService;
  final UserService _userService;
  ProfileController(this._recipeService, this._userService);

  final RxList<RecipeModel> userRecipes = RxList<RecipeModel>();
  bool isLoading = true;
  final List<String> favoriteRecipeIds = [];
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    getUser();
    update(['profile_info', 'user_recipes']);
  }

  // void getUser() async {
  //   isLoading.value = true;
  //   final result = await _userService.getUser();

  //   if (result.status == Status.success && result.data != null) {
  //     user = result.data;
  //     await SharedPrefsUtils.saveObject(
  //       SharePrefsConstants.user,
  //       user.toJson(),
  //     );

  //     if (user.id?.isNotEmpty == true) {
  //       await fetchUserRecipes(user.id!);
  //     } else {
  //       userRecipes.clear();
  //     }

  //     // update(['profile_info', 'user_recipes']);
  //   } else {
  //     user = UserModel(); // an toàn tránh null
  //     Get.snackbar(
  //       'Error',
  //       'Failed to fetch user data',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }

  //   isLoading.value = false;
  // }

  void getUser() async {
    isLoading = true;
    final result = await _userService.getUser();
    if (result.status == Status.success) {
      user = result.data!;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user, user.toJson());
      fetchUserRecipes(user.id!);
      update(['profile_info']);
      isLoading = false;
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch user data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading = false;
    }
  }

  Future<void> fetchUserRecipes(String userId) async {
    final result = await _recipeService.fetchRecipesByUserId(userId);
    userRecipes.assignAll(result.data ?? []);
    update(['user_recipes', 'profile_info']);
  }

  bool isFavorite(String recipeId) {
    return favoriteRecipeIds.contains(recipeId);
  }

  final FavoriteService _favoriteService = Get.find<FavoriteService>();

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
      final result = await _favoriteService.addFavorite(recipeId);
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
}
