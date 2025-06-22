import 'package:flutter/material.dart';
import 'package:vietcook1/core/data/local/models/review_model.dart';

class RecipeReviews extends StatelessWidget {
  final List<ReviewModel> reviews;
  const RecipeReviews({super.key, required this.reviews});
  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const SizedBox.shrink();
    return _Section(
      title: 'Nhận xét',
      child: Column(
        children: reviews.map((review) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage:
                  AssetImage('lib/assets/images/avatar_placeholder.png'),
            ),
            title: Text(review.user?.name ?? 'Ẩn danh'),
            subtitle: Text(review.content ?? ''),
            trailing: review.rating != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      review.rating!.round(),
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                    ),
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Color(0xFF7BA23F),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}
