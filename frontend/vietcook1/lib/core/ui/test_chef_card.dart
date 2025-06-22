import 'package:flutter/material.dart';
import 'chef_card.dart'; // import ChefCard widget

class TestChefCardPage extends StatelessWidget {
  const TestChefCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chefDataList = [
      {
        "avatarUrl": "https://pbs.twimg.com/media/DujVLzcVYAAsTWH.jpg",
        "name": "thotho",
        "bio": "hello eollk dpmaos hello hello :))",
        "recipeCount": 13,
      },
      {
        "avatarUrl": "https://pbs.twimg.com/media/EkRos6zVoAE4lTp.jpg",
        "name": "dakha adsjah aha cahdcia ahda ahdsia asdia cia dsadia",
        "bio": "Không có giới thiệu.",
        "recipeCount": 1,
      },
      {
        "avatarUrl": "https://pbs.twimg.com/media/EkRos6zVoAE4lTp.jpg",
        "name": "lalala@gmail.com",
        "bio": "Không có giới thiệu.",
        "recipeCount": 1,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Test ChefCard")),
      body: SizedBox(
        height: 280,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          itemCount: chefDataList.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final data = chefDataList[index];
            return SizedBox(
              width: 140,
              child: ChefCard(
                avatarUrl: data['avatarUrl'],
                name: data['name'],
                bio: data['bio'],
                recipeCount: data['recipeCount'],
              ),
            );
          },
        ),
      ),
    );
  }
}
