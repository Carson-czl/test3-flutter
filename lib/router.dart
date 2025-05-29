import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'common/router/route_observer_util.dart';
import 'common/widget/theme_scheme.dart';
import 'config/app_localizations.dart';
import 'config/global_config.dart';
import 'pages/my/wallet_settings/account_details_page.dart';
import 'stores/app_settings.dart';

import 'pages/open_screen/open_screen.dart';
import 'pages/init_wallet/init_wallet.dart';
import 'pages/home_tab_bar/home_tab_bar.dart';
import 'pages/my/address_book/address_book.dart';
import 'pages/my/wallet_management/wallet_management.dart';
import 'pages/my/wallet_settings/wallet_settings_page.dart';
import 'pages/wallet_backups/wallet_backups.dart';
import 'pages/my/wallet_create/wallet_create.dart';
import 'pages/my/forgot_password/forgot_password_page.dart';
import 'pages/web_view/web_view.dart';
import 'pages/transaction/transaction_info/transaction_info.dart';
import 'pages/transaction/collect_payment/collect_payment.dart';
import 'pages/transaction/transfer_accounts/transfer_accounts.dart';

class MyRouter extends StatefulWidget {
  const MyRouter({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyRouterState();
  }
}

class _MyRouterState extends State<MyRouter> {
  // with AutomaticKeepAliveClientMixin
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  final Map<String, WidgetBuilder> router = {
    // '/': (BuildContext context) => const OpenScreenPage(),
    '/initWallet': (BuildContext context) => const InitWalletPage(),
    '/webView': (BuildContext context) => const WebViewPage(),
    '/home': (BuildContext context) => const HomeTabBar(),
    '/walletManagement': (BuildContext context) => const WalletManagement(),
    '/walletSettings': (BuildContext context) => const WalletSettingsPage(),
    '/accountDetails': (BuildContext context) => const AccountDetailsPage(),
    '/walletCreate': (BuildContext context) => const WalletCreatePage(),
    '/addressBook': (BuildContext context) => const AddressBookPage(),
    '/transactionInfo': (BuildContext context) => const TransactionInfoPage(),
    '/collectPayment': (BuildContext context) => const CollectPaymentPage(),
    '/transferAccounts': (BuildContext context) => const TransferAccountsPage(),
    '/walletBackups': (BuildContext context) => const WalletBackupsPage(),
    '/forgotPassword': (BuildContext context) => const ForgotPasswordPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsStore>(
      builder: (context, store, child) {
        String currentLanguage = store.appLanguage;
        if (currentLanguage == '') {
          // 系统语言
          // String devLanguage = Localizations.localeOf(context).toString();

          // print("系统语言$devLanguage");
          // 找出系统预设的语言
        }
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          // initialRoute: '/test', // 必须写否则路劲默认"/"
          initialRoute: '/', // 必须写否则路劲默认"/"
          locale: AppLocalizationsConfig.getLocale(currentLanguage),

          /// 多语言实现代理
          /// https://docs.flutter.cn/ui/accessibility-and-internationalization/internationalization/
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // 英文
            Locale('zh', 'CN'), // 简体中文
            Locale('zh', 'TW') // 繁体中文
          ],
          // localeResolutionCallback: (locale, supportedLocales) {
          //   print("locale=$locale");
          //   print("localeResolutionCallback=${locale.toString()}");
          //   if (store.appLanguage != '') {
          //     return AppLocalizationsConfig.getLocale(
          //         store.appLanguage); // 直接采用系统语言
          //   } else {
          //     return AppLocalizationsConfig.getLocale(
          //         locale.toString()); // 直接采用系统语言
          //   }
          // },
          theme: ThemeData(
            scaffoldBackgroundColor:
                ThemeScheme.color(const Color(0xFFF0F1F3)), // Body默认色
            appBarTheme: AppBarTheme(
              backgroundColor:
                  ThemeScheme.getWhiteBackground(), // 自定义 AppBar 颜色
              shadowColor: ThemeScheme.getBlack(),
              surfaceTintColor: Colors.transparent, // 页面滚动后颜色渐变该色
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent, // 设置状态栏的背景颜色
                statusBarIconBrightness: Brightness.dark, // 状态栏的文字的颜色
              ),
            ),
          ),
          builder: EasyLoading.init(),
          navigatorObservers: <NavigatorObserver>[
            RouteObserverUtil().routeObserver,
          ],
          routes: router,
        );
      },
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
