import 'package:flutter/material.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/ui/custom_search_bar.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chào, $userName 👋',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomSearchBar(
            hintText: 'Tìm kiếm món ăn, thành phần...',
            onSearch: (query) {
              print('Tìm kiếm: $query'); // Xử lý logic tìm kiếm
            },
          ),
        ],
      ),
    );
  }
}
