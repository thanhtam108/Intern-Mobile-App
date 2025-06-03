import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './features/recipe/fetch_all/presentation/page/recipe_page.dart';
import 'features/recipe/fetch_all/presentation/controller/recipe_controller.dart';
import 'core/routing/app_routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.routes, // hoặc AppRoutes.verifyOtp
      getPages: AppRoutes.routes,
    );
  }
}
