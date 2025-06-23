import 'package:flutter/material.dart';
import 'package:vietcook1/core/ui/vertical_recipe_card_shimmer'; // Your shimmer card here

class TopRatedRecipesShimmer extends StatelessWidget {
  const TopRatedRecipesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Món được đánh giá cao',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => const VerticalRecipeCardShimmer(),
          ),
        ),
      ],
    );
  }
}
