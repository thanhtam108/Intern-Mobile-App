import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.240:3000',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );

  Dio get dio => _dio;
}
