import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../../../core/data/network/remote/auth_service.dart';
import '../presentation/controller/login_controller.dart';
import '../../../../../core/data/network/remote/dio_client.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut<AuthService>(() => AuthService(Get.find<Dio>()));
    Get.lazyPut(() => LoginController(Get.find<AuthService>()));
  }
}
