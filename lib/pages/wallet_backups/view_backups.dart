import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_action_sheet.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';

import 'confirm_mnemonic.dart';

class ViewBackupsPage extends StatefulWidget {
  const ViewBackupsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewBackupsPageState();
  }
}

class _ViewBackupsPageState extends State<ViewBackupsPage> {
  final List<String> mnemonicList = [
    "asset1",
    "ccc2",
    "asset3",
    "asset4",
    "asset5",
    "asset6",
    "asset7",
    "asset8",
    "tape9",
    "asset10",
    "asset11",
    "tape12",
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        showTip();
      });
    });
    super.initState();
  }

  void showTip() {
    CustomActionSheet.customContent(
      context,
      backgroundColor: ThemeScheme.color(const Color(0xfffafbfd)),
      height: 280,
      children: <Widget>[
        Container(
          width: double.maxFinite,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
          decoration: BoxDecoration(
            color: ThemeScheme.getWhiteBackground(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/screenshot_ban.png",
                  width: 50, height: 50),
              const SizedBox(height: 10),
              Text(
                "请勿截屏",
                style: TextStyle(
                  color: ThemeScheme.getBlack(),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "请不要通过屏幕的方式进行备份，这将会增加助记词被盗和丢失的风险。图库一旦被恶意软件窃取，将会造成资产损失。",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeScheme.getLightBlack(),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
          child: customButton(
            context,
            onPressed: () => Navigator.pop(context),
            title: '我知道了',
          ),
        ),
      ],
    );
  }

  Widget _viewMnemonic() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ThemeScheme.color(const Color(0xfffafbfd)),
        border: Border.all(
          color: ThemeScheme.color(const Color(0xffecedf2)),
          width: 1,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(children: _viewMnemonicItem([0, 1, 2])),
          Row(children: _viewMnemonicItem([3, 4, 5])),
          Row(children: _viewMnemonicItem([6, 7, 8])),
          Row(children: _viewMnemonicItem([9, 10, 11])),
        ],
      ),
    );
  }

  List<Widget> _viewMnemonicItem(List<int> position) {
    List<Widget> item = [];
    for (var i = 0; i < position.length; i++) {
      var index = position[i];
      item.add(
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                top: index < 3
                    ? BorderSide.none
                    : BorderSide(
                        width: 1,
                        color: ThemeScheme.color(const Color(0xffededed)),
                      ),
                left: i == 0
                    ? BorderSide.none
                    : BorderSide(
                        width: 1,
                        color: ThemeScheme.color(const Color(0xffededed)),
                      ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: ThemeScheme.getLightBlack(),
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  mnemonicList[index],
                  style: TextStyle(
                    color: ThemeScheme.getBlack(),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        borderWidth: 1,
      ),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '备份助记词',
              style: TextStyle(
                fontSize: 14,
                color: ThemeScheme.getBlack(),
              ),
            ),
            Text(
              '请按顺序抄写助记词，确保备份正确。',
              style: TextStyle(
                fontSize: 12,
                color: ThemeScheme.getLightBlack(),
              ),
            ),
            _viewMnemonic(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 9, right: 5),
                  decoration: BoxDecoration(
                    color: ThemeScheme.getLightBlack(),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '妥善保管助记词至隔离网络的安全地方。',
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 9, right: 5),
                  decoration: BoxDecoration(
                    color: ThemeScheme.getLightBlack(),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '请勿将助记词在联网环境下分享和存储，比如邮件、相册、社交应用等。',
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        color: ThemeScheme.getWhiteBackground(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: ThemeScheme.color(const Color(0xffededed)),
              ),
            ),
          ),
          child: customButton(
            context,
            title: '已确认备份',
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmMnemonicPage(
                    mnemonicList: mnemonicList,
                  ),
                ),
              )
            },
          ),
        ),
      ),
    );
  }
}
