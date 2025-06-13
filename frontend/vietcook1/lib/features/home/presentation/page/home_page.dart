import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/home_header.dart';
import '../components/categories_list.dart';
import '../components/favorite_recipes.dart';
import '../components/recent_recipes.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit(); // Initialize the controller
    final categories = [
      {'name': 'Ăn sáng', 'icon': Icons.breakfast_dining},
      {'name': 'Ăn trưa', 'icon': Icons.lunch_dining},
      {'name': 'Nước uống', 'icon': Icons.local_drink},
      {'name': 'Xào', 'icon': Icons.restaurant},
      {'name': 'Bánh', 'icon': Icons.cake},
      {'name': 'Cơm phần', 'icon': Icons.rice_bowl},
      {'name': 'Đồ chay', 'icon': Icons.eco},
      {'name': 'Canh', 'icon': Icons.soup_kitchen},
    ];

    final favoriteRecipes = controller.favoriteRecipes();

    // final recentRecipes = [
    //   // Danh sách món gần đây
    // ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
                userName: 'Tên',
                avatarUrl: 'lib/assets/icons/avatar_placeholder.jpg'),
            CategoryList(categories: categories),
            FavoriteRecipes(recipes: favoriteRecipes),
            GetBuilder<HomeController>(
              id: 'updateUser',
              builder: (controller) {
                return Text(
                  'Xin chào, ${controller.userdata?.name ?? 'Người dùng'}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
              },
            ),

            GetBuilder<HomeController>(
              id: 'favoriteRecipes',
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = controller.favoriteRecipes[index];
                    return ListTile(
                      title: Text(recipe.name),
                      subtitle: Text(recipe.description),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(recipe.imageUrl),
                      ),
                      onTap: () {
                        // Handle recipe tap
                      },
                    );
                  },
                );
              },
            ),
            // RecentRecipes(recipes: recentRecipes),
          ],
        ),
      ),
    );
  }
}
