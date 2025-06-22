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

  Future<Result<UserModel>> updateUser({
    required String? id,
    required String? name,
    required String? bio,
    required String? email,
    String? avatarUrl,
  }) async {
    try {
      final res = await _dio.put(
        '${ApiConstants.user.update}/$id',
        data: {
          'name': name,
          'bio': bio,
          'email': email,
          'avatarUrl': avatarUrl,
        },
      );

      final baseRp = BaseResponseDto.fromJson(res.data);
      final result = UserModel.fromJson(baseRp.data);
      return Result.success(result);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }
}
