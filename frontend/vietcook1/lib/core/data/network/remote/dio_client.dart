import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/network/check_network.dart';
import 'package:vietcook1/core/data/network/interceptor/intercreptor.dart';

class DioClient {
  Future<Dio> create() async {
    final dio = Dio();
    // Initialize the dependencies
    final networkInfo = NetworkInfoImpl(
      InternetConnectionChecker.createInstance(),
    );
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);
    dio.interceptors.add(AuthInterceptor(networkInfo));
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return dio;
  }
}
