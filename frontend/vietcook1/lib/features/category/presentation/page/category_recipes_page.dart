import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card_shimmer.dart';
import 'package:vietcook1/core/utils/date_time_utils.dart';
import 'package:vietcook1/features/category/presentation/controller/category_controller.dart';

class CategoryRecipesPage extends GetView<CategoryController> {
  CategoryRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      id: 'category_recipes',
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(controller.args.name),
          centerTitle: true,
        ),
        body: controller.isLoading
            ? ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    const HorizontalRecipeCardShimmer(),
              )
            : controller.cateRecipes.isEmpty
                ? const Center(
                    child: Text('Không có công thức nào trong danh mục này!'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: controller.cateRecipes.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final recipe = controller.cateRecipes[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.recipe_detail,
                              arguments: {'recipeId': recipe.id});
                        },
                        child: HorizontalRecipeCard(
                          imageUrl: recipe.imageUrl ?? '',
                          name: recipe.name,
                          description: recipe.description,
                          rating: recipe.averageRating ?? 0.0,
                          views: recipe.view ?? 0,
                          authorName: recipe.user.name ?? '',
                          authorAvatarUrl: recipe.user.avatarUrl ?? '',
                          createdAt: DateTimeUtils.timeAgo(
                              recipe.createdAt ?? DateTime.now()),
                          isFavorite: controller.isFavorite(recipe.id),
                          onFavoriteToggle: () {
                            controller.toggleFavorite(recipe.id);
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
