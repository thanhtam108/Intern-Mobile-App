import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import '../controller/search_controller.dart';
import '../components/search_header.dart';
import '../components/recent_searches.dart';

class SearchPage extends GetView<CustomSearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // searchFocusNode.requestFocus();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchHeader(),
              const SizedBox(height: 24),
              const Text(
                'Tìm kiếm gần đây',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const RecentSearches(),
              const SizedBox(height: 24),
              const Text(
                'Gợi ý liên quan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                  shrinkWrap: true, // hoặc dùng Expanded như đang làm
                  children: const [
                    _DishCard(
                        title: 'Canh khổ qua',
                        imageUrl:
                            'https://res.cloudinary.com/dcx4uowma/image/upload/v1750583442/40aafb68-68c3-400d-9947-7853fda03a87.png'),
                    _DishCard(
                        title: 'Tàu hũ sốt cà chua',
                        imageUrl:
                            'https://res.cloudinary.com/dcx4uowma/image/upload/v1750583442/40aafb68-68c3-400d-9947-7853fda03a87.png'),
                    _DishCard(
                        title: 'Canh chua cá',
                        imageUrl:
                            'https://res.cloudinary.com/dcx4uowma/image/upload/v1750583442/40aafb68-68c3-400d-9947-7853fda03a87.png'),
                    _DishCard(
                        title: 'Ba rọi kho',
                        imageUrl:
                            'https://res.cloudinary.com/dcx4uowma/image/upload/v1750583442/40aafb68-68c3-400d-9947-7853fda03a87.png'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DishCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  const _DishCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(imageUrl, height: 100, fit: BoxFit.cover),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
