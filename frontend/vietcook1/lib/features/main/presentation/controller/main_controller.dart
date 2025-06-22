import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/favorite_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/home/di/home_binding.dart';
import 'package:vietcook1/features/home/presentation/page/home_page.dart';
import 'package:vietcook1/features/main/models/user_model.dart';
import 'package:vietcook1/features/profile/di/profile_binding.dart';
import 'package:vietcook1/features/profile/presentation/page/profile_page.dart';
import 'package:vietcook1/features/search/di/search_binding.dart';
import 'package:vietcook1/features/search/presentation/page/search_page.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  final pages = <String>['/home', '/search', '/favorites', '/profile'];
  final UserService _userService;
  final FavoriteService _faService;
  MainController(this._userService, this._faService);
  UserModel? user;
  List<String> favRecipesIds = [];
  @override
  void onInit() async {
    super.onInit();
    getUser();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/home') {
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
      );
    }

    if (settings.name == '/search') {
      return GetPageRoute(
        settings: settings,
        page: () => SearchPage(),
        binding: CustomSearchBinding(),
        transition: Transition.fadeIn,
      );
    }
    if (settings.name == '/favorites') {
      return GetPageRoute(
        settings: settings,
        page: () => Container(),
        // binding: UploadImageBinding(),
        transition: Transition.fadeIn,
      );
    }
    if (settings.name == '/profile') {
      return GetPageRoute(
        settings: settings,
        page: () => ProfilePage(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn,
      );
    }

    return null;
  }

  void onChangeItemBottomBar(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    Get.offAndToNamed(pages[index], id: 1);
  }

  void getUser() async {
    print("Nhuan1");
    final result = await _userService.getUser();
    if (result.status == Status.success) {
      user = result.data;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user, user!.toJson());

      print('User: ${user?.name}');
      fetchFavorites();
    } else {
      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to fetch user data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    }
  }

  void fetchFavorites() async {
    if (user == null) {
      Get.snackbar(
        'Error',
        'User not found',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    final result = await _faService.fetchFavoriteRecipes();
    if (result.status == Status.success) {
      await SharedPrefsUtils.saveStringList(
          SharePrefsConstants.favRecipes, favRecipesIds);
      favRecipesIds = result.data ?? [];
      print('Favorites ids: $favRecipesIds');
      update(['favorites']);
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch favorites',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> clearData() async {
    favRecipesIds.clear();
    user = null;
    currentIndex.value = 0;
    await SharedPrefsUtils.remove(SharePrefsConstants.user);
  }
}
