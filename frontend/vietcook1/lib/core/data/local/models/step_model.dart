class StepModel {
  final String? id;
  final String? recipeID;
  final String? stepName;
  final String? stepDescription;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StepModel({
    this.id,
    this.recipeID,
    this.stepName,
    this.stepDescription,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      id: json['_id'] as String?,
      recipeID: json['recipeID'] as String?,
      stepName: json['stepName'] as String?,
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
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}
