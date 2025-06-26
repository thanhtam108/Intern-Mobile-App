import 'package:flutter/material.dart';

class HorizontalRecipeCard extends StatelessWidget {
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onTap; // Thêm dòng này
  final String imageUrl;
  final String name;
  final String description;
  final double rating;
  final int views;
  final String authorName;
  final String authorAvatarUrl;
  final String createdAt;
  final bool isFavorite;

  const HorizontalRecipeCard({
    super.key,
    this.onFavoriteToggle,
    this.onTap, // Thêm dòng này
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
    required this.views,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.createdAt,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Thêm dòng này
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                // Image
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12)),
                    child: Image.network(
                      imageUrl.isNotEmpty
                          ? imageUrl
                          : 'lib/assets/images/placeholder.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF3A6B1B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.orange),
                            const SizedBox(width: 2),
                            Text(
                              '${rating.toStringAsFixed(1)} Đánh giá',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.remove_red_eye,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 2),
                            Text(
                              '$views Lượt xem',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                            const Spacer(),
                            Text(
                              authorName,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                authorAvatarUrl.isNotEmpty
                                    ? authorAvatarUrl
                                    : 'lib/assets/images/avatar_placeholder.png',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Nút thích ở góc phải trên
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                padding:
                    const EdgeInsets.all(4), // Thêm dòng này cho giống vertical
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 30,
                  ),
                  onPressed: onFavoriteToggle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
