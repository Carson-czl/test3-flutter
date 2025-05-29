import 'package:flutter/material.dart';
import 'package:web_wallet/common/local/local_storage.dart';

// https://blog.csdn.net/qq_21484461/article/details/136972555
/// app应用全局信息
class AppSettingsStore extends ChangeNotifier {
  /// 开屏密码
  List<int> openScreenPassword = [];

  /// app语言
  String appLanguage = '';

  /// 币种信息
  String appCurrency = 'USD';

  /// 隐藏余额
  bool appHideBalance = false;

  void init() {
    String language = LocalStorage.getString(LocalStorageKey.language);
    appLanguage = language;
    List<String> list =
        LocalStorage.getStringList(LocalStorageKey.gesturePassword);
    if (list.isNotEmpty) {
      openScreenPassword = list.map((e) => int.parse(e)).toList();
    }
    String currency = LocalStorage.getString(LocalStorageKey.currency);
    if (currency != '') {
      appCurrency = currency;
    }
    bool hideBalance = LocalStorage.getBool(LocalStorageKey.hideBalance);
    if (hideBalance) {
      appHideBalance = hideBalance;
    }
  }

  /// 设置隐藏余额
  void setHideBalance(bool value) {
    appHideBalance = value;
    if (value) {
      LocalStorage.savaBool(LocalStorageKey.hideBalance, value);
    } else {
      LocalStorage.remove(LocalStorageKey.hideBalance);
    }
    notifyListeners();
  }

  /// 设置开屏手势
  void setOpenScreenPassword(List<int> value) {
    openScreenPassword = value;
    if (value.isEmpty) {
      LocalStorage.remove(LocalStorageKey.gesturePassword);
    } else {
      List<String> stringList = value.map((int e) => e.toString()).toList();
      LocalStorage.savaStringList(LocalStorageKey.gesturePassword, stringList);
    }
    notifyListeners();
  }

  /// 设置语言环境
  void setLanguage(String value) {
    appLanguage = value;
    if (value != '') {
      LocalStorage.savaString(LocalStorageKey.language, value);
    } else {
      LocalStorage.remove(LocalStorageKey.language);
    }
    notifyListeners();
  }

  /// 设置货币单位
  void setCurrency(String value) {
    appCurrency = value;
    if (value != '') {
      LocalStorage.savaString(LocalStorageKey.currency, value);
    } else {
      LocalStorage.remove(LocalStorageKey.currency);
    }
    notifyListeners();
  }
}
