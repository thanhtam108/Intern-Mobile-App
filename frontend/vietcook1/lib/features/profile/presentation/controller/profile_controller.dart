import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/main/models/user_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';

class ProfileController extends GetxController {
  final RecipeService _recipeService;
  final UserService _userService;
  ProfileController(this._recipeService, this._userService);

  final RxList<RecipeModel> userRecipes = RxList<RecipeModel>();
  final isLoading = false.obs;

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    getUser();
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
    final result = await _userService.getUser();
    if (result.status == Status.success) {
      user = result.data!;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user, user.toJson());
      fetchUserRecipes(user.id!);
      update(['profile_info', 'user_recipes']);
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch user data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchUserRecipes(String userId) async {
    final result = await _recipeService.fetchRecipesByUserId(userId);
    userRecipes.assignAll(result.data ?? []);
    update(['user_recipes']);
  }
}
