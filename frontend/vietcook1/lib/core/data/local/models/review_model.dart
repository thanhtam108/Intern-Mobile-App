import '../../../../features/main/models/user_model.dart';

class ReviewModel {
  final String? id;
  final String? content;
  final double? rating;
  final UserModel? user; // Người dùng viết review
  final String? recipeId; // ID của công thức được review
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReviewModel({
    this.id,
    this.content,
    this.rating,
    this.user,
    this.recipeId,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] as String?,
      content: json['content'] as String?,
      rating: (json['rating'] as num).toDouble(),
      user:
          json['user'] != null ? UserModel.fromJson(json['user']) : UserModel(),
      recipeId: json['recipeId'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'rating': rating, // Chỉ lưu ID của người dùng
      'recipeId': recipeId,
    };
  }
}
