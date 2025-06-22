import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/local/models/top_rated_recipe_model.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/exceptions/status_code.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/features/insert/models/insert_recipe_model.dart';
import '../../local/models/recipe_model.dart';

class RecipeService {
  final Dio _dio;
  RecipeService(this._dio);

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

  Future<List<RecipeModel>> search(String query) async {
    final res = await Dio().get(
      '${ApiConstants.baseUrl}${ApiConstants.recipes.getsearch}',
      queryParameters: {'query': query},
    );

    final List<dynamic> data = res.data['data'];
    return data.map((e) => RecipeModel.fromJson(e)).toList();
  }

  Future<Result<String>> createRecipe(InsertRecipeModel recipe) async {
    try {
      final recipeJson = recipe.toJson();

      final res =
          await _dio.post(ApiConstants.recipes.create, data: recipeJson);

      final baseRp = BaseResponseDto.fromJson(res.data);

      // final recipeResult = RecipeModel.fromJson(baseRp.data);
      return Result.success(baseRp.message ?? 'Recipe created successfully');
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

  Future<Result<List<TopRatedRecipeModel>>> fetchTopRatedRecipes() async {
    try {
      final res = await _dio.get(ApiConstants.recipes.getTopRated);
      final baseRp = BaseResponseDto.fromJson(res.data);
      print("Top rated recipes: ${baseRp.data}");
      List<TopRatedRecipeModel> recipes = <TopRatedRecipeModel>[];
      baseRp.data.forEach((element) {
        recipes.add(TopRatedRecipeModel.fromJson(element));
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
}
