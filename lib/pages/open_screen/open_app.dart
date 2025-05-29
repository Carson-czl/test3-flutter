import 'package:flutter/material.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/stores/app_settings.dart';

class OpenAppPage extends StatefulWidget {
  const OpenAppPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OpenAppPageState();
  }
}

class _OpenAppPageState extends State<OpenAppPage> {
  List<int> _answer = [];
  String _tipError = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _answer = Provider.of<AppSettingsStore>(context, listen: false)
            .openScreenPassword;
      });
    });

    super.initState();
  }

  void _onComplete(List<int?> data) {
    if (data.length >= 4) {
      if (_answer.join(',') != data.join(',')) {
        _tipError = context.l10n.gestureError;
      } else {
        Navigator.pushReplacementNamed(context, "/home");
      }
    } else {
      _tipError = context.l10n.atLeastConnectPoints;
    }
    setState(() {});
  }

  Widget _tipStr() {
    return Text(
      _tipError,
      style: TextStyle(
        fontSize: 14,
        color: _tipError == '' ? ThemeScheme.getLightBlack() : Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 80),
          Image.asset(
            "assets/images/logo.png",
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          _tipStr(),
          const SizedBox(height: 50),
          Center(
            child: GesturePasswordWidget(
              lineColor: const Color(0xff0C6BFE),
              errorLineColor: Colors.redAccent,
              singleLineCount: 3,
              identifySize: 90,
              minLength: 4,
              completeWaitMilliseconds: 500,
              errorItem: Image.asset(
                'assets/images/gesture_password/selected.png',
                color: Colors.redAccent,
              ),
              normalItem: Image.asset(
                'assets/images/gesture_password/normal.png',
                color: ThemeScheme.color(const Color(0xFFBFBFBF)),
              ),
              selectedItem: Image.asset(
                'assets/images/gesture_password/selected.png',
                color: const Color(0xff0C6BFE),
              ),
              arrowItem: Image.asset(
                'assets/images/gesture_password/arrow.png',
                width: 20.0,
                height: 20.0,
                color: const Color(0xff0C6BFE),
                fit: BoxFit.fill,
              ),
              errorArrowItem: Image.asset(
                'assets/images/gesture_password/arrow.png',
                width: 20.0,
                height: 20.0,
                fit: BoxFit.fill,
                color: Colors.redAccent,
              ),
              answer: _answer,
              color: Colors.transparent,
              onComplete: _onComplete,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: GestureDetector(
          onTap: () => {},
          child: Text(
            context.l10n.loginWithWalletPassword,
            // context.l10n.logInUsingGestures,
            style: const TextStyle(
              color: Color(0xff0C6BFE),
            ),
          ),
        ),
      ),
    );
  }
}
