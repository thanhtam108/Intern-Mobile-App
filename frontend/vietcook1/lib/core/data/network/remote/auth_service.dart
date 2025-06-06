import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
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
      final res = await _dio.post('/auth/verify-otp', data: {
        "email": email,
        "otp": otp,
      });

      if (res.statusCode == 201 && res.data['access_token'] != null) {
        return Result.success(res.data['access_token']);
      } else {
        return Result.error(AppException(
          statusCode: res.statusCode,
          message: res.data['message'] ?? "OTP không hợp lệ",
          errorCode: "OTP_INVALID",
        ));
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    } catch (e) {
      return Result.error(AppException(
        statusCode: null,
        message: "Đã xảy ra lỗi không mong muốn: ${e.toString()}",
        errorCode: "UNEXPECTED_ERROR",
      ));
    }
  }

  Future<Result<void>> resendOtp(String email) async {
    try {
      final res = await _dio.post('/auth/resend-otp', data: {"email": email});
      if (res.statusCode == 201) {
        return Result.success(null);
      } else {
        return Result.error(AppException(
          statusCode: res.statusCode,
          message: res.data['message'] ?? "Gửi lại OTP thất bại",
          errorCode: "RESEND_OTP_FAILED",
        ));
      }
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    } catch (e) {
      return Result.error(AppException(
        statusCode: null,
        message: "Đã xảy ra lỗi không mong muốn: ${e.toString()}",
        errorCode: "UNEXPECTED_ERROR",
      ));
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }
}
