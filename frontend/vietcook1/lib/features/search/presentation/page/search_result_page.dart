import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/search_controller.dart';
import '../components/search_header.dart';
import '../components/search_results_list.dart';

class SearchResultPage extends GetView<CustomSearchController> {
  // const SearchResultPage({super.key});
  final String searchKeyword;
  const SearchResultPage({super.key, required this.searchKeyword});
  @override
  Widget build(BuildContext context) {
    final String searchKeyword = Get.arguments ?? '';

    // Gọi tìm kiếm sau khi trang được build lần đầu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (searchKeyword.isNotEmpty) {
        controller.search(searchKeyword);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                  Expanded(
                    child: SearchHeader(
                        // initialValue: searchKeyword,
                        // onSubmitted: (value) {
                        //   if (value.trim().isNotEmpty) {
                        //     Get.to(() => SearchResultPage(searchKeyword: value));
                        //   }
                        // },
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_alt_outlined),
                    onPressed: () {
                      // TODO: show filter
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Kết quả tìm kiếm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.searchResults.isEmpty) {
                    return const Center(
                        child: Text('Không có kết quả nào phù hợp'));
                  }

                  return SearchResultsList(controller.searchResults);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
