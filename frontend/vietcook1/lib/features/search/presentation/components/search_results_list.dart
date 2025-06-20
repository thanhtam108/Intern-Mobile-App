import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';

class SearchResultsList extends StatelessWidget {
  final List<RecipeModel> recipes;
  const SearchResultsList({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 32),
          child: Text('Không tìm thấy món ăn phù hợp'),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return ListTile(
          key: ValueKey(recipe.id),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    recipe.imageUrl!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.image_not_supported, size: 48),
          title: Text(recipe.name),
          subtitle: recipe.description != null && recipe.description!.isNotEmpty
              ? Text(recipe.description!)
              : null,
          onTap: () {
            // TODO: mở trang chi tiết nếu cần
          },
        );
      },
    );
  }
}
