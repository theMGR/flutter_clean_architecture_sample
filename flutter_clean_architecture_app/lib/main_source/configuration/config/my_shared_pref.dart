import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  MySharedPref() {
    init();
  }

  /*MySharedPref._() {
    init();
  }

  static final MySharedPref _instance = MySharedPref._();

  static MySharedPref get instance => _instance;

  static MySharedPref get I => _instance;*/

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> put<T>(String key, T value) async {
    if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      throw Exception('Type not supported');
    }
  }

  T? get<T>(String key) {
    if (T == String) {
      return _prefs.getString(key) as T?;
    } else if (T == int) {
      return _prefs.getInt(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == List<String>) {
      return _prefs.getStringList(key) as T?;
    } else {
      throw Exception('Type not supported');
    }
  }

  // Method to remove a key
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Method to clear all data
  Future<void> clear() async {
    await _prefs.clear();
  }

  Future<void> reload() async {
    await _prefs.reload();
  }
}
