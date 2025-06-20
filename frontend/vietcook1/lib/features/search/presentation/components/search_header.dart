import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/ui/custom_search_bar.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart'
    as my;

class SearchHeader extends StatelessWidget {
  final void Function(String)? onSearch;
  final void Function(String)? onSubmitted;

  const SearchHeader({
    super.key,
    this.onSearch,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomSearchBar(
        hintText: 'Tìm kiếm món ăn',
        onSearch: onSearch,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
