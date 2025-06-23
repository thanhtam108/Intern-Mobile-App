import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String)? onSearch;
  final Function(String)? onSubmitted;
  final TextEditingController? textController;
  final String? initialValue;
  final VoidCallback? onTap;
  final bool? enabled;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Nhập tên món ăn, thành phần...',
    this.onSearch,
    this.onSubmitted,
    this.textController,
    this.initialValue,
    this.onTap,
    this.enabled,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ??
        TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    if (widget.textController == null) {
      _controller.dispose(); // Chỉ dispose nếu là nội bộ
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled ?? true,
      controller: _controller,
      onChanged: widget.onSearch,
      onSubmitted: widget.onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
      ),
    );
  }
}
