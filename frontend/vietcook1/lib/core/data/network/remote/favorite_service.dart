import 'package:dio/dio.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

class FavoriteService {
  final Dio _dio;
  FavoriteService(this._dio);

  // 1. Lấy danh sách ID các món yêu thích
  Future<Result<List<String>>> fetchFavoriteRecipeIds() async {
    try {
      final res = await _dio.get(ApiConstants.favorites.common);
      final baseRp = BaseResponseDto.fromJson(res.data);

      final List<dynamic> data = baseRp.data;
      final List<String> favs =
          data.map((item) => item['recipeId'] as String).toList();

      return Result.success(favs);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  // 2. Lấy danh sách RecipeModel các món yêu thích
  Future<Result<List<RecipeModel>>> fetchFavoriteRecipes() async {
    try {
      final res = await _dio.get(ApiConstants.favorites.common);
      final baseRp = BaseResponseDto.fromJson(res.data);

      final List<dynamic> data = baseRp.data;
      final List<RecipeModel> recipes =
          data.map((item) => RecipeModel.fromJson(item)).toList();

      return Result.success(recipes);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  // Future<bool> isFavorite(String userId, String recipeId) async {
  //   try {
  //     final res = await _dio.get(
  //       '${ApiConstants.favorites.check}?userId=$userId&recipeId=$recipeId',
  //     );
  //     // API trả về true/false hoặc 1/0
  //     final baseRp = BaseResponseDto.fromJson(res.data);
  //     return baseRp.data == true || baseRp.data == 1;
  //   } catch (e) {
  //     return false;
  //   }
  // }

// Toggle favorite: nếu đã favorite thì xóa, chưa thì thêm
  Future<Result<Map<String, dynamic>>> addFavorite(String recipeId) async {
    try {
      final res = await _dio.post(
        ApiConstants.favorites.add,
        data: {
          'recipeId': recipeId,
        },
      );
      final baseRp = BaseResponseDto.fromJson(res.data);
      if (baseRp.statusCode == 201 && baseRp.data != null) {
        return Result.success(Map<String, dynamic>.from(baseRp.data));
      }
      return Result.error(AppException(
        statusCode: baseRp.statusCode,
        message: baseRp.message ?? 'Failed to add favorite',
      ));
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<bool>> removeFavorite(String recipeId) async {
    try {
      final res = await _dio.delete(
        '${ApiConstants.favorites.common}/$recipeId',
      );
      final baseRp = BaseResponseDto.fromJson(res.data);
      final data = baseRp.data;
      final success = baseRp.statusCode == 200 &&
          data is Map &&
          data['acknowledged'] == true &&
          data['deletedCount'] == 1;
      return Result.success(success);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }
}
