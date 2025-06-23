class ChefModel {
  final String id;
  final String name;
  final String bio;
  final String email;
  final String avatarUrl;
  final int recipeCount;

  ChefModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.email,
    required this.avatarUrl,
    required this.recipeCount,
  });

  factory ChefModel.fromJson(Map<String, dynamic> json) {
    return ChefModel(
      id: json['userId'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      recipeCount: json['recipeCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'bio': bio,
      'email': email,
      'avatarUrl': avatarUrl,
      'recipeCount': recipeCount,
    };
  }
}
