import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_wallet/common/utils/cache.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_dialog.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/my_list_item/my_list_item.dart';
import 'package:web_wallet/config/global_config.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutUsPageState();
  }
}

class _AboutUsPageState extends State<AboutUsPage> {
  String currentVersion = 'v1.0.0';
  String nextVersion = '';
  String cacheSize = '';

  @override
  void initState() {
    setCacheSize();
    getAppNextVersion();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 触发App更新
  void onUpdate() {
    if (nextVersion == "") {
      EasyLoading.showToast(context.l10n.latestVersion);
    } else {
      CustomDialog.confirm(
        context,
        content: context.l10n.updateTheApp,
        onSuccess: () {
          setState(() {});
        },
      );
    }
  }

  /// 获取下一个APP版本
  void getAppNextVersion() {
    nextVersion = "";
    // nextVersion = "v1.0.0";
  }

  /// 清除缓存
  void deleteAll() {
    CustomDialog.confirm(
      context,
      content: context.l10n.confirmToClearCache,
      onSuccess: () {
        Cache.getAllDirectory().then((value) async {
          await Cache.deleteDir(value);
          setCacheSize();
        });
      },
    );
  }

  void setCacheSize() async {
    try {
      var value = await Cache.getCache();
      setState(() {
        cacheSize = value;
      });
    } catch (error) {
      setState(() {
        cacheSize = '0.00M';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.aboutUs,
        backgroundColor: ThemeScheme.color(const Color(0xFFF0F1F3)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            Image.asset("assets/images/logo.png", width: 60, height: 60),
            const SizedBox(height: 8),
            Text(
              "imToken",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeScheme.getBlack(),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentVersion,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
              ),
            ),
            const SizedBox(height: 40),
            MyListItem(
              title: context.l10n.versionUpdate,
              rightIconShow: false,
              renderExtra: Offstage(
                offstage: nextVersion == "",
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        nextVersion, // 右侧文字
                        style: TextStyle(
                          fontSize: 12.5,
                          color: ThemeScheme.getLightBlack(),
                        ),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onPressed: onUpdate,
            ),
            MyListItem(
              title: context.l10n.clearCache,
              extra: cacheSize,
              rightIconShow: false,
              onPressed: deleteAll,
            ),
          ],
        ),
      ),
    );
  }
}
