import 'step_model.dart';
import 'user_model.dart';
import 'category_model.dart';

class RecipeModel {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final int? view;
  final UserModel? user;
  final List<StepModel>? steps;
  final CategoryModel? category;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    this.view,
    required this.user,
    required this.steps,
    this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: List<String>.from(json['ingredients']),
      view: json['view'] ?? 0,
      user: json['userId'] != null ? UserModel.fromJson(json['userId']) : null,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepModel.fromJson(e))
          .toList(),
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
