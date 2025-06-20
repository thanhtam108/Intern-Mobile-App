import '../utils/shared_preferences _utils.dart';

class SearchHistoryUtils {
  static const String _key = 'recent_searches';

  static Future<void> addSearchTerm(String term) async {
    List<String> history = await SharedPrefsUtils.getStringList(_key);

    history.remove(term);
    history.insert(0, term);

    if (history.length > 10) {
      history = history.sublist(0, 10);
    }

    await SharedPrefsUtils.saveStringList(_key, history);
  }

  static Future<List<String>> getSearchHistory() async {
    return await SharedPrefsUtils.getStringList(_key);
  }

  static Future<void> clearHistory() async {
    await SharedPrefsUtils.remove(_key);
  }
}
