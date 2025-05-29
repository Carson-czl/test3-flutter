import 'package:flutter/material.dart';
import 'package:flutter_scankit/flutter_scankit.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/common/utils/common.dart';
import 'package:web_wallet/common/widget/custom_action_sheet.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_icons.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/app_input/app_input.dart';
import 'package:web_wallet/config/app_localizations.dart';
import 'package:web_wallet/config/app_wallet_info.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/pages/transaction/transaction_info/transaction_info.dart';
import 'package:web_wallet/pages/transaction/transfer_accounts/transfer_accounts.dart';
import 'package:web_wallet/stores/app_settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final List<Map<String, dynamic>> currencyAddressList = [
    {"type": "TRX"},
    {"type": "USDT"},
    {"type": "USDT"},
    {"type": "USDT"},
    {"type": "USDT"},
    {"type": "USDT"},
    {"type": "USDT"},
    {"type": "USDT"},
  ];
  ValueNotifier<String> searchName =
      ValueNotifier(""); // 确保响应式字符串对付showModalBottomSheet组件不更新的问题

  List<Map<String, dynamic>> get transferList {
    if (searchName.value == '') {
      return currencyAddressList;
    } else {
      List<Map<String, dynamic>> res = currencyAddressList.where((value) {
        // 不区分大小写模糊查询
        return value["type"]
            .toLowerCase()
            .contains(searchName.value.toLowerCase());
      }).toList();
      return res;
    }
  }

  String currentAddress = 'sdasdsddsdsddsdsds';

  final ScrollController _scrollController = ScrollController();
  late ScanKit scanKit;
  bool _showTopGradient = false;
  bool _showBottomGradient = true;

  @override
  void initState() {
    scanKit = ScanKit();
    scanKit.onResult.listen((val) {
      print("scanning result:$val");
      setState(() {
        // test = val.originalValue;
      });
    });

    _scrollController.addListener(_updateGradientVisibility);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateGradientVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  // 监听滚动判断渐变色显示
  void _updateGradientVisibility() {
    final double offset = _scrollController.offset;
    final double maxOffset = _scrollController.position.maxScrollExtent;

    setState(() {
      _showTopGradient = offset > 0;
      _showBottomGradient = offset < maxOffset;
    });
  }

  Future<void> handleRefresh() async {
    setState(() {
      // _listStatus.listStatus = ListViewStatusEnum.refresh;
    });
    // _listStatus.page = 1;
    // await Future.delayed(Duration(milliseconds: 200)); // 延迟
    // await _getListData();
    setState(() {
      // _listStatus.listStatus = ListViewStatusEnum.noMore;
    });
  }

  // 展示转账功能
  void showTransferAccounts() {
    CustomActionSheet.dragBottomSheet(
      context,
      title: context.l10n.selectAssetsType,
      height: MediaQuery.of(context).size.height - 80,
      isScrollControlled: true,
      backgroundColor: ThemeScheme.getWhiteBackground(),
      children: <Widget>[
        Text(
          "Tron",
          style: TextStyle(
            color: ThemeScheme.getLightBlack(),
            fontSize: 12,
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: searchName,
            builder: (context, content, _) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: ThemeScheme.color(const Color(0xfffafbfd)),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ThemeScheme.color(const Color(0xffededed)),
                        width: 1,
                      ),
                    ),
                    child: AppInput(
                      type: AppInputType.clear,
                      leftIconData: Icons.search,
                      hintText: context.l10n.searchTokenName,
                      onChanged: (value) => {searchName.value = value},
                    ),
                  ),
                  Expanded(
                    child: currencyList(
                      transferList,
                      onTap: (index) => {
                        Navigator.pushNamed(
                          context,
                          "/transferAccounts",
                          arguments: TransferAccountsPageParam(
                            walletName: transferList[index]['type'],
                          ),
                        )
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  /// 当前钱包余额
  Widget currentWalletInfo() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff377ff6),
      ),
      child: Consumer<AppSettingsStore>(
        builder: (context, store, child) {
          String? currencyStr =
              AppLocalizationsConfig.currencyUnitInfo[store.appCurrency];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppWalletInfo.getWalletInfo('TRX').name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(
                        context,
                        "/walletSettings",
                        arguments: 1,
                      )
                    },
                    child: const Icon(
                      Icons.more_horiz_sharp,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              GestureDetector(
                onTap: () => Common.clipboard(currentAddress),
                child: Row(
                  children: <Widget>[
                    Text(
                      store.appHideBalance ? "************" : currentAddress,
                      style: const TextStyle(
                        color: Color.fromARGB(150, 250, 250, 250),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.copy,
                      size: 12,
                      color: Color.fromARGB(150, 250, 250, 250),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(top: 3),
                child: GestureDetector(
                  onTap: () => store.setHideBalance(!store.appHideBalance),
                  child: Text(
                    "$currencyStr ${store.appHideBalance ? "****" : AppLocalizationsConfig.currencyCalc(0)}",
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget walletBtnList() {
    List<Map<String, dynamic>> listItem = [
      {
        "icon": CustomIcons.transferAccounts,
        "title": context.l10n.transfer,
        "url": "transferAccounts",
      },
      {
        "icon": CustomIcons.collectPayment,
        "title": context.l10n.receive,
        "url": "/collectPayment",
      },
      {
        "icon": Icons.add,
        "title": "能量租赁",
        "url": "",
      },
      {
        "icon": Icons.add,
        "title": "交易",
        "url": "",
      },
      {
        "icon": Icons.add,
        "title": "跨链",
        "url": "",
      }
    ];
    List<Widget> listNode = [];
    for (var i = 0; i < listItem.length; i++) {
      var itemData = listItem[i];
      if (i >= 1) {
        listNode.add(Container(
          width: 1,
          height: 20,
          color: ThemeScheme.color(const Color(0xffededed)),
        ));
      }
      listNode.add(
        InkWell(
          onTap: () {
            String url = itemData['url'];
            if (url != '') {
              if (url == 'transferAccounts') {
                showTransferAccounts();
              } else {
                Navigator.pushNamed(context, url);
              }
            }
          },
          child: SizedBox(
            width: 90,
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  itemData['icon'],
                  size: 25,
                  color: ThemeScheme.getBlack(),
                ),
                const SizedBox(height: 5),
                Text(
                  itemData["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeScheme.getBlack(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: ThemeScheme.color(const Color(0xffededed)),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: listNode,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _showTopGradient ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        ThemeScheme.getWhiteBackground().withOpacity(0.8),
                        Colors.white.withOpacity(0)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _showBottomGradient ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        ThemeScheme.getWhiteBackground().withOpacity(0.8),
                        Colors.white.withOpacity(0)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 展示币种列表
  Widget currencyList(List<Map<String, dynamic>> list,
      {required void Function(int) onTap}) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> itemData = list[index];

        return InkWell(
          onTap: () => onTap(index),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Image.asset(
                  "assets/images/wallet_network/tron.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: ThemeScheme.color(const Color(0xffededed)),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        itemData['type'],
                        style: TextStyle(
                          color: ThemeScheme.getBlack(),
                          fontSize: 17,
                        ),
                      ),
                      Consumer<AppSettingsStore>(
                        builder: (context, store, child) {
                          String? currencyStr = AppLocalizationsConfig
                              .currencyUnitInfo[store.appCurrency];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                store.appHideBalance ? "****" : "0",
                                style: TextStyle(
                                  color: ThemeScheme.getBlack(),
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "$currencyStr ${store.appHideBalance ? "****" : AppLocalizationsConfig.currencyCalc(0)}",
                                style: TextStyle(
                                  color: ThemeScheme.getLightBlack(),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "Tron",
        leadingShow: false,
        leadingBtn: IconButton(
          onPressed: () {},
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.notes_rounded,
            size: 30,
            color: ThemeScheme.getBlack(),
          ),
        ),
        rightBtn: <Widget>[
          IconButton(
            onPressed: () => Common.startScan(scanKit),
            highlightColor: Colors.transparent,
            icon: Icon(
              CustomIcons.scan,
              size: 20,
              color: ThemeScheme.getBlack(),
            ),
          ),
        ],
      ),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          currentWalletInfo(),
          walletBtnList(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: handleRefresh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      context.l10n.assets,
                      style: TextStyle(
                        color: ThemeScheme.getBlack(),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: currencyList(
                      currencyAddressList,
                      onTap: (index) => {
                        Navigator.pushNamed(
                          context,
                          "/transactionInfo",
                          arguments: TransactionInfoPageParam(
                            walletName: currencyAddressList[index]['type'],
                          ),
                        )
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
