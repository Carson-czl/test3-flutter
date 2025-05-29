import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/app_wallet_info.dart';
import 'package:web_wallet/config/global_config.dart';

class WalletManagement extends StatefulWidget {
  const WalletManagement({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WalletManagementState();
  }
}

class _WalletManagementState extends State<WalletManagement> {
  List<Map> accountList = [
    {
      "id": 1,
      "account": "test0",
      "list": ["ETH", "TRX"],
    },
    {
      "id": 2,
      "account": "test1",
      "list": ["TRX"],
    },
    {
      "id": 3,
      "account": "test2",
      "list": ["ETH"],
    },
    {
      "id": 4,
      "account": "aaa123",
      "list": ["ETH"],
    },
    {
      "id": 5,
      "account": "cccc123",
      "list": ["TRX"],
    },
    {
      "id": 6,
      "account": "cccc123",
      "list": ["TRX"],
    },
    {
      "id": 7,
      "account": "cccc123",
      "list": ["TRX"],
    },
    {
      "id": 8,
      "account": "cccc123",
      "list": ["TRX"],
    },
    {
      "id": 9,
      "account": "cccc123",
      "list": ["TRX"],
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _walletIconList(List<String> value) {
    List<Widget> res = <Widget>[];
    for (var i = 0; i < value.length; i++) {
      String item = value[i];
      res.add(AppWalletInfo.getWalletIcon(
        item,
        size: 25,
        iconSize: 20,
        marginRight: 5,
      ));
    }

    return res;
  }

  /// 钱包账户列表
  List<Widget> _accountList() {
    List<Widget> res = [];
    for (var i = 0; i < accountList.length; i++) {
      Map item = accountList[i];
      List<String> list = item['list'];
      int count = list.length;
      res.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Ink(
            decoration: BoxDecoration(
              color: ThemeScheme.getWhiteBackground(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                "/walletSettings",
                arguments: item['id'],
              ),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.leaderboard_rounded,
                            size: 25,
                            color: ThemeScheme.getLightBlack(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item['account'],
                            style: TextStyle(
                              fontSize: 20,
                              color: ThemeScheme.getBlack(),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: ThemeScheme.getLightBlack(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 10,
                        left: 30,
                      ),
                      child: Text(
                        context.l10n.accountCount(count),
                        style: TextStyle(
                          color: ThemeScheme.getLightBlack(),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        ..._walletIconList(list),
                        Expanded(
                          child: Text(
                            context.l10n.addAccount,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff007fff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.walletManagement,
        backgroundColor: ThemeScheme.color(const Color(0xFFF0F1F3)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: _accountList(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          child: customButton(
            context,
            onPressed: () => Navigator.pushNamed(context, "/walletCreate"),
            title: context.l10n.addWallet,
            width: 140,
            height: 40,
            borderRadius: BorderRadius.circular(30),
            iconChild: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
