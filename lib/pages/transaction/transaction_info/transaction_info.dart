import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/list_view_status/empty.dart';
import 'package:web_wallet/components/list_view_status/list_view_status.dart';
import 'package:web_wallet/config/global_config.dart';
import '/common/widget/custom_app_bar.dart';

class TransactionInfoPageParam {
  String walletName;
  TransactionInfoPageParam({
    this.walletName = '',
  });
}

class TransactionInfoPage extends StatefulWidget {
  const TransactionInfoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TransactionInfoPageState();
  }
}

class _TransactionInfoPageState extends State<TransactionInfoPage> {
  String walletName = '';

  final ListViewStatus _listStatus = ListViewStatus();

  Future<void> _handleRefresh() async {
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var routeInfo = ModalRoute.of(context);
      if (routeInfo != null) {
        var arguments =
            routeInfo.settings.arguments as TransactionInfoPageParam?;
        if (arguments != null) {
          setState(() {
            walletName = arguments.walletName;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: customAppBar(
          context,
          title: walletName,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55), // TabBar 高度
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:
                        ThemeScheme.color(const Color(0xffededed)), // 设置顶部边框颜色
                    width: 10, // 设置边框宽度
                  ),
                ),
              ),
              child: TabBar(
                indicatorColor: ThemeScheme.getBlack(),
                labelColor: ThemeScheme.getBlack(),
                unselectedLabelColor: ThemeScheme.getBlack(),
                labelPadding: const EdgeInsets.all(0),
                dividerColor: ThemeScheme.color(const Color(0xffededed)),
                tabs: [
                  Tab(text: context.l10n.all),
                  Tab(text: context.l10n.transferOut),
                  Tab(text: context.l10n.transferIn),
                  Tab(text: context.l10n.failed),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: ThemeScheme.getWhiteBackground(),
        body: TabBarView(
          children: <Widget>[
            MyEmpty(
              status: _listStatus.listStatus,
              onRefresh: _listStatus.listStatus != ListViewStatusEnum.error
                  ? null
                  : _handleRefresh,
            ),
            MyEmpty(
              status: _listStatus.listStatus,
              onRefresh: _listStatus.listStatus != ListViewStatusEnum.error
                  ? null
                  : _handleRefresh,
            ),
            MyEmpty(
              status: _listStatus.listStatus,
              onRefresh: _listStatus.listStatus != ListViewStatusEnum.error
                  ? null
                  : _handleRefresh,
            ),
            MyEmpty(
              status: _listStatus.listStatus,
              onRefresh: _listStatus.listStatus != ListViewStatusEnum.error
                  ? null
                  : _handleRefresh,
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Material(
          color: ThemeScheme.getWhiteBackground(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: customButton(
                    context,
                    onPressed: () =>
                        Navigator.pushNamed(context, "/collectPayment"),
                    title: context.l10n.receive,
                    backgroundColor: const Color(0xFF1ECED4),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: customButton(
                    context,
                    onPressed: () =>
                        Navigator.pushNamed(context, "/walletCreate"),
                    title: context.l10n.transfer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
