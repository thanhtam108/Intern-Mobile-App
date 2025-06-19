import 'step_model.dart';
import '../../../../features/main/models/user_model.dart';
import 'category_model.dart';
import 'review_model.dart';

class RecipeModel {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final int? view;
  final String? duration;
  final UserModel user;
  final List<StepModel>? steps;
  final List<ReviewModel>? reviews;
  final CategoryModel? category;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? averageRating;

  RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    this.view,
    this.duration,
    required this.user,
    required this.steps,
    this.reviews,
    this.category,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.averageRating,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: List<String>.from(json['ingredients']),
      view: json['view'] ?? 0,
      duration: json['duration'] as String?,
      user: json['userId'],
      // != null ? UserModel.fromJson(json['userId']) : null,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepModel.fromJson(e))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e))
          .toList(),
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'view': view ?? 0,
      'duration': duration,
      'ingredients': ingredients,
      'category': category?.id,
      'userId': user.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'id': id,
      'steps': steps != null ? steps!.map((e) => e.toJson()).toList() : [],
      'averageRating': averageRating,
      'reviews':
          reviews != null ? reviews!.map((e) => e.toJson()).toList() : [],
      'imageUrl': imageUrl,
    };
  }
}
