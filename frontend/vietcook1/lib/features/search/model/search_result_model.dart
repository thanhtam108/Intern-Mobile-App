import 'package:vietcook1/core/data/local/models/recipe_model.dart';

class SearchResult {
  final String id;
  final String name;
  final String imageUrl;

  SearchResult({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  factory SearchResult.fromRecipeModel(RecipeModel model) {
    return SearchResult(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl ?? '',
    );
  }
}
