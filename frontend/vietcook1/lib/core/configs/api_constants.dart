class ApiConstants {
  static const baseUrl = "http://192.168.6.108:3000";

  static var auth = _AuthApi();
  static var categories = _CategoriesApi();
  static var recipes = _RecipesApi();
  static var favorites = _FavoritesApi();
  static var user = _UserApi();
  static var reviews = _Reviews();
}

class _AuthApi {
  final String register = "/auth/register";
  final String verifyOtp = "/auth/verify-otp";
  final String resendOtp = "/auth/resend-otp";
  final String login = "/auth/login";
  final String getUser = "/user/me";
}

class _UserApi {
  final String update = "/user/";
  final String getById = "/user/";
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
  final String getsearch = "/recipes/search";
}

class _FavoritesApi {
  final String common = "/favorites";
  final String add = "/favorites/add";
  final String remove = "/favorites/remove";
}

class _Reviews {
  final String common = "/reviews";
}
