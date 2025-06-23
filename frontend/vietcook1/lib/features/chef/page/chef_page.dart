import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/ui/chef_card.dart';
import 'package:vietcook1/features/chef/presentation/component/search_chef_header.dart';
import 'package:vietcook1/features/chef/presentation/controller/chef_controller.dart';
import 'package:vietcook1/features/search/presentation/components/custom_search_bar.dart';

class ChefPage extends GetView<ChefController> {
  const ChefPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTopChefs();
    });

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChefSearchHeader(), // đã có SafeArea và nền full trong đây rồi
          const SizedBox(height: 8),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Đầu bếp hàng đầu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: Obx(() {
              final isSearching = controller.isSearching.value;
              final searchResults = controller.searchResults;
              final topChefs = controller.topChefs;
              final searchQuery = controller.searchQuery.value.trim();

              if (isSearching) {
                return const Center(child: CircularProgressIndicator());
              }

              if (searchQuery.isNotEmpty) {
                if (searchResults.isEmpty) {
                  return const Center(
                    child: Text('Không có kết quả tìm kiếm.'),
                  );
                } else {
                  return _buildChefGrid(searchResults);
                }
              }

              if (topChefs.isEmpty) {
                return const Center(
                  child: Text('Không có đầu bếp nào.'),
                );
              }

              return _buildChefGrid(topChefs);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildChefGrid(List<dynamic> chefs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 4, // Tùy theo thiết kế ChefCard
        children: chefs.map<Widget>((chef) {
          return ChefCard(
            avatarUrl: chef.avatarUrl,
            name: chef.name,
            bio: chef.bio,
            recipeCount: chef.recipeCount,
          );
        }).toList(),
      ),
    );
  }
}
