class TokenModel {
  final String? accessToken;

  TokenModel({
    this.accessToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}
