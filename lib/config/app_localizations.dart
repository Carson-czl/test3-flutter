import 'package:flutter/material.dart';

class LanguageInfoParma {
  String label;
  String value;
  String server; // 传给服务端的字段
  LanguageInfoParma({
    required this.label,
    required this.value,
    required this.server,
  });
}

class AppLocalizationsConfig {
  /// 语言列表
  static List<LanguageInfoParma> languageList = [
    LanguageInfoParma(label: 'English', value: 'en', server: 'en'),
    LanguageInfoParma(label: "简体中文", value: 'zh_CN', server: 'zh-cn'),
    LanguageInfoParma(label: '繁體中文', value: 'zh_TW', server: 'zh-tw'),
  ];

  static LanguageInfoParma getLanguageInfo(String value) {
    return languageList.firstWhere(
      (language) => language.value == value,
      orElse: () => languageList[0],
    );
  }

  /// 处理多语言返回找不到则en
  static Locale getLocale(String value) {
    Locale res;
    switch (value) {
      case 'en':
        res = const Locale('en');
        break;
      case 'zh_CN':
        res = const Locale('zh', 'CN');
        break;
      case 'zh_TW':
        res = const Locale('zh', 'TW');
        break;
      default:
        // res = const Locale('en');
        res = const Locale('zh', 'CN');
        break;
    }
    print("value=$value language=$res");
    return res;
  }

  /// 对应的币种符号
  static Map<String, String> currencyUnitInfo = {
    "USD": "\$",
    "CNY": "￥",
  };
  /// 计算币种换算
  static num currencyCalc(num value)  {
    return value;
  }


}
