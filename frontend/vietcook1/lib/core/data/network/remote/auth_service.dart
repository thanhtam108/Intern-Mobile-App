import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'dio_client.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Result<List<FoodModel>>> register(
      String name, String email, String password) async {
    try {
      final res = await _dio.post(ApiConstants.register, data: {
        "name": name,
        "email": email,
        "password": password,
      });

      //Json to model

      return Result.success("hhhhh");
    } on DioError catch (e) {
      return Result.error(AppException.parse(e));
    }
  }

  Future<String> verifyOtp(String email, String otp) async {
    final res = await _dio.post('/auth/verify-otp', data: {
      "email": email,
      "otp": otp,
    });

    print(res.data['access_token']);

    if (res.statusCode == 201 && res.data['access_token'] != null) {
      return res.data['access_token'];
    } else {
      throw Exception(res.data['message'] ?? "OTP không hợp lệ");
    }
  }

  Future<void> resendOtp(String email) async {
    final res = await _dio.post('/auth/resend-otp', data: {"email": email});
    if (res.statusCode != 201) throw Exception("Gửi lại OTP thất bại");
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }
}
