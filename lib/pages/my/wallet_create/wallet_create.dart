import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/app_input/app_input.dart';

class WalletCreatePage extends StatefulWidget {
  const WalletCreatePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WalletCreatePageState();
  }
}

class _WalletCreatePageState extends State<WalletCreatePage> {
  String walletName = "";
  String walletPassword = "";
  String walletConfirmPassword = "";
  String walletTipText = "";

  bool dragBottomSheetShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onCreateWallet() {}

  void showDes() {
    // if (dragBottomSheetShow) {
    //   dragBottomSheetKey.currentState?.hide();
    // } else {
    //   dragBottomSheetKey.currentState?.show();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // 点击其他地方直接收起键盘
    final FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      appBar: customAppBar(
        context,
        backgroundColor: ThemeScheme.color(const Color(0xFFF0F1F3)),
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus
                ?.unfocus(disposition: UnfocusDisposition.scope);
          }
        },
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "创建钱包",
                style: TextStyle(
                  fontSize: 25,
                  color: ThemeScheme.getBlack(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "为你的多账户钱包命名并设置密码保护。你也可以稍后添加更多钱包。",
                style: TextStyle(
                  fontSize: 16,
                  color: ThemeScheme.getLightBlack(),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: showDes,
                child: const Text(
                  "探索多账户钱包的可能性",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff007fff),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "钱包名称",
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeScheme.getLightBlack(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 15),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: ThemeScheme.getWhiteBackground(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: AppInput(
                  maxLength: 12,
                  type: AppInputType.clear,
                  hintText: "请输入钱包名称",
                  onChanged: (value) {
                    setState(() {
                      walletName = value;
                    });
                  },
                ),
              ),
              Text(
                "创建密码",
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeScheme.getLightBlack(),
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
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        color: ThemeScheme.color(const Color(0xFFF0F1F3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: customButton(
            context,
            onPressed: onCreateWallet,
            title: '创建',
            disabled: (walletName == "" ||
                walletPassword == "" ||
                walletConfirmPassword == ""),
          ),
        ),
      ),
    );
  }
}
