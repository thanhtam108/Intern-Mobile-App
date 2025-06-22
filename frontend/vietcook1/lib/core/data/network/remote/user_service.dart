import 'package:dio/dio.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/local/models/chef_model.dart';
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

  Future<Result<List<ChefModel>>> getTopChefs() async {
    try {
      final res = await _dio
          .get("${ApiConstants.baseUrl}${ApiConstants.auth.gettopUser}");
      print('Raw response: ${res.data}');

      final baseRp = BaseResponseDto.fromJson(res.data);

      if (baseRp.data is List) {
        final rawList = baseRp.data as List<dynamic>;
        final chefs = rawList.map((e) => ChefModel.fromJson(e)).toList();
        return Result.success(chefs);
      } else {
        print('⚠️ baseRp.data không phải List: ${baseRp.data.runtimeType}');
        return Result.error(AppException(message: 'Invalid data format'));
      }
    } on DioException catch (e) {
      print('❌ Lỗi gọi API: ${e.response?.data}');
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<List<ChefModel>>> searchChefs(String query) async {
    try {
      final res = await _dio.get('/user/search?query=$query');

      // Kiểm tra dữ liệu trả về có phải list không
      final baseRp = BaseResponseDto.fromJson(res.data);
      final rawList = baseRp.data as List<dynamic>;

      final chefs = rawList
          .map((e) => ChefModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Result.success(chefs);
    } on DioException catch (e) {
      // ✅ Log lỗi chi tiết
      print('❌ Lỗi gọi API searchChef:');
      print('Message: ${e.message}');
      print('Status code: ${e.response?.statusCode}');
      print('Data: ${e.response?.data}');

      return Result.error(AppException(
        message: e.response?.data?['message'] ?? 'Lỗi không xác định',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      // Trường hợp lỗi khác Dio
      return Result.error(AppException(message: e.toString()));
    }
  }
}
