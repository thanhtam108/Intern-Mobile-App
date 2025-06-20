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
import 'package:vietcook1/core/data/local/models/top_rated_recipe_model.dart';

class HomeController extends GetxController {
  final RecipeService _recipeService;
  final UserService _userService;
  HomeController(this._recipeService, this._userService);

  final RxList<TopRatedRecipeModel> topRatedRecipes =
      RxList<TopRatedRecipeModel>();

  final RxList<RecipeModel> recentRecipes = RxList<RecipeModel>();

  final isLoading = false.obs;

  UserModel user = UserModel();

  @override
  void onInit() async {
    super.onInit();
    getUser();

    // Map<String, dynamic>? user =
    //     await SharedPrefsUtils.getObject(SharePrefsConstants.user);
    // print(" Nhuan 2User data from SharedPreferences: $user");
    // if (user != null) {
    //   userdata = UserModel.fromJson(user);
    //   print(" Nhuan 2User data loaded: ${userdata.name}");
    //   update(["updateHome"]);
    // }
  }

  void getUser() async {
    final result = await _userService.getUser();
    if (result.status == Status.success) {
      user = result.data!;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user, user!.toJson());
      await fetchTopRatedRecipes();
      update(['updateHome']);
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch user data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Future<void> _loadUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userData = prefs.getString('user');
  //   if (userData != null) {
  //     userdata = UserModel.fromJson(jsonDecode(userData));
  //   } else {
  //     Get.snackbar('Lỗi', 'Không tìm thấy dữ liệu người dùng');
  //   }
  // }

  Future<void> fetchTopRatedRecipes() async {
    isLoading.value = true;
    final result = await _recipeService.fetchTopRatedRecipes();

    topRatedRecipes.assignAll(result.data ?? []);
    print("Top rated recipes: ${result.data}");
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
