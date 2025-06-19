import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/category_service.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'package:vietcook1/core/data/network/remote/recipe_service.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import '../../insert/presentation/controller/insert_controller.dart';

class InsertBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Dio>(() => DioClient().create());
    Get.lazyPut<UserService>(() => UserService(Get.find<Dio>()));
    Get.lazyPut<RecipeService>(() => RecipeService(Get.find<Dio>()));
    Get.lazyPut<CategoryService>(() => CategoryService(Get.find<Dio>()));

    Get.lazyPut<InsertRecipeController>(
      () => InsertRecipeController(
        Get.find<RecipeService>(),
        Get.find<CategoryService>(),
        Get.find<UserService>(),
      ),
    );
  }
}
