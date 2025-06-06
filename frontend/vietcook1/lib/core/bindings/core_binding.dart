import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(Dio());
    Get.put<AuthService>(AuthService());
  }
}