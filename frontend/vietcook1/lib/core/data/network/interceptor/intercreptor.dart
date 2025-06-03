import 'package:dio/dio.dart';
import 'package:vietcook1/core/data/network/check_network.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final NetworkInfo _networkInfo;
  AuthInterceptor(this._networkInfo);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _networkInfo.isConnected) {
      handler.next(options);
    } else {
      return handler.reject(
        DioError(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 400,
            statusMessage: "Không có Internet.",
          ),
          error: "",
        ),
      );
    }
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}
