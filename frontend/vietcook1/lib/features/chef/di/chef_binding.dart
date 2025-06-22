import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/features/chef/presentation/controller/chef_controller.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';

class ChefBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService(Get.find()));
    Get.lazyPut<ChefController>(() => ChefController(Get.find()));
    Get.lazyPut(() => CustomSearchController());
  }
}
