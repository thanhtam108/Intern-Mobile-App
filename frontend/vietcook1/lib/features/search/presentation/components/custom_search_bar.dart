import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';

class CustomSearchBar extends GetView<CustomSearchController> {
  final String hintText;
  final Function(String)? onSearch;
  final Function(String)? onSubmitted;
  final TextEditingController? textController;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Nhập tên món ăn, thành phần...',
    this.onSearch,
    this.onSubmitted,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: controller.onSearchChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
      ),
    );
  }
}
