import 'package:get/get.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/features/main/di/main_binding.dart';
import 'package:vietcook1/features/main/presentation/page/main_page.dart';
import 'package:vietcook1/features/onboarding/presentation/page/onboarding_page.dart';
import 'package:vietcook1/features/auth/login/presentation/page/login_page.dart';
import 'package:vietcook1/features/home/di/home_binding.dart';
import 'package:vietcook1/features/home/presentation/page/home_page.dart';
import 'package:vietcook1/features/splash/di/splash_binding.dart';
import 'package:vietcook1/features/splash/presentation/page/splash_page.dart';
import '../../features/auth/login/di/login_binding.dart';
import '../../features/auth/otp-verify/di/otp_binding.dart';
import '../../features/auth/otp-verify/presentation/page/otp_page.dart';
import '../../features/auth/register/di/register_binding.dart';
import '../../features/auth/register/presentation/page/register_page.dart';

class AppRoutes {
  static const String initial = Routes.initial;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.initial,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainPage(),
      binding: MainBinding(),
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
      name: Routes.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    // GetPage(
    //   name: Routes.recipes,
    //   // page: () => RecipePage(),
    // ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
