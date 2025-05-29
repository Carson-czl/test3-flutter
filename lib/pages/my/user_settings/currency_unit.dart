import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/app_localizations.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/stores/app_settings.dart';

class CurrencyUnitPage extends StatefulWidget {
  final String currency;
  const CurrencyUnitPage({
    super.key,
    required this.currency,
  });

  @override
  State<StatefulWidget> createState() {
    return _CurrencyUnitPageState();
  }
}

class _CurrencyUnitPageState extends State<CurrencyUnitPage> {
  List<String> get currencyList =>
      AppLocalizationsConfig.currencyUnitInfo.keys.toList();

  String _currentCurrency = "";

  @override
  void initState() {
    _currentCurrency = widget.currency;
    super.initState();
  }

  void _onSave() {
    Provider.of<AppSettingsStore>(context, listen: false)
        .setCurrency(_currentCurrency);
    Navigator.pop(context, _currentCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.currency,
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
        itemCount: currencyList.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 0,
          color: ThemeScheme.color(const Color(0xffeeeeee)),
        ),
        itemBuilder: (context, index) {
          var item = currencyList[index];
          return InkWell(
            onTap: () => {
              setState(() {
                _currentCurrency = item;
              })
            },
            child: ListTile(
              title: Text(
                item,
                style: TextStyle(
                  color: ThemeScheme.getBlack(),
                ),
              ),
              trailing: item == _currentCurrency
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
