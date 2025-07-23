import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/features/search/model/search_result_model.dart';

class SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;
  const SearchResultsList(this.results);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 200,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        final item = results[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.recipe_detail,
                arguments: {'recipeId': results[index].id});
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(item.imageUrl,
                    height: 120, fit: BoxFit.cover),
              ),
              SizedBox(height: 6),
              Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}
