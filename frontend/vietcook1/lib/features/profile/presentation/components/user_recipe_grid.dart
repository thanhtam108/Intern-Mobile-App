import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';
import 'package:vietcook1/core/utils/date_time_utils.dart';
import 'package:vietcook1/features/profile/presentation/controller/profile_controller.dart';

class UserRecipeGrid extends GetView<ProfileController> {
  const UserRecipeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        final recipes = controller.userRecipes;
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return HorizontalRecipeCard(
              imageUrl: recipe.imageUrl ?? '',
              name: recipe.name,
              description: recipe.description,
              rating: recipe.averageRating ?? 0.0,
              views: recipe.view ?? 0,
              authorName: recipe.user.name ?? '',
              authorAvatarUrl: recipe.user.avatarUrl ?? '',
              createdAt: DateTimeUtils.timeAgo(recipe.createdAt),
              isFavorite: false,
              onTap: () {
                // Điều hướng sang trang chi tiết
                Get.toNamed(Routes.recipe_detail,
                    arguments: {'recipeId': recipe.id});
              },
              onFavoriteToggle: () => controller.toggleFavorite(recipe.id),
            );
          },
        );
      }),
    );
  }
}
