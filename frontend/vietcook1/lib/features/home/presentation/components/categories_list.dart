import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/data/local/models/category_model.dart';
import 'package:vietcook1/features/home/presentation/controller/home_controller.dart';
// import 'package:vietcook1/core/data/local/models/category_model.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Column(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green.shade100,
                  child:
                      // Use Image.network to display image from URL
                      category.imageUrl != null
                          ? Image.network(
                              category.imageUrl,
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.category,
                              color: AppColors.primary,
                              size: 32,
                            ),
                ),
                const SizedBox(height: 4),
                Text(
                  category.name,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
