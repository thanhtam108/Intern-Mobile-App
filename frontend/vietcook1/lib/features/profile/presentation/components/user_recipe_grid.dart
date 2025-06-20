// Component: User Recipe Grid
import 'package:flutter/material.dart';
import 'package:vietcook1/features/main/models/user_model.dart';

class UserRecipeGrid extends StatelessWidget {
  const UserRecipeGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final recipes = [
      {
        'name': 'Bánh mì chảo',
        'img': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836'
      },
      {
        'name': 'Phở bò',
        'img': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c'
      },
      {
        'name': 'Phở gà',
        'img': 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0'
      },
      {
        'name': 'Bún riêu cua',
        'img': 'https://images.unsplash.com/photo-1502741338009-cac2772e18bc'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe['img']!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                recipe['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}
