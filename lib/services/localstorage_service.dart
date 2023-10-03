
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  dynamic getFromDisk(String key) {
    var value = _preferences?.get(key);
    return value;
  }

  void removeFromDisk(String key) {
    _preferences?.remove(key);
  }
  void removeAllFromDisk() {
    _preferences?.clear();
  }
  void saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }

  bool containKeys(String key) {
    return _preferences!.containsKey(key);
  }


 
}
