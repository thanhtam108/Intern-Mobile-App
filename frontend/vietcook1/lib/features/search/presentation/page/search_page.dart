import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/search_controller.dart';
import '../components/search_header.dart';
import '../components/recent_searches.dart';
import '../components/search_results_list.dart';

class SearchPage extends GetView<CustomSearchController> {
  // final my.SearchController controller = Get.put(my.SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            SearchHeader(
              onSearch: (keyword) {
                controller.searchRecipes(); // Gọi tìm kiếm khi gõ
              },
              onSubmitted: (keyword) {
                controller.searchRecipes(); // Gọi tìm kiếm khi nhấn Enter
              },
            ),
            const RecentSearches(),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (!controller.hasSearched.value) {
                  return const SizedBox();
                }

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SearchResultsList(recipes: controller.recipes);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
