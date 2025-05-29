import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_wallet/app.dart';

import 'common/local/local_storage.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保Flutter框架初始化完毕
  await LocalStorage.getInstance();
  runApp(const MyApp());
}
