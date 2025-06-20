import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import '../presentation/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut(() => AuthService(Get.find<Dio>()));
    Get.lazyPut(() => RecipeService(Get.find<Dio>()));
    Get.lazyPut(() => UserService(Get.find<Dio>()));
    Get.lazyPut(() =>
        ProfileController(Get.find<RecipeService>(), Get.find<UserService>()));
  }
}
