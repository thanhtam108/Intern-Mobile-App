import 'package:dio/dio.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import '../../local/models/recipe_model.dart';

class RecipeService {
  final Dio _dio = Dio();

  Future<List<RecipeModel>> fetchRecipes() async {
    try {
      final response = await _dio.get('/recipes/all');

      List<dynamic> data = response.data['data'];
      print(data);
      return data.map((json) => RecipeModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load recipes: ${e.message}');
    }
  }
}
