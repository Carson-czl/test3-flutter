import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_dialog.dart';
import 'package:web_wallet/components/my_list_item/my_list_item.dart';
import 'package:web_wallet/config/app_localizations.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/stores/app_settings.dart';

import 'currency_unit.dart';
import 'language_setting.dart';
import 'open_gesture_password.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserSettingsPageState();
  }
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    // 系统语言
    String devLanguage = Localizations.localeOf(context).toString();
    // 找出系统预设的语言
    String currentLanguage =
        AppLocalizationsConfig.getLocale(devLanguage).toString();
    LanguageInfoParma languageInfo =
        AppLocalizationsConfig.getLanguageInfo(currentLanguage);
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.settings,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            MyListItem(
              title: context.l10n.gesturePassword,
              borderWidth: 0,
              rightIconShow: false,
              renderExtra: Transform.scale(
                scale: 0.7,
                origin: const Offset(40, 0),
                child: Consumer<AppSettingsStore>(
                  builder: (context, store, child) {
                    return CupertinoSwitch(
                      value: store.openScreenPassword.isNotEmpty,
                      activeColor: const Color(0xff007fff),
                      onChanged: (bool value) {
                        if (value) {
                          String tipSuccessful = context.l10n.settingSuccessful;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const OpenGesturePasswordPage(),
                            ),
                          ).then((res) {
                            if (res != null) {
                              EasyLoading.showToast(tipSuccessful);
                            }
                          });
                        } else {
                          CustomDialog.confirm(
                            context,
                            content: context.l10n.closeGesturePasscode,
                            onSuccess: () => store.setOpenScreenPassword([]),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            MyListItem(
              title: context.l10n.hideBalance,
              borderWidth: 0,
              rightIconShow: false,
              renderExtra: Transform.scale(
                scale: 0.7,
                origin: const Offset(40, 0),
                child: Consumer<AppSettingsStore>(
                  builder: (context, store, child) {
                    return CupertinoSwitch(
                      value: store.appHideBalance,
                      activeColor: const Color(0xff007fff),
                      onChanged: store.setHideBalance,
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 30,
                left: 20,
                right: 20,
              ),
              child: Text(
                context.l10n.hideBalanceTip,
                style: const TextStyle(
                  color: Color(0xff868688),
                ),
              ),
            ),
            MyListItem(
              title: context.l10n.languages,
              extra: languageInfo.label,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSettingPage(
                      language: languageInfo.value,
                    ),
                  ),
                )
              },
            ),
            Consumer<AppSettingsStore>(
              builder: (context, store, child) {
                return MyListItem(
                  title: context.l10n.currency,
                  extra: store.appCurrency,
                  borderWidth: 0,
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencyUnitPage(
                          currency: store.appCurrency,
                        ),
                      ),
                    )
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
