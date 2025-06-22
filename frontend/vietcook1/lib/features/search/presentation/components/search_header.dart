import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/features/search/presentation/components/custom_search_bar.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';

class SearchHeader extends GetView<CustomSearchController> {
  final FocusNode? focusNode;
  const SearchHeader({this.focusNode, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomSearchBar(
        focusNode: focusNode,
        onSearch: controller.onSearchChanged,
        onSubmitted: (_) => controller.searchRecipes(),
      ),
    );
  }
}
