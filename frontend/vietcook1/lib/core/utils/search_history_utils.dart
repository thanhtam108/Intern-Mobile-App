import 'shared_preferences _utils.dart';

class SearchHistoryUtils {
  static const String _key = 'recent_search_keywords';

  /// Lưu lịch sử tìm kiếm
  static Future<void> save(List<String> history) {
    return SharedPrefsUtils.saveStringList(_key, history);
  }

  /// Lấy danh sách tìm kiếm
  static Future<List<String>> load() {
    return SharedPrefsUtils.getStringList(_key);
  }

  /// Xóa lịch sử tìm kiếm
  static Future<void> clear() {
    return SharedPrefsUtils.remove(_key);
  }
}
