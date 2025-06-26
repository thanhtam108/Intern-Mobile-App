import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';
import 'package:vietcook1/core/utils/date_time_utils.dart';
import 'package:vietcook1/features/home/presentation/controller/home_controller.dart';

class RecentRecipes extends GetView<HomeController> {
  final List<RecipeModel> recipes;

  const RecentRecipes({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'updateHome',
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Món gần đây',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý khi nhấn "Xem tất cả"
                  },
                  child: Text('Xem tất cả'),
                ),
              ],
            ),
          ),
          SizedBox(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: recipes.length,
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
                  isFavorite: controller.isFavorite(recipe.id),
                  onTap: () {
                    // Điều hướng sang trang chi tiết
                    Get.toNamed(Routes.recipe_detail,
                        arguments: {'recipeId': recipe.id});
                  },
                  onFavoriteToggle: () => controller.toggleFavorite(recipe.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
