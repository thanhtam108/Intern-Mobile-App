import 'package:flutter/material.dart';

class VerticalRecipeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double rating;
  final int views;
  final String authorName;
  final String authorAvatarUrl;
  final String createdAt;
  final bool isFavorite;

  const VerticalRecipeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
    required this.views,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.createdAt,
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imageUrl.isNotEmpty
                      ? imageUrl
                      : 'lib/assets/images/placeholder.png',
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF3A6B1B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    Text(
                      rating.toStringAsFixed(1), // Hiển thị 1 số thập phân
                      style: const TextStyle(fontSize: 13),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.visibility,
                            size: 16, color: Colors.grey),
                        SizedBox(width: 2),
                        Text('$views N', style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundImage: NetworkImage(
                        authorAvatarUrl.isNotEmpty
                            ? authorAvatarUrl
                            : 'lib/assets/images/avatar_placeholder.png',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(authorName,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text(
                      createdAt,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
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
