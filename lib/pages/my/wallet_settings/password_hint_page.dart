import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';

class PasswordHintPage extends StatefulWidget {
  const PasswordHintPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PasswordHintPageState();
  }
}

class _PasswordHintPageState extends State<PasswordHintPage> {
  bool isShowPassWord = false;

  String passwordHintStr = "12212";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.passwordHint,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        color: ThemeScheme.getWhiteBackground(),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              isShowPassWord ? passwordHintStr : "*******",
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
              ),
            ),
            IconButton(
              onPressed: () => {
                setState(() {
                  isShowPassWord = !isShowPassWord;
                })
              },
              highlightColor: Colors.transparent,
              icon: isShowPassWord
                  ? const Icon(
                      Icons.remove_red_eye,
                      size: 20,
                      color: Color(0xff007fff),
                    )
                  : Icon(
                      Icons.visibility_off,
                      size: 20,
                      color: ThemeScheme.getLightBlack(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
