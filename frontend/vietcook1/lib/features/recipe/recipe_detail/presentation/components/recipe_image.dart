import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String? imageUrl;
  const RecipeImage({super.key, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!)
              : const AssetImage('lib/assets/images/placeholder.png')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
