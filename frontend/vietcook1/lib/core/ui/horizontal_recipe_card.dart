import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';

class HorizontalRecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final bool isFavorite;

  const HorizontalRecipeCard({
    super.key,
    required this.recipe,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.network(
              recipe.imageUrl != null
                  ? recipe.imageUrl!
                  : 'lib/assets/images/placeholder.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(recipe.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      Text('${recipe.createdAt}' 'Lượt đánh giá',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye, size: 14, color: Colors.grey),
                      Text('${recipe.view ?? 0}' 'Lượt xem',
                          style: TextStyle(fontSize: 12)),
                      Spacer(),
                      Text(recipe.user.name ?? 'Unknown',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 4),
                      CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(recipe.user.avatarUrl ??
                              'lib/assets/images/avatar_placeholder.png')),
                    ],
                  )
                ],
              ),
            ),
          ),

          // Heart icon
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
