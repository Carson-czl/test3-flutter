import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/custom_icons.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/pages/my/forgot_password/reset_password.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff007fff), Color(0xFF0CC3FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.https_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
            Text(
              "${context.l10n.forgotPassword}?",
              style: TextStyle(
                fontSize: 18,
                color: ThemeScheme.getBlack(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "imToken不会存储你的钱包密码。如果你忘记了密码或想创建一个新密码，你可以通过提供正确的助记词或私钥赖重置密码。",
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                "验证",
                style: TextStyle(
                  color: ThemeScheme.getBlack(),
                ),
              ),
              subtitle: Text(
                "提供助记词验证",
                style: TextStyle(
                  color: ThemeScheme.getLightBlack(),
                ),
              ),
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFCBE5FE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.checkmark_shield,
                  color: Color(0xff007fff),
                  size: 23,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                "创建新密码",
                style: TextStyle(
                  color: ThemeScheme.getBlack(),
                ),
              ),
              subtitle: Text(
                "请妥善保管，仅供自己使用",
                style: TextStyle(
                  color: ThemeScheme.getLightBlack(),
                ),
              ),
              leading: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFCBE5FE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CustomIcons.key,
                  color: Color(0xff007fff),
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        color: ThemeScheme.getWhiteBackground(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: customButton(
            context,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordPage(),
              ),
            ),
            title: '重置密码',
          ),
        ),
      ),
    );
  }
}
