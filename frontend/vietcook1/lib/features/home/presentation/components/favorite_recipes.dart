import 'package:flutter/material.dart';
import 'package:vietcook1/core/ui/vertical_recipe_card.dart';

class FavoriteRecipes extends StatelessWidget {
  final List<Map<String, dynamic>> recipes;

  const FavoriteRecipes({
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
                'Món yêu thích',
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
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return VerticalRecipeCard(recipe: recipe);
            },
          ),
        ),
      ],
    );
  }
}
