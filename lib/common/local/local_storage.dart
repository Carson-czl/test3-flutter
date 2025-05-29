import 'package:shared_preferences/shared_preferences.dart';

/// 如某个key修改里面的参数建议换个key否者会出现莫名其妙错误
enum LocalStorageKey {
  /// 用户登录信息的key
  userLoginInfo,

  /// 是否隐藏余额
  hideBalance,

  /// 手势密码
  gesturePassword,

  /// APP语言
  language,

  /// APP货币
  currency,
}

/// SharedPreferences 本地存储
class LocalStorage {
  static late SharedPreferences _preferences;

  /// 初始化缓存工作(在APP打开时候触发)
  static Future<SharedPreferences> getInstance() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static String getString(LocalStorageKey key) {
    String res = "";
    try {
      res = _preferences.getString(key.toString()) ?? "";
    } catch (error) {}
    return res;
  }

  static Future<void> savaString(LocalStorageKey key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  static int getInt(LocalStorageKey key) {
    int res = 0;
    try {
      res = _preferences.getInt(key.toString()) ?? 0;
    } catch (error) {}
    return res;
  }

  static Future<void> savaInt(LocalStorageKey key, int value) async {
    await _preferences.setInt(key.toString(), value);
  }

  static bool getBool(LocalStorageKey key) {
    bool res = false;
    try {
      res = _preferences.getBool(key.toString()) ?? false;
    } catch (error) {}
    return res;
  }

  static Future<void> savaBool(LocalStorageKey key, bool value) async {
    await _preferences.setBool(key.toString(), value);
  }

  static List<String> getStringList(LocalStorageKey key) {
    List<String> res = [];
    try {
      res = _preferences.getStringList(key.toString()) ?? [];
    } catch (error) {}
    return res;
  }

  static Future<void> savaStringList(
      LocalStorageKey key, List<String> value) async {
    await _preferences.setStringList(key.toString(), value);
  }

  static Future<void> remove(LocalStorageKey key) async {
    await _preferences.remove(key.toString());
  }
}
