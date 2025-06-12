import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/recipe_controller.dart';
import 'package:vietcook1/core/ui/horizontal_recipe_card.dart';
import 'package:vietcook1/core/ui/vertical_recipe_card.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    super.initState();
    // Gọi sau khi widget được khởi tạo
    Future.microtask(() {
      Provider.of<RecipeController>(context, listen: false).loadRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RecipeController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.recipes.length,
              itemBuilder: (context, index) {
                final recipe = controller.recipes[index];
                return index % 2 == 0
                    ? RecipeCardVertical(
                        imageUrl: recipe.,
                        title: recipe.name,
                        subtitle: recipe.description,
                        rating: recipe.rating,
                        views: recipe.views,
                        userName: recipe.userName,
                        userAvatar: recipe.userAvatar,
                        timeCreated: recipe.timeAgo,
                        isFavorite: recipe.isFavorite,
                      )
                    : RecipeCardHorizontal(
                        imageUrl: recipe.imageUrl,
                        title: recipe.name,
                        subtitle: recipe.description,
                        rating: recipe.rating,
                        views: recipe.views,
                        userName: recipe.userName,
                        userAvatar: recipe.userAvatar,
                        isFavorite: recipe.isFavorite,
                      );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.loadRecipes,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
