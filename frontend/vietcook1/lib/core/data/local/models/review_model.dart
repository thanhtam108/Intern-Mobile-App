import 'user_model.dart';

class ReviewModel {
  final String id;
  final String content;
  final double rating;
  final UserModel user; // Người dùng viết review
  final String recipeId; // ID của công thức được review
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.id,
    required this.content,
    required this.rating,
    required this.user,
    required this.recipeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] as String,
      content: json['content'] as String,
      rating: (json['rating'] as num).toDouble(),
      user: UserModel.fromJson(json['userId']),
      recipeId: json['recipeId'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'rating': rating,
      'userId': user.toJson(),
      'recipeId': recipeId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
