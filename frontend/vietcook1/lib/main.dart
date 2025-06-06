import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routing/app_routes.dart';
import 'core/bindings/core_binding.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      initialBinding: CoreBinding(),
    ),
  );
}
