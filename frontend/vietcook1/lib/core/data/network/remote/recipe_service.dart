import 'package:dio/dio.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

import '../../local/models/recipe_model.dart';

class RecipeService {
  final Dio _dio = Dio();

  Future<Result<List<RecipeModel>>> fetchRecipes(
      String name, String email, String password) async {
    try {
      final res = await _dio.get('/recipes/all');
      final baseRp = BaseResponseDto.fromJson(res.data);

      List<RecipeModel> tags = <RecipeModel>[];
      final result = baseRp.data.forEach((element) {
        tags.add(RecipeModel.fromJson(element));
      });
      return Result.success(result);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }
}
