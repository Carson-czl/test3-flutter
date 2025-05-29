import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'stores/app_settings.dart';
import 'router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 设置状态栏
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));

      /// 只能纵向
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context)=>ThemeModel()),
        ChangeNotifierProvider(
          create: (context) => AppSettingsStore()..init(), // 触发初始化
        ),
        // ProxyProvider<DataModel1, DataModel2>(
        //   create: (context) => DataModel2(),
        //   update: (context, dataModel1, dataModel2) =>
        //       dataModel2..updateFrom(dataModel1),
        // ),
      ],
      child: const MyRouter(),
    );
  }
}
