import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/app_localizations.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/stores/app_settings.dart';

class LanguageSettingPage extends StatefulWidget {
  final String language;
  const LanguageSettingPage({
    super.key,
    required this.language,
  });

  @override
  State<StatefulWidget> createState() {
    return _LanguageSettingPageState();
  }
}

class _LanguageSettingPageState extends State<LanguageSettingPage> {
  final List<LanguageInfoParma> _languageList =
      AppLocalizationsConfig.languageList;

  String _currentLanguage = "";

  @override
  void initState() {
    _currentLanguage = widget.language;
    super.initState();
  }

  void _onSave() {
    Provider.of<AppSettingsStore>(context, listen: false)
        .setLanguage(_currentLanguage);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.languages,
        rightBtn: <Widget>[
          TextButton(
            onPressed: _onSave,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith(
                (states) {
                  return Colors.transparent;
                },
              ),
            ),
            child: Text(
              context.l10n.save,
              style: const TextStyle(
                  color: Color(0xff007fff), fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: ListView.separated(
        itemCount: _languageList.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 0,
          color: ThemeScheme.color(const Color(0xffeeeeee)),
        ),
        itemBuilder: (context, index) {
          var item = _languageList[index];
          return InkWell(
            onTap: () => {
              setState(() {
                _currentLanguage = item.value;
              })
            },
            child: ListTile(
              title: Text(
                item.label,
                style: TextStyle(
                  color: ThemeScheme.getBlack(),
                ),
              ),
              trailing: item.value == _currentLanguage
                  ? const Icon(
                      Icons.check,
                      color: Color(0xff007fff),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
