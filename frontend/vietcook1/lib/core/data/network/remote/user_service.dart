import 'package:dio/dio.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/features/main/models/user_model.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

class UserService {
  final Dio _dio;

  UserService(this._dio);
  Future<Result<List<RecipeModel>>> fetchFavoriteRecipes(String id) async {
    try {
      final res = await _dio.get('${ApiConstants.favorites.common}/$id');
      final baseRp = BaseResponseDto.fromJson(res.data);

      List<RecipeModel> favs = <RecipeModel>[];
      final result = baseRp.data.forEach((element) {
        favs.add(RecipeModel.fromJson(element));
      });
      return Result.success(result);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<UserModel>> getUser() async {
    try {
      final res = await _dio.get(
        ApiConstants.auth.getUser,
      );

      final baseRp = BaseResponseDto.fromJson(res.data);
      final result = UserModel.fromJson(baseRp.data);
      return Result.success(result);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }
}
