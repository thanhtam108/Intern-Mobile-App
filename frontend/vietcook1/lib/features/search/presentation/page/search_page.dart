import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  children: const [
                    _DishCard(
                        title: 'Canh khổ qua',
                        imageUrl: 'https://via.placeholder.com/150'),
                    _DishCard(
                        title: 'Tàu hũ sốt cà chua',
                        imageUrl: 'https://via.placeholder.com/150'),
                    _DishCard(
                        title: 'Canh chua cá',
                        imageUrl: 'https://via.placeholder.com/150'),
                    _DishCard(
                        title: 'Ba rọi kho',
                        imageUrl: 'https://via.placeholder.com/150'),
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
