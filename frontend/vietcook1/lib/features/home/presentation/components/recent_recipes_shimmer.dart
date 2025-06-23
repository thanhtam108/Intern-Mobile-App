import 'package:flutter/material.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card_shimmer.dart';

class RecentRecipesShimmer extends StatelessWidget {
  const RecentRecipesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Món gần đây',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Xem tất cả', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => const HorizontalRecipeCardShimmer(),
        ),
      ],
    );
  }
}
