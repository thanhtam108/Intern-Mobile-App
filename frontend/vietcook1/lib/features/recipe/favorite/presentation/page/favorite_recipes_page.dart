import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card_shimmer.dart';
import 'package:vietcook1/core/utils/date_time_utils.dart';
import 'package:vietcook1/features/recipe/favorite/presentation/controller/favorite_controller.dart';

class FavoriteRecipesPage extends GetView<FavoriteRecipesController> {
  const FavoriteRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteRecipesController>(
      id: 'favorite_recipes',
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Công thức yêu thích'),
          centerTitle: true,
        ),
        body: controller.isLoading
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, __) => const HorizontalRecipeCardShimmer(),
              )
            : controller.favoriteRecipes.isEmpty
                ? const Center(
                    child: Text('Bạn chưa có công thức yêu thích nào!'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: controller.favoriteRecipes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final recipe = controller.favoriteRecipes[index];
                      return HorizontalRecipeCard(
                        imageUrl: recipe.imageUrl ?? '',
                        name: recipe.name,
                        description: recipe.description,
                        rating: recipe.averageRating ?? 0.0,
                        views: recipe.view ?? 0,
                        authorName: recipe.user.name ?? '',
                        authorAvatarUrl: recipe.user.avatarUrl ?? '',
                        createdAt: DateTimeUtils.timeAgo(recipe.createdAt),
                        isFavorite: true,
                        onFavoriteToggle: () {
                          controller.toggleFavorite(recipe.id);
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
