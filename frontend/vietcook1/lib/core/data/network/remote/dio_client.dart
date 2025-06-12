import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/network/check_network.dart';
import 'package:vietcook1/core/data/network/interceptor/intercreptor.dart';

class DioClient {
  Future<Dio> create() async {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      validateStatus: (_) => true,
    ));

    final checker = await InternetConnectionChecker.createInstance();
    final networkInfo = NetworkInfoImpl(checker);
    dio.interceptors.add(AuthInterceptor(networkInfo));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
