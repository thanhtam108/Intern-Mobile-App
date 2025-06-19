import 'package:vietcook1/core/data/local/models/step_model.dart';

class InsertRecipeModel {
  final String name;
  final String description;
  final List<String> ingredients;
  final int view;
  final String? duration;
  final String userId;
  final List<StepModel> steps;
  final String? category;
  final String? imageUrl;

  InsertRecipeModel({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.userId,
    this.view = 0,
    this.duration,
    required this.steps,
    this.category,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'view': view,
      'duration': duration,
      'ingredients': ingredients,
      'category': category,
      'userId': userId,
      'steps': steps.map((e) => e.toJson()).toList(),
      'imageUrl': imageUrl,
    };
  }
}
