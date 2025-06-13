import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'navigator_controller.dart';
import 'package:vietcook1/features/home/presentation/page/home_page.dart';

class MainNavigator extends StatelessWidget {
  final NavigatorController _controller = Get.put(NavigatorController());

  final List<Widget> _pages = [
    HomePage(), // Trang chủ
    // SearchScreen(), // Tìm kiếm
    // FavoritesScreen(), // Món yêu thích
    // ProfileScreen(), // Cá nhân
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          _pages[_controller.currentIndex.value]), // Hiển thị trang tương ứng
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _controller.currentIndex.value,
          onTap: (index) =>
              _controller.changeTab(index), // Cập nhật tab hiện tại
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary, // Màu khi được chọn
          unselectedItemColor:
              AppColors.textSecondary, // Màu khi không được chọn
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Tìm kiếm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Món yêu thích',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Cá nhân',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý khi nhấn nút thêm
          print('Thêm món ăn mới');
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
