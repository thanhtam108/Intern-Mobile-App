import 'package:flutter/material.dart';

class RecipeHeader extends StatelessWidget {
  final String name;
  final String category;
  final String duration;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final String author;
  const RecipeHeader({
    super.key,
    required this.name,
    required this.category,
    required this.duration,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tên món ăn + nút yêu thích
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: onFavoriteTap,
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Loại món ăn + thời lượng
          Row(
            children: [
              Text(category, style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 8),
              const Text('•', style: TextStyle(color: Colors.grey)),
              const SizedBox(width: 8),
              Text(duration, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          // Tác giả
          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundImage:
                    AssetImage('lib/assets/images/avatar_placeholder.png'),
              ),
              const SizedBox(width: 8),
              Text(author, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
