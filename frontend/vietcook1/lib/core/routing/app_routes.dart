import 'package:get/get.dart';
import 'package:vietcook1/features/auth/register/presentation/page/onboarding_page.dart';

import '../../features/auth/otp-verify/di/otp_binding.dart';
import '../../features/auth/otp-verify/presentation/page/otp_page.dart';
import '../../features/auth/register/di/register_binding.dart';
import '../../features/auth/register/presentation/page/register_page.dart';
import '../../features/recipe/fetch_all/presentation/page/recipe_page.dart';
import 'routes.dart';

class AppRoutes {
  static const String initial = Routes.initial;
  static final List<GetPage> routes = [
    GetPage(
      name: Routes.initial,
      page: () => OnboardingScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.verifyOtp,
      page: () => OtpPage(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.recipes,
      page: () => RecipePage(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
