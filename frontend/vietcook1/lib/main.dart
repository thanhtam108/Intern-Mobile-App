import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/core/data/network/remote/dio_client.dart';
import 'core/bindings/core_binding.dart';
import 'core/routing/app_routes.dart';
import 'core/data/network/remote/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = await DioClient().create();
  Get.put<Dio>(dio); // Inject Dio
  Get.put<AuthService>(AuthService(dio));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VietCook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: CoreBinding(), // Binding để inject dependencies
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial, // Route ban đầu
      getPages: AppRoutes.routes, // Danh sách các route
    );
  }
}
