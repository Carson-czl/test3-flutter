import 'package:flutter/material.dart';

import 'list_view_status.dart';

class MyEmpty extends StatelessWidget {
  final ListViewStatusEnum status;
  final Color iconColor;
  final double iconSize;
  final double width;
  final double height;
  final void Function()? onRefresh;
  final String noDataText;
  final String errorText;

  /// 空列表占用组件
  /// ```
  /// @param {ListViewStatusEnum} status - 展示状态
  /// @param {Color} iconColor -
  /// @param {double} iconSize -
  /// @param {double} width -
  /// @param {double} height -
  /// @param {Function} onRefresh - 存在则出现按钮一般用于异常
  /// @param {String} noDataText - 没有数据的文字
  /// @param {String} errorText - 错误文字
  /// ```
  const MyEmpty({
    super.key,
    required this.status,
    this.iconColor = Colors.grey,
    this.iconSize = 70,
    this.width = double.infinity,
    this.height = double.infinity,
    this.onRefresh,
    this.noDataText = "暂无数据！",
    this.errorText = "网络异常！",
  });

  /// 图标
  Widget _iconRender(BuildContext context) {
    switch (status) {
      case ListViewStatusEnum.loading:
      case ListViewStatusEnum.refresh:
        return const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            Color(0xff79b0ff),
          ),
        );
      case ListViewStatusEnum.complete:
      case ListViewStatusEnum.noMore:
        return Center(
          child: Icon(
            Icons.no_sim_rounded,
            size: iconSize,
            color: iconColor,
          ),
        );
      case ListViewStatusEnum.error:
        return Center(
          child: Icon(
            Icons.network_check_outlined,
            size: iconSize,
            color: iconColor,
          ),
        );
      default:
        return SizedBox.fromSize();
    }
  }

  /// 文字
  Widget _textRender(BuildContext context) {
    String text = "";
    switch (status) {
      case ListViewStatusEnum.loading:
        text = "加载中...";
        break;
      case ListViewStatusEnum.complete:
      case ListViewStatusEnum.noMore:
        text = noDataText;
        break;
      case ListViewStatusEnum.error:
        text = errorText;
        break;
      default:
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: iconColor,
        ),
      ),
    );
  }

  /// 按钮
  Widget _btnRender(BuildContext context) {
    if (onRefresh != null && status == ListViewStatusEnum.error) {
      return ElevatedButton(
        onPressed: onRefresh,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xff007fff)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        child: const Text(
          '刷新一下',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _iconRender(context),
          _textRender(context),
          _btnRender(context),
        ],
      ),
    );
  }
}
