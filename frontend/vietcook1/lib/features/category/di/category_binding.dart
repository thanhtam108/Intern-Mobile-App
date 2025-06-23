import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/category_service.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/favorite_service.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/features/category/presentation/controller/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut(() => RecipeService(Get.find<Dio>()));
    Get.lazyPut(() => CategoryService(Get.find<Dio>()));
    Get.lazyPut(() => CategoryController(
        Get.find<RecipeService>(), Get.find<CategoryService>()));
  }
}
