import 'package:flutter/cupertino.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'list_view_status.dart';

class MyLoadMore extends StatelessWidget {
  final ListViewStatusEnum status;
  final void Function()? onClick;

  ///列表页脚组件
  ///```
  /// @param {ListViewStatusEnum} status
  /// @param {Function} onClick
  ///```
  const MyLoadMore({
    super.key,
    required this.status,
    this.onClick,
  });

  String getText() {
    String str = '';
    switch (status) {
      case ListViewStatusEnum.loading:
        str = '努力加载中';
        break;
      case ListViewStatusEnum.noMore:
        str = '— 没有更多 —';
        break;
      case ListViewStatusEnum.complete:
        str = '— 点击或上拉加载更多 —';
        break;
      case ListViewStatusEnum.error:
        str = '— 网络异常点击重新请求 —';
        break;
      default:
    }
    return str;
  }

  Widget _loadIcon() {
    if (status == ListViewStatusEnum.loading) {
      return const Padding(
        padding: EdgeInsets.only(right: 10),
        child: CupertinoActivityIndicator(radius: 10),
      );
    } else {
      return SizedBox.fromSize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loadIcon(),
            Text(
              getText(),
              style: TextStyle(
                color: ThemeScheme.getLightBlack(),
                fontSize: 12.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
