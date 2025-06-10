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
      final res = await _dio.post(ApiConstants.register, data: {
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

  Future<Result<String>> verifyOtp(String email, String otp) async {
    try {
      final response = await _dio.post(
        ApiConstants.verify_Otp,
        data: {
          "email": email,
          "otp": otp,
        },
      );

      final baseResponse = BaseResponseDto.fromJson(response.data);

      // Kiểm tra nếu statusCode của response là 201 (success có data)
      if (baseResponse.statusCode == StatusCode.success) {
        return Result.success(baseResponse.message ?? "OTP verified");
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
        ApiConstants.resend_Otp,
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
}
