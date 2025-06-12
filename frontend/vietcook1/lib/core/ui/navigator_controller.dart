import 'package:get/get.dart';

class NavigatorController extends GetxController {
  var currentIndex = 0.obs; // Quản lý trạng thái của tab hiện tại

  void changeTab(int index) {
    currentIndex.value = index; // Cập nhật tab hiện tại
  }
}
