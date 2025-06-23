import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';
import 'package:vietcook1/core/utils/date_time_utils.dart';
import 'package:vietcook1/features/category/presentation/controller/category_controller.dart';

class CategoryRecipesPage extends GetView<CategoryController> {
  final String categoryId;
  CategoryRecipesPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      id: 'category_recipes',
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(controller.category?.name ?? 'Danh mục'),
          centerTitle: true,
        ),
        body: controller.cateRecipes.isEmpty
            ? const Center(
                child: Text('Không có công thức nào trong danh mục này!'))
            : ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: controller.cateRecipes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final recipe = controller.cateRecipes[index];
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
                  );
                },
              ),
      ),
    );
  }
}
