class UserModel {
  final String id;

  UserModel({required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['_id'] as String);
  }
}
