import 'package:dio/dio.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/network/check_network.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/auth/login/models/token_model.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final NetworkInfo _networkInfo;
  AuthInterceptor(this._networkInfo);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await _networkInfo.isConnected) {
      Map<String, dynamic>? token =
          await SharedPrefsUtils.getObject(SharePrefsConstants.token);
      if (token != null) {
        TokenModel tokenModel = TokenModel.fromJson(token);
        options.headers['Authorization'] = "Bearer ${tokenModel.accessToken}";
      }
      handler.next(options);
    } else {
      return handler.reject(
        DioException(
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
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("DioError: ${err.message}");
    return handler.next(err);
  }
}
