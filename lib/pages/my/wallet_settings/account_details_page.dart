import 'package:flutter/material.dart';
import 'package:web_wallet/common/utils/common.dart';
import 'package:web_wallet/common/widget/custom_action_sheet.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_dialog.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/app_input/app_input.dart';
import 'package:web_wallet/components/my_list_item/my_list_item.dart';
import 'package:web_wallet/config/app_wallet_info.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/pages/my/private_key_export/private_key_export_page.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountDetailsPageState();
  }
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  String walletKey = "im14x5S1HrdNCiF96j7Z3pZYHrujStyLXpXtE8f";
  String walletAccountNameStr = "account 01";
  String editWalletAccountNameStr = "account 01";
  String walletPassword = "";

  ValueNotifier<List<String>> tagList = ValueNotifier([
    'Tron',
  ]);

  ValueNotifier<String> newTagStr =
      ValueNotifier(""); // 确保响应式字符串对付showModalBottomSheet组件不更新的问题
  final newTagKey = GlobalKey<AppInputState>();

  void onDeleteAccount() {
    CustomDialog.confirm(
      context,
      title: '确认移除？',
      content: "你可以在钱包管理中重新添加此账户。",
      onSuccess: () {},
    );
  }

  /// 弹窗输入钱包密码
  void showPassword() {
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
      onSuccess: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PrivateKeyExportPage(),
        ),
      ),
    );
  }

  void onEditAccountName() {
    setState(() {
      editWalletAccountNameStr = "";
    });
    CustomDialog.customContent(
      context,
      title: "账户名",
      // title: "Account Name",
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Text(
              "输入的账户名称不超过12个字符。",
              // "Enter a account name within 12 characters.",
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
                fontSize: 12,
              ),
            ),
            Container(
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
                hintText: walletAccountNameStr,
                type: AppInputType.clear,
                onChanged: (value) {
                  setState(() {
                    editWalletAccountNameStr = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      onSuccess: () {
        setState(() {
          walletAccountNameStr = editWalletAccountNameStr;
        });
      },
    );
  }

  /// 编辑账户标签
  void showAccountTag() {
    CustomActionSheet.dragBottomSheet(
      context,
      title: context.l10n.editAccountTag,
      height: MediaQuery.of(context).size.height - 80,
      isScrollControlled: true,
      backgroundColor: ThemeScheme.color(const Color(0xFFF0F1F3)),
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.l10n.tag,
                  style: TextStyle(
                    color: ThemeScheme.getLightBlack(),
                  ),
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<List<String>>(
                  valueListenable: tagList,
                  builder: (context, content, _) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: content.map(
                        (value) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: ThemeScheme.getWhiteBackground(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 12,
                                color: ThemeScheme.getBlack(),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.newTag,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: ThemeScheme.getLightBlack(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: ThemeScheme.getWhiteBackground(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: newTagStr,
                    builder: (context, content, _) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: AppInput(
                              key: newTagKey,
                              maxLength: 12,
                              hintText: context.l10n.pleaseEnterTagName,
                              onChanged: (value) => {newTagStr.value = value},
                            ),
                          ),
                          Opacity(
                            opacity: content == '' ? 0 : 1,
                            child: GestureDetector(
                              onTap: () {
                                if (content != '') {
                                  tagList.value = List.from(tagList.value)
                                    ..add(content);
                                  setState(() {
                                    newTagStr.value = '';
                                    newTagKey.currentState?.controller.text =
                                        '';
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                context.l10n.add,
                                style: const TextStyle(
                                  color: Color(0xff007fff),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.accountDetails,
        backgroundColor: ThemeScheme.color(const Color(0xFFF0F1F3)),
        rightBtn: <Widget>[
          TextButton(
            onPressed: onDeleteAccount,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Ink(
                decoration: BoxDecoration(
                  color: ThemeScheme.getWhiteBackground(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: onEditAccountName,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        AppWalletInfo.getWalletIcon('ETH'),
                        Expanded(
                          child: Text(
                            walletAccountNameStr,
                            style: TextStyle(
                              fontSize: 16,
                              color: ThemeScheme.getBlack(),
                            ),
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
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 19,
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: ThemeScheme.getWhiteBackground(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Common.clipboard(walletKey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          context.l10n.address,
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeScheme.getBlack(),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                walletKey,
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
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                    color: ThemeScheme.color(const Color(0xFFF0F1F3)),
                  ),
                  GestureDetector(
                    onTap: showAccountTag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              context.l10n.tag,
                              style: TextStyle(
                                fontSize: 16,
                                color: ThemeScheme.getBlack(),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  context.l10n.manage,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ThemeScheme.getLightBlack(),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: ThemeScheme.getLightBlack(),
                                  size: 16,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: tagList.value.map((value) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    ThemeScheme.color(const Color(0xffededed)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ThemeScheme.getLightBlack(),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MyListItem(
              title: context.l10n.exportPrivateKey,
              borderWidth: 0,
              borderRadius: BorderRadius.circular(15),
              onPressed: showPassword,
            ),
          ],
        ),
      ),
    );
  }
}
