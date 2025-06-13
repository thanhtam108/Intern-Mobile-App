import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/local/models/user_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';

class HomeController extends GetxController {
  final RecipeService _recipeService = RecipeService();

  final Rx<UserModel?> user = Rx<UserModel?>(null);

  final RxList<RecipeModel> favoriteRecipes = RxList<RecipeModel>();

  final RxList<RecipeModel> recentRecipes = RxList<RecipeModel>();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData(); // Lấy dữ liệu user từ SharedPreferences
    fetchFavoriteRecipes();
    // fetchRecentRecipes();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      user.value = UserModel.fromJson(jsonDecode(userData));
    } else {
      Get.snackbar('Lỗi', 'Không tìm thấy dữ liệu người dùng');
    }
  }

  Future<void> fetchFavoriteRecipes() async {
    isLoading.value = true;
    final result =
        await _recipeService.fetchFavoriteRecipes(user.value?.id ?? '');
    result.when(
      onSuccess: (data) {
        favoriteRecipes.assignAll(data);
      },
      onError: (error) {
        Get.snackbar('Lỗi', 'Không thể tải danh sách món yêu thích');
      },
    );
    isLoading.value = false;
  }

  // Lấy danh sách món gần đây từ API
  // Future<void> fetchRecentRecipes() async {
  //   isLoading.value = true;
  //   final result = await _recipeService.fetchRecentRecipes();
  //   result.when(
  //     onSuccess: (data) {
  //       recentRecipes.assignAll(data);
  //     },
  //     onError: (error) {
  //       Get.snackbar('Lỗi', 'Không thể tải danh sách món gần đây');
  //     },
  //   );
  //   isLoading.value = false;
  // }

  // Chuyển qua các trang trong MainNavigator
  void navigateToPage(String routeName) {
    Get.toNamed(routeName);
  }
}
