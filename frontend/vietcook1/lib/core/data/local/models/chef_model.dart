class ChefModel {
  final String userId;
  final String name;
  final String bio;
  final String avatarUrl;
  final int recipeCount;

  ChefModel({
    required this.userId,
    required this.name,
    required this.bio,
    required this.avatarUrl,
    required this.recipeCount,
  });

  factory ChefModel.fromJson(Map<String, dynamic> json) {
    return ChefModel(
      userId: json['userId'],
      name: json['name'] ?? 'Không tên',
      bio: json['bio'] ?? 'Không bio',
      avatarUrl: json['avatarUrl'] ??
          'https://hoseiki.vn/wp-content/uploads/2025/03/avatar-mac-dinh-4.jpg',
      recipeCount: json['recipeCount'] ?? 0,
    );
  }
}
