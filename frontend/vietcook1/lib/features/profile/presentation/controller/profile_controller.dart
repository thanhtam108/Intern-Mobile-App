import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  UserModel userdata = UserModel();

  @override
  void onInit() async {
    super.onInit();
    initializeData();
    getUser();
    Map<String, dynamic>? user =
        await SharedPrefsUtils.getObject(SharePrefsConstants.user);
    if (user != null) {
      userdata = UserModel.fromJson(user);
      update(["updateUser"]);
    }
    // // fetchRecentRecipes();
  }

  UserModel? user;

  Future<void> initializeData() async {
    await _loadUserData();
    await fetchUserRecipes(userdata.id ?? '');
    update(['updateUser', 'userRecipes']);
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      userdata = UserModel.fromJson(jsonDecode(userData));
    } else {
      Get.snackbar('Lỗi', 'Không tìm thấy dữ liệu người dùng');
    }
  }

  Future<void> fetchUserRecipes(String userId) async {
    isLoading.value = true;
    final result = await _recipeService.fetchRecipesByUserId(userId);

    userRecipes.assignAll(result.data ?? []);
    print("Top rated recipes: ${result.data}");
    isLoading.value = false;
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
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
