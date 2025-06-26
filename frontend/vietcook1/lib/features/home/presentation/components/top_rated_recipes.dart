import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/top_rated_recipe_model.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/ui/vertical_recipe_card.dart';
import 'package:vietcook1/core/utils/date_time_utils.dart';
import 'package:vietcook1/features/home/presentation/controller/home_controller.dart';

class TopRatedRecipes extends GetView<HomeController> {
  final List<TopRatedRecipeModel> recipes;

  const TopRatedRecipes({required this.recipes});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'topRatedRecipes',
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Món được đánh giá cao',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 270, // Đặt chiều cao cho ListView ngang
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.recipe_detail,
                        arguments: {'recipeId': recipe.id});
                  },
                  child: VerticalRecipeCard(
                    imageUrl: recipe.imageUrl ?? '',
                    name: recipe.name,
                    description: recipe.description,
                    rating: recipe.averageRating,
                    views: recipe.view,
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
        ],
      ),
    );
  }
}
