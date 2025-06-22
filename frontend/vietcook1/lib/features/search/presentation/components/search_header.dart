import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/features/search/presentation/components/custom_search_bar.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';
import 'package:vietcook1/features/search/presentation/page/search_result_page.dart';

class SearchHeader extends GetView<CustomSearchController> {
  final FocusNode? focusNode;
  const SearchHeader({this.focusNode, super.key});

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
            final trimmed = value.trim();
            if (trimmed.isNotEmpty) {
              if (Get.currentRoute == Routes.searchResult) {
                controller.search(trimmed); // cập nhật lại kết quả
              } else {
                Get.toNamed(Routes.searchResult, arguments: trimmed);
              }
            }
          }

          // onSubmitted: (value) {
          //   if (value.trim().isNotEmpty) {
          //     Get.to(() => SearchResultPage(searchKeyword: value));
          //   }
          // },
          ),
    );
  }
}
