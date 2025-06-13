import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/exceptions/status_code.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

class AuthService extends GetxService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Result<String>> register(
      String name, String email, String password) async {
    try {
      final res = await _dio.post(ApiConstants.auth.register, data: {
        "name": name,
        "email": email,
        "password": password,
      });
      final baseRp = BaseResponseDto.fromJson(res.data);
      return Result.success(baseRp.message ?? "Đăng ký thành công");
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<Map<String, dynamic>>> verifyOtp(
      String email, String otp) async {
    try {
      final response = await _dio.post(
        ApiConstants.auth.verifyOtp,
        data: {
          "email": email,
          "otp": otp,
        },
      );

      final baseResponse = BaseResponseDto.fromJson(response.data);

      if ((baseResponse.statusCode == StatusCode.success) ||
          (baseResponse.statusCode == StatusCode.noContent)) {
        return Result.success(baseResponse.data as Map<String, dynamic>);
      } else {
        return Result.error(
          AppException(
            statusCode: baseResponse.statusCode,
            message: baseResponse.message,
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<Result<void>> resendOtp(String email) async {
    try {
      final response = await _dio.post(
        ApiConstants.auth.resendOtp,
        data: {"email": email},
      );
      final baseResponse = BaseResponseDto.fromJson(response.data);
      // Nếu statusCode là 201, coi là thành công
      if (baseResponse.statusCode == StatusCode.success) {
        return Result.success(null);
      } else {
        return Result.error(
          AppException(
            statusCode: baseResponse.statusCode,
            message: baseResponse.message,
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<Result<Map<String, dynamic>>> login(
      String email, String password) async {
    try {
      final res = await _dio.post(ApiConstants.auth.login, data: {
        'email': email,
        'password': password,
      });
      final baseResponse = BaseResponseDto.fromJson(res.data);

      if (baseResponse.statusCode == StatusCode.success ||
          baseResponse.statusCode == StatusCode.noContent) {
        return Result.success(baseResponse.data as Map<String, dynamic>);
      } else {
        return Result.error(
          AppException(
            statusCode: baseResponse.statusCode,
            message: baseResponse.message,
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }
}
