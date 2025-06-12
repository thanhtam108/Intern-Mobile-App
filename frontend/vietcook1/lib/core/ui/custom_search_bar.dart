import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String)? onSearch;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Nhập tên món ăn, thành phần...',
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch, // Xử lý khi người dùng nhập
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
