import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/home_header.dart';
import '../components/categories_list.dart';
import '../components/top_rated_recipes.dart';
import '../components/recent_recipes.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return GetBuilder<HomeController>(
            id: 'updateHome',
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 34),
                    HomeHeader(
                      userName: controller.user.name ?? 'Người dùng',
                      avatarUrl: controller.user.avatarUrl ??
                          'lib/assets/icons/avatar_placeholder.jpg',
                    ),
                    CategoryList(
                      categories: controller.categories.toList(),
                    ),
                    const SizedBox(height: 16),
                    TopRatedRecipes(recipes: controller.topRatedRecipes),
                    RecentRecipes(
                      recipes: controller.recentRecipes,
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
