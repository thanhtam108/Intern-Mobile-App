import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';

import '../presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService(Get.find()));
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
