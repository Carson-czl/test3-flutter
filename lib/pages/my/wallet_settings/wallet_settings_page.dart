import 'package:flutter/material.dart';
import 'package:web_wallet/common/utils/common.dart';
import 'package:web_wallet/common/widget/custom_action_sheet.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/custom_dialog.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/app_input/app_input.dart';
import 'package:web_wallet/components/my_list_item/my_list_item.dart';
import 'package:web_wallet/config/app_wallet_info.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/pages/my/wallet_settings/password_hint_page.dart';

class WalletSettingsPage extends StatefulWidget {
  const WalletSettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WalletSettingsPageState();
  }
}

class _WalletSettingsPageState extends State<WalletSettingsPage> {
  String walletAccountStr = "test123A";
  String editAccountStr = "";

  String walletKey = "im14x5S1HrdNCiF96j7Z3pZYHrujStyLXpXtE8f";

  bool isBackups = false;

  List<Map> walletList = [
    {
      "type": "ETH",
      "account": "Account 01",
      "address": "xxxxxxxxx",
    },
    {
      "type": "TRX",
      "account": "Account 02",
      "address": "xxxxxxxxx",
    }
  ];

  String walletPassword = "";

  List<String> accountList = ["ETH", "TRX"];

  ValueNotifier<List<String>> selectAddAccount = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onAddAccount() {
    Navigator.pop(context);
  }

  /// 弹窗输入钱包账户名称
  void editAccountName() {
    setState(() {
      editAccountStr = "";
    });
    CustomDialog.customContent(
      context,
      title: context.l10n.changeWalletName,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: ThemeScheme.color(const Color(0xffededed)),
              ),
            ),
          ),
          child: AppInput(
            maxLength: 12,
            isFocus: true,
            hintText: walletAccountStr,
            type: AppInputType.clear,
            onChanged: (value) {
              setState(() {
                editAccountStr = value;
              });
            },
          ),
        ),
      ),
      onSuccess: () {
        print(editAccountStr);
      },
    );
  }

  /// 弹窗输入钱包密码
  void showPassword(String type) {
    setState(() {
      walletPassword = "";
    });
    CustomDialog.customContent(
      context,
      title: context.l10n.pleaseEnterWalletPassword,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: ThemeScheme.color(const Color(0xffededed)),
              ),
            ),
          ),
          child: AppInput(
            maxLength: 20,
            isFocus: true,
            hintText: context.l10n.password,
            type: AppInputType.password,
            onChanged: (value) {
              setState(() {
                walletPassword = value;
              });
            },
          ),
        ),
      ),
      onSuccess: () {
        if (type == 'backups') {
          Navigator.pushNamed(context, "/walletBackups");
        } else if (type == 'delete') {
          Navigator.pop(context);
        }
      },
    );
  }

  /// 展示添加账户弹窗
  void showAddWalletAccount() {
    selectAddAccount.value = [];
    CustomActionSheet.dragBottomSheet(
      context,
      title: context.l10n.addAccount,
      height: MediaQuery.of(context).size.height - 80,
      isScrollControlled: true,
      backgroundColor: ThemeScheme.color(const Color(0xfff0f1f3)),
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "选择你需要的区块链网络或特定账户类型，完成相应账户的添加。",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: ThemeScheme.getLightBlack(),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "什么是账户？",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff007fff),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  context.l10n.popular,
                  style: TextStyle(
                    fontSize: 14,
                    color: ThemeScheme.getLightBlack(),
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 140,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: accountList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        height: double.maxFinite,
                        margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                        padding: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: ThemeScheme.getWhiteBackground(),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: <Widget>[
                            AppWalletInfo.getWalletIcon(
                              accountList[index],
                              marginRight: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                AppWalletInfo.getWalletInfo(accountList[index])
                                    .name,
                                style: TextStyle(
                                  color: ThemeScheme.getLightBlack(),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: selectAddAccount,
                              builder: (context, content, _) {
                                if (content.contains(accountList[index])) {
                                  return GestureDetector(
                                    onTap: () {
                                      selectAddAccount.value =
                                          List.from(content)
                                            ..remove(accountList[index]);
                                    },
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Color(0xff007fff),
                                      size: 22,
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      selectAddAccount.value =
                                          List.from(content)
                                            ..add(accountList[index]);
                                    },
                                    child: const Icon(
                                      Icons.add_circle_outline_sharp,
                                      color: Color(0xff007fff),
                                      size: 22,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Material(
          color: ThemeScheme.color(const Color(0xfff0f1f3)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ValueListenableBuilder(
              valueListenable: selectAddAccount,
              builder: (context, content, _) {
                return Column(
                  children: <Widget>[
                    Text(
                      content.isEmpty
                          ? context.l10n.pleaseSelectAnAccount
                          : context.l10n.addingCountAccountToAccount(
                              'aa', content.length),
                      style: TextStyle(
                        color: ThemeScheme.getLightBlack(),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    customButton(
                      context,
                      onPressed: onAddAccount,
                      title: context.l10n.confirm,
                      disabled: content.isEmpty,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget walletAccountList() {
    if (walletList.isNotEmpty) {
      List<Widget> nodeList = [];
      for (var i = 0; i < walletList.length; i++) {
        Map item = walletList[i];
        nodeList.add(Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Ink(
            decoration: BoxDecoration(
              color: ThemeScheme.getWhiteBackground(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, "/accountDetails"),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  children: <Widget>[
                    AppWalletInfo.getWalletIcon(item['type']),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item["account"],
                            style: TextStyle(
                              fontSize: 16,
                              color: ThemeScheme.getBlack(),
                            ),
                          ),
                          Text(
                            item["address"],
                            style: TextStyle(
                              fontSize: 14,
                              color: ThemeScheme.getLightBlack(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }
      // https://api.flutter.dev/flutter/material/ReorderableListView-class.html
      // ReorderableListView拖拽列表
      return Column(
        children: nodeList,
      );
    } else {
      return Ink(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: ThemeScheme.color(const Color(0xffe4e6eb)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => {},
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Text(
              "使用之前，先添加账户",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: ThemeScheme.getLightBlack(),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.walletSettings,
        backgroundColor: ThemeScheme.color(const Color(0xFFF0F1F3)),
        rightBtn: <Widget>[
          TextButton(
            onPressed: () => showPassword('delete'),
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                return Colors.transparent;
              }),
            ),
            child: Text(
              context.l10n.remove,
              style: const TextStyle(
                  color: Color(0xffea766d), fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: <Widget>[
            Container(
              width: 90,
              height: 90,
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              decoration: BoxDecoration(
                color: ThemeScheme.getWhite(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.import_contacts,
                  color: ThemeScheme.getBlack(),
                  size: 40,
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: editAccountName,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      walletAccountStr,
                      style: TextStyle(
                        fontSize: 20,
                        color: ThemeScheme.getBlack(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.border_color_outlined,
                      color: ThemeScheme.getBlack(),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: ThemeScheme.getWhiteBackground(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: Row(
                      children: <Widget>[
                        Text(
                          context.l10n.walletIdentifier,
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeScheme.getBlack(),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Common.clipboard(walletKey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    walletKey,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ThemeScheme.getLightBlack(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.copy,
                                  color: ThemeScheme.getLightBlack(),
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyListItem(
                    title: context.l10n.createTime,
                    extra: "2024-11-04",
                    rightIconShow: false,
                    borderWidth: 0,
                  ),
                   MyListItem(
                    title: context.l10n.source,
                    extra: "通过助记词创建",
                    rightIconShow: false,
                    borderWidth: 0,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: Column(
                children: <Widget>[
                  MyListItem(
                    onPressed: isBackups ? null : () => showPassword('backups'),
                    title: context.l10n.backupWallet,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    renderExtra: isBackups
                        ? Text(
                            context.l10n.completed,
                            style: const TextStyle(
                              color: Color(0xff7cdea9),
                            ),
                          )
                        : Text(
                            context.l10n.notBackedUp,
                            style: const TextStyle(
                              color: Color(0xffea766d),
                            ),
                          ),
                  ),
                  MyListItem(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/forgotPassword"),
                    title: context.l10n.forgotPassword,
                  ),
                  MyListItem(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordHintPage(),
                        ),
                      )
                    },
                    title: context.l10n.passwordHint,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    borderWidth: 0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  context.l10n.account,
                  style: TextStyle(
                    color: ThemeScheme.getLightBlack(),
                  ),
                ),
                GestureDetector(
                  onTap: showAddWalletAccount,
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.add_circle,
                        color: Color(0xff007fff),
                        size: 16,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        context.l10n.addAccount,
                        style: const TextStyle(color: Color(0xff007fff)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            walletAccountList(),
          ],
        ),
      ),
    );
  }
}
