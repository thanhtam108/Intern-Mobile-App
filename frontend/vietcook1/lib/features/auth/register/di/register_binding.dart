import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';

import '../presentation/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService(Get.find()));
    Get.lazyPut(() => RegisterController(Get.find<AuthService>()), fenix: true);
  }
}
