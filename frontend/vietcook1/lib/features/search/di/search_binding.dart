import 'package:get/get.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomSearchController());
  }
}
