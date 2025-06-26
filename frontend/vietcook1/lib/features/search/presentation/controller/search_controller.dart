import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/top_rated_recipe_model.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/features/search/model/search_result_model.dart';
import 'package:vietcook1/core/utils/search_history_utils.dart';

class CustomSearchController extends GetxController {
  final RecipeService _recipeService = Get.find();

  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final searchResults = <SearchResult>[].obs;
  final recentSearches = <String>[].obs;
  final topRatedRecipes = <TopRatedRecipeModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
    fetchTopRatedRecipes();
  }

  Future<void> fetchTopRatedRecipes() async {
    update(['searchtopRatedRecipes']);
    final result = await _recipeService.fetchTopRatedRecipes();
    topRatedRecipes.assignAll((result.data ?? []).take(6).toList());
    update(['searchtopRatedRecipes']);
    print("Top rated recipes: ${result.data}");
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    // Nếu từ khóa thay đổi, clear kết quả cũ
    if (searchQuery.value != trimmed) {
      searchResults.clear();
    }

    searchQuery.value = trimmed;
    isLoading.value = true;

    try {
      final recipes = await _recipeService.search(trimmed);
      searchResults.assignAll(
        recipes.map((e) => SearchResult.fromRecipeModel(e)).toList(),
      );
      _updateRecentSearch(trimmed);
    } catch (_) {
      // Có thể log lỗi
    } finally {
      isLoading.value = false;
    }
  }

  void _updateRecentSearch(String query) async {
    if (!recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 6) {
        recentSearches.removeLast();
      }
      await SearchHistoryUtils.save(recentSearches);
    }
  }

  void _loadRecentSearches() async {
    final stored = await SearchHistoryUtils.load();
    recentSearches.assignAll(stored);
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
  }
}
