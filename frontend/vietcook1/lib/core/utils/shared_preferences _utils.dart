import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  // Save object
  static Future<void> saveObject(String key, Object object) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(object);
    await prefs.setString(key, jsonString);
  }

  // Get object (Map)
  static Future<Map<String, dynamic>?> getObject(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  // Remove object
  static Future<void> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Clear all
  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Save list of strings
  static Future<void> saveStringList(String key, List<String> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, list);
  }

// Get list of strings
  static Future<List<String>> getStringList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
}
