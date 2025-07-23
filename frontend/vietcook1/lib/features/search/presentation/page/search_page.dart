import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/features/home/presentation/components/top_rated_recipes.dart';
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
              const SizedBox(height: 8),
              const RecentSearches(),
              const SizedBox(height: 8),
              // Bọc phần có thể tràn bằng Expanded + SingleChildScrollView
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: GetBuilder<CustomSearchController>(
                    id: 'search_top_rated',
                    builder: (controller) {
                      if (controller.topRatedRecipes.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return TopRatedRecipes(
                        recipes: controller.topRatedRecipes.toList(),
                      );
                    },
                  ),
                ),
              ),
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
