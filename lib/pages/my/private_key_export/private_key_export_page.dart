import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';

import 'exhibition_private_key_page.dart';

class PrivateKeyExportPage extends StatefulWidget {
  const PrivateKeyExportPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PrivateKeyExportPageState();
  }
}

class _PrivateKeyExportPageState extends State<PrivateKeyExportPage> {
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
              padding: const EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/private_key_export.png",
                width: 100,
                height: 100,
              ),
            ),
            Text(
              "备份提示",
              style: TextStyle(
                color: ThemeScheme.getBlack(),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "获取私钥等于拥有钱包资产所有权",
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
                fontSize: 16,
              ),
            ),
            Divider(
              height: 40,
              color: ThemeScheme.color(const Color(0xffededed)),
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
                    '使用笔纸正确抄写，并保管至安全的地方。',
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
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
                    '私钥丢失，无法找回，请务必备份私钥。',
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
            title: context.l10n.next,
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExhibitionPrivateKeyPage(),
                ),
              )
            },
          ),
        ),
      ),
    );
  }
}
