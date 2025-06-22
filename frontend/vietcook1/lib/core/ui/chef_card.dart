import 'package:flutter/material.dart';

class ChefCard extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String bio;
  final int recipeCount;

  const ChefCard({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.bio,
    required this.recipeCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Cố định chiều cao card
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                avatarUrl,
                height: 100, // Chiều cao ảnh cố định
                width: double.infinity,
                fit: BoxFit.cover, // Resize cho đẹp, không bị méo
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bio,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.restaurant, size: 14),
                      const SizedBox(width: 4),
                      Text('$recipeCount công thức',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
