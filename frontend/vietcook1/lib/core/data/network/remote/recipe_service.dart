import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/exceptions/status_code.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

import '../../local/models/recipe_model.dart';

class RecipeService {
  final Dio _dio = Dio();

  Future<Result<List<RecipeModel>>> fetchRecipes(
      String name, String email, String password) async {
    try {
      final res = await _dio.get(ApiConstants.recipes.getAll);
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

  Future<Result<RecipeModel>> fetchRecipeById(String id) async {
    try {
      final res = await _dio.get('${ApiConstants.recipes.common}$id');
      final baseRp = BaseResponseDto.fromJson(res.data);
      final recipe = RecipeModel.fromJson(baseRp.data);
      return Result.success(recipe);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<List<RecipeModel>>> fetchRecipesByUserId(String userId) async {
    try {
      final res = await _dio.get('${ApiConstants.recipes.getByUserId}$userId');
      final baseRp = BaseResponseDto.fromJson(res.data);

      List<RecipeModel> recipes = <RecipeModel>[];
      baseRp.data.forEach((element) {
        recipes.add(RecipeModel.fromJson(element));
      });
      return Result.success(recipes);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<List<RecipeModel>>> fetchRecipesByCategoryId(
      String categoryId) async {
    try {
      final res =
          await _dio.get('${ApiConstants.recipes.getByCategoryId}$categoryId');
      final baseRp = BaseResponseDto.fromJson(res.data);

      List<RecipeModel> recipes = <RecipeModel>[];
      baseRp.data.forEach((element) {
        recipes.add(RecipeModel.fromJson(element));
      });
      return Result.success(recipes);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  // Future<Result<List<RecipeModel>>> fetchRecipesBySearch(String query) async {
  //   try {
  //     final res =
  //         await _dio.get('/recipes/search', queryParameters: {'q': query});
  //     final baseRp = BaseResponseDto.fromJson(res.data);

  //     List<RecipeModel> recipes = <RecipeModel>[];
  //     baseRp.data.forEach((element) {
  //       recipes.add(RecipeModel.fromJson(element));
  //     });
  //     return Result.success(recipes);
  //   } on DioException catch (e) {
  //     return Result.error(AppException.parse(e));
  //   }
  // }

  Future<Result<void>> createRecipe(RecipeModel recipe) async {
    try {
      final recipeJson = recipe.toJson();

      final res =
          await _dio.post(ApiConstants.recipes.create, data: recipeJson);

      final baseRp = BaseResponseDto.fromJson(res.data);

      if (baseRp.statusCode == StatusCode.success) {
        return Result.success(null);
      } else {
        return Result.error(
          AppException(
            statusCode: baseRp.statusCode,
            message: baseRp.message,
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<void>> updateRecipe(RecipeModel recipe) async {
    try {
      final res = await _dio.put(
        '${ApiConstants.recipes.common}/${recipe.id}',
        data: recipe.toJson(),
      );

      final baseRp = BaseResponseDto.fromJson(res.data);

      if (baseRp.statusCode == StatusCode.success) {
        return Result.success(null);
      } else {
        return Result.error(
          AppException(
            statusCode: baseRp.statusCode,
            message: baseRp.message ?? 'Failed to update recipe',
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<void>> deleteRecipe(String id) async {
    try {
      final res = await _dio.delete('${ApiConstants.recipes.common}/$id');
      final baseRp = BaseResponseDto.fromJson(res.data);
      if (baseRp.statusCode == StatusCode.success) {
        return Result.success(null);
      } else {
        return Result.error(AppException(
          statusCode: baseRp.statusCode,
          message: baseRp.message ?? 'Failed to delete recipe',
        ));
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<List<RecipeModel>>> fetchTopRatedRecipes() async {
    try {
      final res = await _dio.get(ApiConstants.recipes.getTopRated);
      final baseRp = BaseResponseDto.fromJson(res.data);

      List<RecipeModel> recipes = <RecipeModel>[];
      baseRp.data.forEach((element) {
        recipes.add(RecipeModel.fromJson(element));
      });
      return Result.success(recipes);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<List<RecipeModel>>> fetchRecipesByCategoryName(
      String categoryName) async {
    try {
      final res =
          await _dio.get('${ApiConstants.recipes.getByCateName}/$categoryName');
      final baseRp = BaseResponseDto.fromJson(res.data);

      List<RecipeModel> recipes = <RecipeModel>[];
      baseRp.data.forEach((element) {
        recipes.add(RecipeModel.fromJson(element));
      });
      return Result.success(recipes);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  // Future<Result<List<RecipeModel>>> fetchRecipesByUserName(
  //     String userName) async {
  //   try {
  //     final res =
  //         await _dio.get('${ApiConstants.recipes.getByUserId}/$userName');
  //     final baseRp = BaseResponseDto.fromJson(res.data);

  //     List<RecipeModel> recipes = <RecipeModel>[];
  //     baseRp.data.forEach((element) {
  //       recipes.add(RecipeModel.fromJson(element));
  //     });
  //     return Result.success(recipes);
  //   } on DioException catch (e) {
  //     return Result.error(AppException.parse(e));
  //   }
  // }

  // Future<Result<List<RecipeModel>>> fetchRecipesByUserEmail(
  //     String userEmail) async {
  //   try {
  //     final res = await _dio.get('/recipes/user/email/$userEmail');
  //     final baseRp = BaseResponseDto.fromJson(res.data);

  //     List<RecipeModel> recipes = <RecipeModel>[];
  //     baseRp.data.forEach((element) {
  //       recipes.add(RecipeModel.fromJson(element));
  //     });
  //     return Result.success(recipes);
  //   } on DioException catch (e) {
  //     return Result.error(AppException.parse(e));
  //   }
  // }
}
