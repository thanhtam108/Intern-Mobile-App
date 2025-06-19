import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/features/main/presentation/controller/main_controller.dart';

class MainPage extends GetView<MainController> {
  MainPage({super.key});

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Search Page')),
    Center(child: Text('Favorite Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Navigator(
            key: Get.nestedKey(1),
            initialRoute: "/home",
            onGenerateRoute: controller.onGenerateRoute,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildBottomItem(
                    icon: Icons.home,
                    label: 'Trang chủ',
                    index: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildBottomItem(
                    icon: Icons.search,
                    label: 'Tìm kiếm',
                    index: 1,
                  ),
                ),
                const Spacer(), // dành chỗ cho FAB
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: _buildBottomItem(
                    icon: Icons.favorite,
                    label: 'Yêu thích',
                    index: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildBottomItem(
                    icon: Icons.person,
                    label: 'Cá nhân',
                    index: 3,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            width: 80,
            height: 80,
            child: FloatingActionButton(
              onPressed: () {
                print('Thêm món ăn mới');
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
              shape: const CircleBorder(),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }

  Widget _buildBottomItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.onChangeItemBottomBar(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
