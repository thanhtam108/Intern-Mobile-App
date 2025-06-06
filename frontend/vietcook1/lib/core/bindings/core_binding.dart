import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() async => await DioClient().create(), permanent: true);
  }
}
