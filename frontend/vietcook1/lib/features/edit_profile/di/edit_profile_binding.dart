import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/features/edit_profile/presentation/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut(() => AuthService(Get.find<Dio>()));
    Get.lazyPut(() => UserService(Get.find<Dio>()));
    Get.lazyPut<EditProfileController>(
        () => EditProfileController(Get.find<UserService>()));
  }
}
