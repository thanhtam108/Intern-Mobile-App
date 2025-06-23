import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/category_model.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/category_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/main/models/user_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/data/local/models/top_rated_recipe_model.dart';

class HomeController extends GetxController {
  final RecipeService _recipeService;
  final UserService _userService;
  final CategoryService _categoryService;
  HomeController(this._recipeService, this._userService, this._categoryService);

  final RxList<TopRatedRecipeModel> topRatedRecipes =
      RxList<TopRatedRecipeModel>();

  final RxList<RecipeModel> recentRecipes = RxList<RecipeModel>();

  bool isLoadingUser = true;
  bool isLoadingCategories = true;
  bool isLoadingTopRated = true;
  bool isLoadingRecent = true;

  UserModel user = UserModel();

  final RxList<CategoryModel> categories = RxList<CategoryModel>();

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
    isLoadingUser = true;
    final result = await _userService.getUser();
    if (result.status == Status.success) {
      user = result.data!;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user, user.toJson());
      isLoadingUser = false;
      fetchTopRatedRecipes();
      fetchCategories();
      fetchRecentRecipes();
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

  Future<void> fetchTopRatedRecipes() async {
    isLoadingTopRated = true;
    final result = await _recipeService.fetchTopRatedRecipes();

    topRatedRecipes.assignAll((result.data ?? []).take(6).toList());
    isLoadingTopRated = false;
    print("Top rated recipes: ${result.data}");
  }

  Future<void> fetchCategories() async {
    isLoadingCategories = true;
    update(['updateHome']);
    final result = await _categoryService.fetchCategories();
    isLoadingCategories = false;
    update(['updateHome']);
    if (result.status == Status.success) {
      categories.assignAll((result.data ?? []).take(8).toList());
      ;
      if (categories.isNotEmpty) {
        await SharedPrefsUtils.saveObject(SharePrefsConstants.categories,
            categories.map((e) => e.toJson()).toList());
      }
    } else {
      Get.snackbar(
        'Lỗi',
        'Không thể tải danh mục món ăn',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update(['updateHome']);
  }

  Future<void> fetchRecentRecipes() async {
    isLoadingRecent = true;
    final result = await _recipeService.fetchRecentRecipes();
    if (result.status == Status.success) {
      recentRecipes.assignAll((result.data ?? []).take(3).toList());
      print("Recent recipes: ${result.data}");
    } else {
      Get.snackbar(
        'Lỗi',
        'Không thể tải danh sách món gần đây',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update(['updateHome']);
    isLoadingRecent = false;
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

  Future<void> logout() async {
    await SharedPrefsUtils.remove(SharePrefsConstants.user);
    Get.offAllNamed('/login');
  }
}
