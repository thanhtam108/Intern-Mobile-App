import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/features/search/presentation/controller/search_controller.dart';
import 'package:vietcook1/features/search/presentation/page/search_result_page.dart';

class RecentSearches extends GetView<CustomSearchController> {
  const RecentSearches({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<my_controller.SearchController>();

    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tìm kiếm gần đây",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 12,
                children: controller.recentSearches
                    .map(
                      (keyword) => GestureDetector(
                        onTap: () {
                          controller.search(keyword);
                          Get.toNamed(Routes.searchResult, arguments: keyword);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3 - 28,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9EFEB),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            keyword.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF475D3A),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
