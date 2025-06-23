import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/favorite_service.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/features/recipe/favorite/presentation/controller/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut(() => RecipeService(Get.find<Dio>()));
    Get.lazyPut(() => FavoriteService(Get.find<Dio>()));
    Get.lazyPut(() => FavoriteRecipesController(
        Get.find<FavoriteService>(), Get.find<RecipeService>()));
  }
}
