import '../../../../features/main/models/user_model.dart';
import 'review_model.dart';

class TopRatedRecipeModel {
  final String id;
  final String name;
  final String description;
  // final List<String> ingredients;
  final int view;
  // final String? duration;
  final UserModel user; // Vì dữ liệu trả về là String, không phải object
  // final List<StepModel> steps;
  final List<ReviewModel> reviews;
  final String categoryId; // Vì dữ liệu trả về là ID string
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double averageRating;

  TopRatedRecipeModel({
    required this.id,
    required this.name,
    required this.description,
    // required this.ingredients,
    required this.view,
    // this.duration,
    required this.user,
    // required this.steps,
    required this.reviews,
    required this.categoryId,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    required this.averageRating,
  });

  factory TopRatedRecipeModel.fromJson(Map<String, dynamic> json) {
    return TopRatedRecipeModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      view: (json['view'] as int?) ?? 0,
      user:
          json['user'] != null ? UserModel.fromJson(json['user']) : UserModel(),
      categoryId: json['category'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e))
              .toList() ??
          [],
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'view': view,
      'userId': user,
      'category': categoryId,
      'imageUrl': imageUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'averageRating': averageRating,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}
