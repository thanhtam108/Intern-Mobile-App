import 'package:flutter/material.dart';

class RecipeDescription extends StatelessWidget {
  final String description;
  const RecipeDescription({super.key, required this.description});
  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Mô tả',
      child: Text(description, style: const TextStyle(fontSize: 15)),
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
