import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/custom_dialog.dart';
import 'package:web_wallet/common/widget/custom_icons.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/app_input/app_input.dart';
import 'package:web_wallet/components/payment_keyboard/payment_keyboard.dart';
import 'package:web_wallet/config/app_localizations.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/stores/app_settings.dart';

class TransferAccountsPageParam {
  String walletName;
  TransferAccountsPageParam({
    this.walletName = '',
  });
}

class TransferAccountsPage extends StatefulWidget {
  const TransferAccountsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TransferAccountsPageState();
  }
}

class _TransferAccountsPageState extends State<TransferAccountsPage> {
  String walletName = 'TRX';
  String transferAddress = '1';
  String transferMoney = '1';
  String transferRemarks = '';
  bool showServiceChargeDetails = false;

  final addressKey = GlobalKey<AppInputState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var routeInfo = ModalRoute.of(context);
      if (routeInfo != null) {
        var arguments =
            routeInfo.settings.arguments as TransferAccountsPageParam?;
        if (arguments != null) {
          setState(() {
            walletName = arguments.walletName;
          });
        }
      }
    });
    super.initState();
  }

  void onConfirm() {
    double money = double.tryParse(transferMoney) ?? 0;
    if (money <= 0) {
      CustomDialog.alert(
        context,
        content: '账户余额不足以支付转账和矿工费',
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => PaymentKeyboard(
          onCompleted: (password) {
            Navigator.pop(context);
            // 处理密码
            print('输入的密码: $password');
          },
        ),
      );
    }
  }

  /// 收款地址
  List<Widget> paymentAddress() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          context.l10n.receivingAddress,
          style: TextStyle(
            color: ThemeScheme.getLightBlack(),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 15, right: 5),
        decoration: BoxDecoration(
          color: ThemeScheme.getWhiteBackground(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: AppInput(
          key: addressKey,
          hintText: "$walletName ${context.l10n.address}",
          minLines: 1,
          maxLines: 4,
          rightIconWidget: GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, "/addressBook", arguments: 1)
                  .then((result) {
                if (result != null) {
                  addressKey.currentState?.controller.text = result as String;
                  transferAddress = result as String;
                }
              })
            },
            child: Icon(
              CustomIcons.contacts,
              size: 25,
              color: ThemeScheme.getLightBlack(),
            ),
          ),
          onChanged: (value) {
            setState(() {
              transferAddress = value;
            });
          },
        ),
      ),
    ];
  }

  /// 手续费用计算
  List<Widget> serviceChargeInfo() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 20, bottom: 8),
        child: Text(
          context.l10n.gasFee,
          style: TextStyle(
            color: ThemeScheme.getLightBlack(),
          ),
        ),
      ),
      Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: ThemeScheme.getWhiteBackground(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<AppSettingsStore>(
              builder: (context, store, child) {
                return Text(
                  "${AppLocalizationsConfig.currencyUnitInfo[store.appCurrency]} ${AppLocalizationsConfig.currencyCalc(0)}",
                  style: TextStyle(
                    color: ThemeScheme.getBlack(),
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: () => setState(() {
                showServiceChargeDetails = !showServiceChargeDetails;
              }),
              child: Row(
                children: <Widget>[
                  Text(
                    "${transferMoney == '' ? '0' : transferMoney} $walletName",
                    style: TextStyle(
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    showServiceChargeDetails
                        ? CupertinoIcons.chevron_up_circle_fill
                        : CupertinoIcons.chevron_down_circle_fill,
                    size: 15,
                    color: ThemeScheme.getLightBlack(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "$walletName ${context.l10n.transfer}",
        backgroundColor: ThemeScheme.color(const Color(0xfff0f1f3)),
        rightBtn: <Widget>[
          IconButton(
            onPressed: () {},
            highlightColor: Colors.transparent,
            icon: Icon(
              CustomIcons.scan,
              size: 20,
              color: ThemeScheme.getBlack(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...paymentAddress(),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 5, top: 20, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    context.l10n.amount,
                    style: TextStyle(
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ),
                  Text(
                    "${0} $walletName",
                    style: TextStyle(
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: ThemeScheme.getWhiteBackground(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppInput(
                    maxLength: 12,
                    hintText: "0",
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      AppInputTextInputFormatter(),
                    ],
                    textStyle: TextStyle(
                      color: ThemeScheme.getBlack(),
                      fontSize: 38,
                      height: 1,
                    ),
                    onChanged: (value) {
                      setState(() {
                        transferMoney = value;
                      });
                    },
                  ),
                  Consumer<AppSettingsStore>(
                    builder: (context, store, child) {
                      String str = "";
                      double money = double.tryParse(transferMoney) ?? 0;
                      if (money > 0) {
                        str =
                            "${AppLocalizationsConfig.currencyUnitInfo[store.appCurrency]} ${AppLocalizationsConfig.currencyCalc(money)}";
                      }
                      return Text(
                        str,
                        style: TextStyle(
                            color: ThemeScheme.getLightBlack(), fontSize: 12),
                      );
                    },
                  ),
                  Divider(
                    height: 6,
                    color: ThemeScheme.color(const Color(0xffededed)),
                  ),
                  const SizedBox(height: 8),
                  AppInput(
                    hintText: context.l10n.remark,
                    maxLength: 100,
                    maxLines: 4,
                    counterText: '${transferRemarks.length}/100',
                    onChanged: (value) {
                      setState(() {
                        transferRemarks = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            ...serviceChargeInfo(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        color: ThemeScheme.color(const Color(0xfff0f1f3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: customButton(
            context,
            title: context.l10n.next,
            disabled: transferAddress == '' || transferMoney == '',
            onPressed: onConfirm,
          ),
        ),
      ),
    );
  }
}
