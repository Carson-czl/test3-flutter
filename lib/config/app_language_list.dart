class LanguageInfoParma {
  String label;
  String value;
  LanguageInfoParma({
    required this.label,
    required this.value,
  });
}

class AppLanguageList {
  static List<LanguageInfoParma> languageInfo = [
    LanguageInfoParma(label: "简体中文", value: 'zh_CN'),
    LanguageInfoParma(label: '繁體中文', value: 'zh_TW'),
    LanguageInfoParma(label: 'English', value: 'en'),
  ];

  static LanguageInfoParma getLanguageInfo(String value) {
    return languageInfo.firstWhere(
      (language) => language.value == value,
      orElse: () => LanguageInfoParma(label: "简体中文", value: 'zh_CN'),
    );
  }
}
