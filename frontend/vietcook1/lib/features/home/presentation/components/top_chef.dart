import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/local/models/chef_model.dart';
import 'package:vietcook1/core/ui/chef_card.dart';

class TopChef extends StatelessWidget {
  final List<ChefModel> chefs;

  const TopChef({super.key, required this.chefs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Top Chef',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: chefs.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final chef = chefs[index];
              return ChefCard(
                avatarUrl: chef.avatarUrl,
                name: chef.name,
                bio: chef.bio,
                recipeCount: chef.recipeCount,
              );
            },
          ),
        ),
      ],
    );
  }
}
