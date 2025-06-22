import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/features/profile/presentation/controller/profile_controller.dart';

class UserRecipeGrid extends GetView<ProfileController> {
  UserRecipeGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        final recipes = controller.userRecipes;
        return GridView.builder(
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
                    recipe.imageUrl ?? '',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  recipe.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
