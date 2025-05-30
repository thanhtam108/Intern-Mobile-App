import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/recipe_controller.dart';

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
                return ListTile(
                  title: Text(recipe.name ?? 'No name'),
                  subtitle: Text(recipe.description ?? 'No description'),
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
