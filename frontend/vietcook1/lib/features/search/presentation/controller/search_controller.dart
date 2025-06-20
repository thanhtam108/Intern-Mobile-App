import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/utils/search_history_utils.dart';

class CustomSearchController extends GetxController {
  final RecipeService _recipeService = RecipeService(Get.find<Dio>());

  final RxList<RecipeModel> recipes = <RecipeModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<String> recentSearches = <String>[].obs;
  final RxBool hasSearched = false.obs;

  String _query = '';

  void onSearchChanged(String value) {
    _query = value;

    if (value.trim().isNotEmpty && !recentSearches.contains(value)) {
      recentSearches.insert(0, value);
      if (recentSearches.length > 10) {
        recentSearches.removeLast();
      }
    }
  }

  Future<void> searchRecipes() async {
    final query = _query.trim();
    if (query.isEmpty) return;

    isLoading.value = true;
    hasSearched.value = true;

    try {
      final result = await _recipeService.fetchRecipesBySearch(query);
      recipes.assignAll(result);
    } catch (e) {
      recipes.clear();
      Get.snackbar('Lỗi', 'Không thể tìm kiếm món ăn');
    } finally {
      isLoading.value = false;
    }

    print('SEARCH RECIPES : $recipes');
  }
}
