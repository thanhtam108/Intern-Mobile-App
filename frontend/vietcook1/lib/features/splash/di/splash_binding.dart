import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/features/splash/presentation/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());

    Get.lazyPut(() => SplashController());
  }
}
