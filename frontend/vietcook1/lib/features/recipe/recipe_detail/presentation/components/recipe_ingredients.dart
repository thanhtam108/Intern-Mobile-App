import 'package:flutter/material.dart';

class RecipeIngredients extends StatelessWidget {
  final List<String> ingredients;
  const RecipeIngredients({super.key, required this.ingredients});
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Nguyên liệu',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ingredients
            .map((e) => Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Color(0xFF9BAE8C), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(e, style: const TextStyle(fontSize: 15))),
                  ],
                ))
            .toList(),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
        ),
      ),
    );
  }
}
