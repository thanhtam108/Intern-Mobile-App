import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../components/home_header.dart';
import '../components/categories_list.dart';
import '../components/top_rated_recipes.dart';
import '../components/recent_recipes.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // Status bar overlay đè lên
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    final statusBarHeight = MediaQuery.of(context).padding.top;

    controller.onInit();
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return GetBuilder<HomeController>(
          id: 'updateHome',
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ StatusBar padding + header
                Padding(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  child: HomeHeader(
                    userName: controller.user.name ?? 'Người dùng',
                    avatarUrl: controller.user.avatarUrl ??
                        'lib/assets/icons/avatar_placeholder.jpg',
                  ),
                ),

                // ✅ Danh mục - cố định không scroll
                CategoryList(categories: controller.categories),

                const SizedBox(height: 8),

                // ✅ Nội dung có thể cuộn
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        TopRatedRecipes(recipes: controller.topRatedRecipes),
                        const SizedBox(height: 16),
                        RecentRecipes(recipes: controller.recentRecipes),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
