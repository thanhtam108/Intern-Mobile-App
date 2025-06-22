import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/local/models/top_rated_recipe_model.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';

class TopRatedRecipes extends StatelessWidget {
  final List<TopRatedRecipeModel> recipes;
  const TopRatedRecipes({required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.recipe_detail,
                    arguments: {'recipeId': recipe.id});
              },
              child: HorizontalRecipeCard(
                recipe: recipe, // Đảm bảo recipe là RecipeModel hoặc sửa HorizontalRecipeCard nhận TopRatedRecipeModel
                isFavorite: false, // hoặc truyền trạng thái yêu thích nếu có
              ),
            );
          },
        ),
      ],
    );
  }
}
