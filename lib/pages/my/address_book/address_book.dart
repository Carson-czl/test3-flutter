import 'package:flutter/material.dart';
import 'package:web_wallet/common/utils/common.dart';
import 'package:web_wallet/common/widget/custom_action_sheet.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/list_view_status/empty.dart';
import 'package:web_wallet/components/list_view_status/list_view_status.dart';
import 'package:web_wallet/config/app_wallet_info.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/pages/my/address_book/address_book_edit.dart';

class AddressBookPage extends StatefulWidget {
  const AddressBookPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddressBookPageState();
  }
}

class _AddressBookPageState extends State<AddressBookPage> {
  bool isSelect = false;

  final List<Map> listViewData = [
    {
      "id": 1,
      "type": "ETH",
      "title": "测试地址",
      "address": "0xA8d8FD6C4285f86b84A230d7c3dC1dB3Df79c299",
      "dec": "描述地址"
    },
    {
      "id": 2,
      "type": "ETH",
      "title": "测试地址",
      "address": "0xA8d8FD6C4285f86bsdA230d7c3dC1dB3Df79c292",
      "dec": "描述地址"
    }
  ];

  final ListViewStatus listStatus = ListViewStatus();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var routeInfo = ModalRoute.of(context);
      if (routeInfo != null) {
        var arguments = routeInfo.settings.arguments as int?;
        if (arguments != null) {
          setState(() {
            isSelect = true;
          });
        }
      }
    });
    listStatus.listStatus = ListViewStatusEnum.noMore;

    super.initState();
  }

  Future<void> handleRefresh() async {
    setState(() {
      // listStatus.listStatus = ListViewStatusEnum.refresh;
    });
    // listStatus.page = 1;
    // await Future.delayed(Duration(milliseconds: 200)); // 延迟
    // await _getListData();
    setState(() {
      // listStatus.listStatus = ListViewStatusEnum.noMore;
    });
  }

  void showSelect(int index) {
    CustomActionSheet.selectorList(
      context,
      list: [context.l10n.copyAddress, context.l10n.edit],
      onTap: (position) {
        switch (position) {
          case 0:
            Common.clipboard(listViewData[index]['address']);
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddressBookEditPage(),
              ),
            );
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.addressBook,
        rightBtn: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddressBookEditPage(),
              ),
            ),
            highlightColor: Colors.transparent,
            icon: Icon(
              Icons.add,
              size: 30,
              color: ThemeScheme.getBlack(),
            ),
          )
        ],
      ),
      backgroundColor: listViewData.isNotEmpty
          ? ThemeScheme.color(const Color(0xFFF0F1F3))
          : ThemeScheme.getWhiteBackground(),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: listViewData.isNotEmpty
            ? ListView.builder(
                itemCount: listViewData.length,
                itemBuilder: (context, index) {
                  Map itemData = listViewData[index];
                  return Ink(
                    color: ThemeScheme.getWhiteBackground(),
                    child: InkWell(
                      onTap: () {
                        if (isSelect) {
                          Navigator.pop(context, itemData["address"]);
                        } else {
                          showSelect(index);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppWalletInfo.getWalletIcon(itemData['type']),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    itemData["title"],
                                    style: TextStyle(
                                      color: ThemeScheme.getLightBlack(),
                                    ),
                                  ),
                                  Text(
                                    itemData["address"],
                                    style: TextStyle(
                                      color: ThemeScheme.getBlack(),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    itemData["dec"],
                                    style: TextStyle(
                                      color: ThemeScheme.getLightBlack(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : MyEmpty(
                status: listStatus.listStatus,
                onRefresh: listStatus.listStatus != ListViewStatusEnum.error
                    ? null
                    : handleRefresh,
              ),
      ),
    );
  }
}
