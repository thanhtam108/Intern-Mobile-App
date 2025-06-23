import 'package:get/get.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/features/category/di/category_binding.dart';
import 'package:vietcook1/features/category/presentation/page/category_recipes_page.dart';
import 'package:vietcook1/features/chef/di/chef_binding.dart';
import 'package:vietcook1/features/chef/page/chef_page.dart';
import 'package:vietcook1/features/edit_profile/di/edit_profile_binding.dart';
import 'package:vietcook1/features/edit_profile/presentation/page/edit_personal_info.dart';
import 'package:vietcook1/features/insert/di/insert_binding.dart';
import 'package:vietcook1/features/insert/presentation/page/insert_form.dart';
import 'package:vietcook1/features/main/di/main_binding.dart';
import 'package:vietcook1/features/main/presentation/page/main_page.dart';
import 'package:vietcook1/features/onboarding/presentation/page/onboarding_page.dart';
import 'package:vietcook1/features/auth/login/presentation/page/login_page.dart';
import 'package:vietcook1/features/home/di/home_binding.dart';
import 'package:vietcook1/features/home/presentation/page/home_page.dart';
import 'package:vietcook1/features/profile/di/profile_binding.dart';
import 'package:vietcook1/features/profile/presentation/page/profile_page.dart';
import 'package:vietcook1/features/recipe/favorite/di/favorite_binding.dart';
import 'package:vietcook1/features/recipe/favorite/presentation/page/favorite_recipes_page.dart';
import 'package:vietcook1/features/recipe/recipe_detail/di/recipe_detail_binding.dart';
import 'package:vietcook1/features/recipe/recipe_detail/presentation/page/recipe_detail_page.dart';
import 'package:vietcook1/features/search/di/search_binding.dart';
import 'package:vietcook1/features/search/presentation/page/search_page.dart';
import 'package:vietcook1/features/search/presentation/page/search_result_page.dart';
import 'package:vietcook1/features/splash/di/splash_binding.dart';
import 'package:vietcook1/features/splash/presentation/page/splash_page.dart';
import '../../features/auth/login/di/login_binding.dart';
import '../../features/auth/otp-verify/di/otp_binding.dart';
import '../../features/auth/otp-verify/presentation/page/otp_page.dart';
import '../../features/auth/register/di/register_binding.dart';
import '../../features/auth/register/presentation/page/register_page.dart';
import '../../features/onboarding/di/onboarding_binding.dart';

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
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainPage(),
      binding: MainBinding(),
      // Use nested navigation for main tabs
      children: [
        GetPage(
          name: Routes.home,
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
      ],
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
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.insert,
      page: () => InsertRecipePage(),
      binding: InsertBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => SearchPage(),
      binding: CustomSearchBinding(),
    ),
    GetPage(
      name: Routes.editPersonalInfo,
      page: () => EditPersonalInfo(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.recipe_detail,
      page: () {
        final recipeId =
            Get.parameters['recipeId'] ?? Get.arguments?['recipeId'];
        return RecipeDetailPage(recipeId: recipeId ?? '');
      },
      binding: RecipeDetailBinding(),
    ),
    GetPage(
      name: Routes.searchResult,
      page: () => SearchResultPage(searchKeyword: ''),
      binding: CustomSearchBinding(),
    ),
    GetPage(
      name: Routes.favorites,
      page: () => FavoriteRecipesPage(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.category,
      page: () {
        final categoryId = Get.arguments['categoryId'];
        return CategoryRecipesPage(categoryId: categoryId);
      },
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.chef,
      page: () => const ChefPage(),
      binding: ChefBinding(),
    ),
  ];
}
