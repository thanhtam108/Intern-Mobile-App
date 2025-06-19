class ApiConstants {
  static const baseUrl = "http://10.0.2.2:3000/";

  static var auth = _AuthApi();
  static var categories = _CategoriesApi();
  static var recipes = _RecipesApi();
  static var favorites = _FavoritesApi();
}

class _AuthApi {
  final String register = "/auth/register";
  final String verifyOtp = "/auth/verify-otp";
  final String resendOtp = "/auth/resend-otp";
  final String login = "/auth/login";
  final String getUser = "/user/me";
  final String updateUser = "/auth/user/update";
  final String changePassword = "/auth/user/change-password";
}

class _CategoriesApi {
  final String getAll = "/categories/get-all";
  final String getById = "/categories/";
}

class _RecipesApi {
  final String getAll = "/recipes/all";
  final String common = "/recipes/";
  final String getByUserId = "/recipes/user/";
  final String getByCategoryId = "/recipes/category/id/";
  final String getByCateName = "/recipes/category/name/";
  final String create = "/recipes/insert";
  final String update = "/recipes/update";
  final String delete = "/recipes/delete";
  final String getRecent = "/recipes/most-recent";
  final String getTopRated = "/recipes/most-rated";
}

class _FavoritesApi {
  final String common = "/favorites/";
  final String add = "/favorites/add";
  final String remove = "/favorites/remove";
}
