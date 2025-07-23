import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import '../presentation/controller/search_controller.dart';

class CustomSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut(() => RecipeService(Get.find<Dio>()));
    Get.lazyPut(() => CustomSearchController());
    Get.put<CustomSearchController>(CustomSearchController(), permanent: true);
  }
}
