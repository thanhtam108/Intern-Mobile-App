import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/components/recipe_description.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/components/recipe_header.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/components/recipe_image.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/components/recipe_ingredients.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/components/recipe_reviews.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/components/recipe_steps.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/controller/recipe_detail_controller.dart';

class RecipeDetailPage extends GetView<RecipeDetailController> {
  final String recipeId;
  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết món ăn',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF3F6F3),
      body: SingleChildScrollView(
        child: GetBuilder<RecipeDetailController>(
          id: 'recipeDetails',
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                ),
                // Recipe Image
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RecipeImage(
                      imageUrl: controller.recipe.value?.imageUrl ?? ''),
                ),
                // Recipe Header
                RecipeHeader(
                  name: controller.recipe.value?.name ?? '',
                  category: controller.recipe.value?.category?.name ?? '',
                  duration: controller.recipe.value?.duration ?? '',
                  isFavorite: controller.isFavorite.value,
                  onFavoriteTap: controller.toggleFavorite,
                  author: controller.recipe.value?.user.name ?? '',
                ),
                // Description
                RecipeDescription(
                    description: controller.recipe.value?.description ?? ''),
                // Ingredients
                RecipeIngredients(
                    ingredients: controller.recipe.value?.ingredients ?? []),
                // Steps
                RecipeSteps(steps: controller.recipe.value?.steps ?? []),
                // Reviews
                RecipeReviews(reviews: controller.recipe.value?.reviews ?? []),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
