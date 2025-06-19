import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/features/main/presentation/controller/main_controller.dart';
import 'package:vietcook1/features/splash/presentation/controller/splash_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut<UserService>(() => UserService(Get.find<Dio>()));
    Get.lazyPut(() => MainController(Get.find<UserService>()));
  }
}
