import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/stores/app_settings.dart';

import 'open_app.dart';

class OpenScreenPage extends StatefulWidget {
  const OpenScreenPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OpenScreenPageState();
  }
}

class _OpenScreenPageState extends State<OpenScreenPage> {
  bool isOpenGesturePassword = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 使用 Future.delayed 来模拟延时，假设延时 0.5 秒
      // await Future.delayed(const Duration(milliseconds: 500));
      getOpenGesturePassword();
    });
    super.initState();
  }

  /// 获取手势密码
  void getOpenGesturePassword() {
    AppSettingsStore store =
        Provider.of<AppSettingsStore>(context, listen: false);
    if (store.openScreenPassword.isNotEmpty) {
      isOpenGesturePassword = true;
    }
    openApp();
  }

  void openApp() {
    if (isOpenGesturePassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OpenAppPage(),
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/open_screen_bg.png",
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Positioned(
          child: Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
