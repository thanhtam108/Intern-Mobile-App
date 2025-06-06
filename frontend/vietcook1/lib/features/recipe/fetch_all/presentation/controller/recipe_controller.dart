import 'package:flutter/material.dart';

import '../../../../../core/data/local/models/recipe_model.dart';
import '../../../../../core/data/network/remote/recipe_service.dart';

class RecipeController extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  List<RecipeModel> recipes = [];
  bool isLoading = false;

  Future<void> loadRecipes() async {
    isLoading = true;
    notifyListeners();

    try {} catch (e) {
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
