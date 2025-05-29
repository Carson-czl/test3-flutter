import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web_wallet/common/utils/common.dart';
import 'package:web_wallet/common/widget/custom_action_sheet.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';

class ExhibitionPrivateKeyPage extends StatefulWidget {
  const ExhibitionPrivateKeyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExhibitionPrivateKeyPageState();
  }
}

class _ExhibitionPrivateKeyPageState extends State<ExhibitionPrivateKeyPage> {
  String privateKeyStr = "asddgsdqwieuoqwnmedsa,dmnalksdjaslkdjasklhgsadas";

  bool showQrCode = false;

  bool showPrivateKey = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        // showTip();
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
                "请勿截屏分享和存储，这将可能被第三方而已软件收集，造成损失",
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
            title: '我知道了',
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  void showCopyPrivateKey() {
    CustomActionSheet.customContent(
      context,
      backgroundColor: ThemeScheme.color(const Color(0xfffafbfd)),
      title: context.l10n.copyPrivateKey,
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
              Image.asset("assets/images/alarm.png", width: 50, height: 50),
              const SizedBox(height: 10),
              const Text(
                "风险提示",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "复制私钥，存在风险，剪贴板容易被第三方应用监控或滥用；建议使用二维码形式，直接扫码进行钱包转移",
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
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Common.clipboard(privateKeyStr);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFD9F0F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    '仍然复制',
                    style: TextStyle(
                      color: Color(0xFF007FFF),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF007FFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    '不复制了',
                    style: TextStyle(
                      color: ThemeScheme.getWhite(),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 私钥界面
  Widget privateKeyTabBar() {
    return ListView(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          decoration: BoxDecoration(
            color: ThemeScheme.color(const Color(0xfffafbfd)),
            border: Border.all(
              color: ThemeScheme.color(const Color(0xffededed)),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "离线保存",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                ),
              ),
              Text(
                "切勿保存至邮箱、记事本、网盘、聊天工具等，非常危险",
                style: TextStyle(
                  color: ThemeScheme.getLightBlack(),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "切勿使用网络传输",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                ),
              ),
              Text(
                "请勿通过网络工具传输，一旦被黑客获取将造成不可挽回的资产损失，建议离线设备通过扫二维码方式传输。",
                style: TextStyle(
                  color: ThemeScheme.getLightBlack(),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "密码管理工具保存",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                ),
              ),
              Text(
                "建议使用密码管理工具管理",
                style: TextStyle(
                  color: ThemeScheme.getLightBlack(),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        viewContent(
          1,
          showPrivateKey
              ? Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Text(
                          privateKeyStr,
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeScheme.getBlack(),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: ThemeScheme.color(const Color(0xffededed)),
                    ),
                    Material(
                      child: customButton(
                        context,
                        title: context.l10n.copyPrivateKey,
                        fontColor: const Color(0xFF007FFF),
                        backgroundColor:
                            ThemeScheme.color(const Color(0xfffafbfd)),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        onPressed: showCopyPrivateKey,
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ],
    );
  }

  /// 二维码界面
  Widget qrCodeTabBar() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: BoxDecoration(
              color: ThemeScheme.color(const Color(0xfffafbfd)),
              border: Border.all(
                color: ThemeScheme.color(const Color(0xffededed)),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "仅供直接扫码",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "二维码禁止保存、截图、以及拍照。仅供用户在安全环境下直接扫码来方便的导入钱包",
                  style: TextStyle(
                    color: ThemeScheme.getLightBlack(),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "在安全环境下使用",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "请确保四周无人及无摄像头的情况下使用。二维码一旦被他人获取将造成不可换回的资产损失",
                  style: TextStyle(
                    color: ThemeScheme.getLightBlack(),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          viewContent(
            2,
            showQrCode
                ? QrImageView(
                    data: privateKeyStr,
                    version: QrVersions.auto,
                    size: 250,
                    padding: const EdgeInsets.all(30),
                  )
                : null,
          )
        ],
      ),
    );
  }

  /// 显示遮掩内容
  Widget viewContent(int type, Widget? showView) {
    return Container(
      width: type == 1 ? double.maxFinite : 270,
      height: 270,
      margin: const EdgeInsets.only(top: 50, bottom: 20, left: 15, right: 15),
      decoration: BoxDecoration(
        color: ThemeScheme.color(const Color(0xfffafbfd)),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: ThemeScheme.color(const Color(0xffededed)),
          width: 1,
        ),
      ),
      child: showView ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/anonymous.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 50),
              Material(
                color: ThemeScheme.color(const Color(0xfffafbfd)),
                child: customButton(
                  context,
                  title: type == 1
                      ? context.l10n.viewPrivateKey
                      : context.l10n.viewQRCode,
                  width: 120,
                  height: 30,
                  fontSize: 12,
                  onPressed: () => {
                    setState(() {
                      if (type == 1) {
                        showPrivateKey = true;
                      } else {
                        showQrCode = true;
                      }
                    })
                  },
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(
          context,
          title: context.l10n.exportPrivateKey,
          borderWidth: 1,
          backgroundColor: ThemeScheme.color(const Color(0xfffafbfd)),
        ),
        backgroundColor: ThemeScheme.getWhiteBackground(),
        body: Column(
          children: <Widget>[
            TabBar(
              indicatorColor: const Color(0xFF007FFF),
              labelColor: const Color(0xFF007FFF),
              unselectedLabelColor: ThemeScheme.getBlack(),
              dividerColor: ThemeScheme.color(const Color(0xffededed)),
              tabs: [
                Tab(text: context.l10n.privateKey),
                Tab(text: context.l10n.qRCode),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  privateKeyTabBar(),
                  qrCodeTabBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
