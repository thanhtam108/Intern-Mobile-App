import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/home_header.dart';
import '../components/categories_list.dart';
import '../components/top_rated_recipes.dart';
import '../components/recent_recipes.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 34),
              HomeHeader(
                userName: controller.userdata.name ?? 'Người dùng',
                avatarUrl: controller.userdata.avatarUrl ??
                    'lib/assets/icons/avatar_placeholder.jpg',
              ),
              CategoryList(categories: [
                {'name': 'Ăn sáng', 'icon': Icons.breakfast_dining},
                {'name': 'Ăn trưa', 'icon': Icons.lunch_dining},
                {'name': 'Nước uống', 'icon': Icons.local_drink},
                {'name': 'Xào', 'icon': Icons.restaurant},
                {'name': 'Bánh', 'icon': Icons.cake},
                {'name': 'Cơm phần', 'icon': Icons.rice_bowl},
                {'name': 'Đồ chay', 'icon': Icons.eco},
                {'name': 'Canh', 'icon': Icons.soup_kitchen},
              ]),
              const SizedBox(height: 16),
              TopRatedRecipes(recipes: controller.topRatedRecipes.toList())
            ],
          ),
        );
      }),
    );
  }
}
