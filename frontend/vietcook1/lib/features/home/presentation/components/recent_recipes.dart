import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';
import 'package:vietcook1/core/utils/date_time_utils.dart';

class RecentRecipes extends StatelessWidget {
  final List<RecipeModel> recipes;

  const RecentRecipes({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                isFavorite: false, // Truyền trạng thái yêu thích nếu có
              );
            },
          ),
        ),
      ],
    );
  }
}
