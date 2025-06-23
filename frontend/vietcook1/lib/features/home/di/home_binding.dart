import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/auth_service.dart';
import 'package:vietcook1/core/data/network/remote/category_service.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/features/chef/presentation/controller/chef_controller.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';
import '../presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut(() => AuthService(Get.find<Dio>()));
    Get.lazyPut(() => RecipeService(Get.find<Dio>()));
    Get.lazyPut(() => UserService(Get.find<Dio>()));
    Get.lazyPut(() => CategoryService(Get.find<Dio>()));
    Get.lazyPut(() => HomeController(Get.find<RecipeService>(),
        Get.find<UserService>(), Get.find<CategoryService>()));
    Get.lazyPut(() => CustomSearchController());
    Get.lazyPut(() => ChefController(Get.find<UserService>()));
  }
}
