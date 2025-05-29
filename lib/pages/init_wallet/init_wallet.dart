import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_action_sheet.dart';
import 'package:web_wallet/common/widget/custom_icons.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';

class InitWalletPage extends StatefulWidget {
  const InitWalletPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InitWalletPageState();
  }
}

class _InitWalletPageState extends State<InitWalletPage> {
  final List<Map<String, String>> bannerList = [
    {"img": "assets/images/landing1.png", "title": "多链钱包，轻松使用"},
    {"img": "assets/images/landing2.png", "title": "币币兑换，安全快速"},
    {"img": "assets/images/landing3.png", "title": "触手可及的区块链应用"}
  ];

  void onShowSelect() {
    CustomActionSheet.dragBottomSheet(
      context,
      title: "选择导入方式",
      height: 200,
      backgroundColor: ThemeScheme.color(const Color(0xfffafbfd)),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: ThemeScheme.getWhite(),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pushNamed(context, "/walletCreate"),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(
                      CustomIcons.docText,
                      color: ThemeScheme.getBlack(),
                      size: 25,
                    ),
                    title: Text(
                      "助记词",
                      style: TextStyle(
                        color: ThemeScheme.getBlack(),
                      ),
                    ),
                    subtitle: Text(
                      "助记词由单词组成，以空格隔开",
                      style: TextStyle(
                        color: ThemeScheme.getLightBlack(),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ThemeScheme.getLightBlack(),
                      size: 14,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, "/walletCreate"),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(
                      CustomIcons.key,
                      color: ThemeScheme.getBlack(),
                      size: 25,
                    ),
                    title: Text(
                      "私钥",
                      style: TextStyle(
                        color: ThemeScheme.getBlack(),
                      ),
                    ),
                    subtitle: Text(
                      "铭文私钥字符",
                      style: TextStyle(
                        color: ThemeScheme.getLightBlack(),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ThemeScheme.getLightBlack(),
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 420,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  var item = bannerList[index];
                  return Column(
                    children: <Widget>[
                      Image.asset(
                        item['img']!,
                        fit: BoxFit.fitHeight,
                        width: double.infinity,
                        height: 355,
                      ),
                      Text(
                        item['title']!,
                        style: TextStyle(
                          color: ThemeScheme.getBlack(),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: bannerList.length,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: ThemeScheme.color(const Color(0xffededed)),
                    activeColor: const Color(0xff007fff),
                    size: 8,
                    activeSize: 8,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: ThemeScheme.color(const Color(0xffededed)),
                ),
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, "/walletCreate"),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: ListTile(
                      title: const Text(
                        "创建钱包",
                        style: TextStyle(
                          color: Color(0xff007fff),
                        ),
                      ),
                      subtitle: Text(
                        "使用新的多链钱包",
                        style: TextStyle(
                          color: ThemeScheme.getLightBlack(),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: ThemeScheme.getLightBlack(),
                        size: 12,
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                    color: ThemeScheme.color(const Color(0xffededed)),
                  ),
                  InkWell(
                    onTap: onShowSelect,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: ListTile(
                      title: const Text(
                        "恢复身份",
                        style: TextStyle(
                          color: Color(0xff007fff),
                        ),
                      ),
                      subtitle: Text(
                        "使用我已拥有的钱包",
                        style: TextStyle(
                          color: ThemeScheme.getLightBlack(),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: ThemeScheme.getLightBlack(),
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
