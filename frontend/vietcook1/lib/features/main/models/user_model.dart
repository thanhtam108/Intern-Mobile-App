class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? bio;
  final String? avatarUrl;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.bio,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'bio': bio,
      'avatarUrl': avatarUrl,
    };
  }
}
