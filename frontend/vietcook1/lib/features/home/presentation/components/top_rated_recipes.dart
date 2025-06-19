import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';

class TopRatedRecipes extends StatelessWidget {
  final List<RecipeModel> recipes;
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
            return ListTile(
              title: Text(recipe.name),
              subtitle: Text(recipe.description),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(recipe.imageUrl ?? ''),
              ),
            );
          },
        ),
      ],
    );
  }
}
