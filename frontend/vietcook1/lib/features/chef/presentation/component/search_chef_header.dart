import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vietcook1/features/chef/presentation/controller/chef_controller.dart';
import 'package:vietcook1/features/search/presentation/components/custom_search_bar.dart';

class ChefSearchHeader extends GetView<ChefController> {
  final FocusNode? focusNode;
  const ChefSearchHeader({this.focusNode, super.key});

  @override
  Widget build(BuildContext context) {
    // Đặt icon status bar màu đen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Stack(
      children: [
        // Nền olive phủ hết phía trên
        Container(
          height: 140,
          color: const Color(0xFF7F9164),
        ),

        // Nội dung search bar căn giữa
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.only(left: 8, right: 4),
                      child: CustomSearchBar(
                        hintText: 'Tìm kiếm đầu bếp',
                        initialValue: controller.searchQuery.value,
                        onSearch: (value) {
                          controller.searchQuery.value = value;
                          controller.searchChefs(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
