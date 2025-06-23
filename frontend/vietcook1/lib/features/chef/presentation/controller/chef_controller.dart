import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/chef_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';

class ChefController extends GetxController {
  final UserService _userService;

  ChefController(this._userService);

  final RxList<ChefModel> topChefs = <ChefModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxList<ChefModel> searchResults = <ChefModel>[].obs;
  final RxBool isSearching = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopChefs();
  }

  Future<void> fetchTopChefs() async {
    isLoading.value = true;

    final result = await _userService.getTopChefs();

    if (result.status == Status.success && result.data != null) {
      topChefs.assignAll(result.data!);
    } else {
      Get.snackbar('Lỗi', 'Không thể tải danh sách đầu bếp');
    }

    isLoading.value = false;
  }

  Future<void> searchChefs(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    isSearching.value = true;
    final result = await _userService.searchChefs(query);

    result.when(
      onSuccess: (data) {
        searchResults.value = data;
      },
      onError: (e) {
        searchResults.clear();
        // Get.snackbar('Lỗi khi tìm đầu bếp', e.message);
      },
    );

    isSearching.value = false;
  }
}
