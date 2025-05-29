import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_icons.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/pages/my/about_us/about_us_page.dart';
import 'package:web_wallet/pages/my/user_settings/user_settings.dart';
import 'package:web_wallet/pages/web_view/web_view.dart';
import '/common/widget/custom_app_bar.dart';
import '/components/my_list_item/my_list_item.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.my,
        borderWidth: 1,
        leadingShow: false,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: <Widget>[
          MyListItem(
            title: context.l10n.walletManagement,
            leftIconData: CustomIcons.wallet,
            onPressed: () => Navigator.pushNamed(context, "/walletManagement"),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          MyListItem(
            title: context.l10n.addressBook,
            leftPicture: '',
            leftIconData: CustomIcons.contacts,
            onPressed: () => Navigator.pushNamed(context, "/addressBook"),
          ),
          MyListItem(
            title: context.l10n.blockchainNetwork,
            leftPicture: '',
            leftIconData: Icons.home,
            onPressed: () => Navigator.pushNamed(context, "/initWallet"),
          ),
          MyListItem(
            title: context.l10n.settings,
            leftPicture: '',
            leftIconData: Icons.settings,
            borderWidth: 0,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserSettingsPage(),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          MyListItem(
            title: context.l10n.helpAndFeedback,
            leftPicture: '',
            leftIconData: CustomIcons.help,
            onPressed: () => Navigator.pushNamed(
              context,
              "/webView",
              arguments: WebViewPageParam(
                  title: context.l10n.helpAndFeedback,
                  uri: "https://www.baidu.com/"),
            ),
          ),
          MyListItem(
            title: context.l10n.walletGuide,
            leftPicture: '',
            leftIconData: Icons.home,
            onPressed: () => Navigator.pushNamed(
              context,
              "/webView",
              arguments: WebViewPageParam(
                  title: context.l10n.walletGuide,
                  uri: "https://www.baidu.com/"),
            ),
          ),
          MyListItem(
            title: context.l10n.userAgreement,
            leftPicture: '',
            leftIconData: CustomIcons.agreement,
            onPressed: () => Navigator.pushNamed(
              context,
              "/webView",
              arguments: WebViewPageParam(
                  title: context.l10n.userAgreement,
                  uri: "https://www.baidu.com/"),
            ),
          ),
          MyListItem(
            title: context.l10n.aboutUs,
            leftPicture: '',
            leftIconData: CustomIcons.aboutUs,
            leftIconSize: 18,
            borderWidth: 0,
            renderExtra: Offstage(
              offstage: true,
              child: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutUsPage(),
              ),
            ),
          ),
          // MyListItem(
          //   title: "test",
          //   leftPicture: '',
          //   leftIconData: Icons.cabin,
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const PrivateKeyExportPage(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
