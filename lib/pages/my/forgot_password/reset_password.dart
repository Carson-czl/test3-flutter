import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/custom_dialog.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/app_input/app_input.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String mnemonicStr = '';

  String walletPassword = "";
  String walletConfirmPassword = "";
  String walletTipText = "";

  int step = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void validationMnemonic() {
    if (mnemonicStr != '') {
      setState(() {
        step = 2;
      });
    } else {
      CustomDialog.confirm(context, content: "助记词不正确", showCancel: false);
    }
  }

  /// 输入校验
  List<Widget> inputValidation() {
    return [
      Text(
        "验证助记词",
        style: TextStyle(
          color: ThemeScheme.getBlack(),
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        "提供当前钱包的正确助记词以完成验证。",
        style: TextStyle(
          color: ThemeScheme.getLightBlack(),
        ),
      ),
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: ThemeScheme.getWhiteBackground(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: AppInput(
          hintText: "输入单词助记词，并使用空格分隔",
          keyboardType: TextInputType.multiline,
          maxLines: 8,
          onChanged: (value) {
            setState(() {
              mnemonicStr = value;
            });
          },
        ),
      ),
    ];
  }

  /// 输入新的密码
  List<Widget> inputNewPassword() {
    return [
      Text(
        "新密码",
        style: TextStyle(
          color: ThemeScheme.getBlack(),
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        "密码将用于在当前设备的交易授权和钱包解锁。imToken不会存储你的密码，请妥善保管。",
        style: TextStyle(
          color: ThemeScheme.getLightBlack(),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        "创建密码",
        style: TextStyle(
          color: ThemeScheme.getLightBlack(),
          fontSize: 12,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: ThemeScheme.getWhite(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            AppInput(
              maxLength: 20,
              hintText: "请输入钱包密码",
              type: AppInputType.password,
              onChanged: (value) {
                setState(() {
                  walletPassword = value;
                });
              },
            ),
            Divider(
              height: 0,
              indent: 10,
              endIndent: 10,
              color: ThemeScheme.color(const Color(0xffededed)),
            ),
            AppInput(
              maxLength: 20,
              hintText: "请输入钱包确认密码",
              type: AppInputType.password,
              onChanged: (value) {
                setState(() {
                  walletConfirmPassword = value;
                });
              },
            ),
          ],
        ),
      ),
      Text(
        "密码提示（可选）",
        style: TextStyle(
          fontSize: 12,
          color: ThemeScheme.getLightBlack(),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: ThemeScheme.getWhiteBackground(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: AppInput(
          maxLength: 50,
          hintText: "请输入提示文字",
          onChanged: (value) {
            setState(() {
              walletTipText = value;
            });
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "重置密码",
        backgroundColor: ThemeScheme.color(const Color(0xfff0f1f3)),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$step/2",
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
                fontSize: 16,
              ),
            ),
            ...(step == 1 ? inputValidation() : inputNewPassword()),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        color: ThemeScheme.color(const Color(0xfff0f1f3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: customButton(
            context,
            onPressed: () {
              validationMnemonic();
            },
            disabled: mnemonicStr == '',
            title: '马上导入',
          ),
        ),
      ),
    );
  }
}
