import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';

import 'view_backups.dart';

class WalletBackupsPage extends StatefulWidget {
  const WalletBackupsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WalletBackupsPageState();
  }
}

class _WalletBackupsPageState extends State<WalletBackupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/backup_mnemonic.png",
                width: 150,
                height: 120,
              ),
            ),
            Text(
              "备份助记词，保障钱包安全",
              style: TextStyle(
                color: ThemeScheme.getBlack(),
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "当更换手机或重装应用时，你将需要助记词（12个英文单词）恢复钱包。为保障钱包的安全，请务必尽快完成助记词备份",
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "重要提醒：",
              style: TextStyle(
                color: ThemeScheme.getBlack(),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "获得助记词等于拥有钱包资产所有权。",
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "如何安全地备份助记词？",
              style: TextStyle(
                color: ThemeScheme.getBlack(),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 3),
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
                    '使用纸笔，按正确次序抄写助记词。',
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
                    '助记词保管至安全的地方。',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: customButton(
            context,
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewBackupsPage(),
                ),
              )
            },
            title: '立即备份',
          ),
        ),
      ),
    );
  }
}
