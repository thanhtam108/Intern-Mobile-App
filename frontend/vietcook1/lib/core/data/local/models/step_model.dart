class StepModel {
  final String id;
  final String recipeID;
  final String stepName;
  final String stepDescription;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  StepModel({
    required this.id,
    required this.recipeID,
    required this.stepName,
    required this.stepDescription,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      id: json['_id'] as String,
      recipeID: json['recipeID'] as String,
      stepName: json['stepName'] as String,
      stepDescription: json['stepDescription'] as String,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepName': stepName,
      'stepDescription': stepDescription,
      'imageUrl': imageUrl,
    };
  }
}
