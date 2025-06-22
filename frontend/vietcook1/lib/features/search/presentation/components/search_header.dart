import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/features/search/presentation/components/custom_search_bar.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';
import 'package:vietcook1/features/search/presentation/page/search_result_page.dart';

class SearchHeader extends GetView<CustomSearchController> {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomSearchBar(
        initialValue: controller.searchQuery.value,
        onSearch: (value) {
          controller.searchQuery.value = value;
        },
        onSubmitted: (value) {
          if (value.trim().isNotEmpty) {
            controller.search(value);
            Get.to(() => SearchResultPage(searchKeyword: value));
          }
        },
        // onSubmitted: (value) {
        //   if (value.trim().isNotEmpty) {
        //     Get.to(() => SearchResultPage(searchKeyword: value));
        //   }
        // },
      ),
    );
  }
}
