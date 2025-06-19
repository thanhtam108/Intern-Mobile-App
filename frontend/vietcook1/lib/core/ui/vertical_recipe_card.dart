import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';

class VerticalRecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final bool isFavorite;

  const VerticalRecipeCard({
    super.key,
    required this.recipe,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  recipe.imageUrl ?? 'lib/assets/images/placeholder.png',
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              )
            ],
          ),

          // Text + info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  recipe.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.orange),
                    Text('${recipe.reviews}', style: TextStyle(fontSize: 12)),
                    Icon(Icons.visibility, size: 14, color: Colors.grey),
                    Text('${recipe.view} N', style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                            recipe.user.avatarUrl != null
                                ? recipe.user.avatarUrl!
                                : 'lib/assets/images/avatar_placeholder.png')),
                    const SizedBox(width: 4),
                    Text(recipe.user.name ?? "",
                        style: TextStyle(fontSize: 12)),
                    Spacer(),
                    Text(recipe.createdAt.toString(),
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
