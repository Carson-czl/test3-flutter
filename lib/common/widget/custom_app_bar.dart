import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/common/widget/theme_scheme.dart';

/// 通用appBar
/// ```
/// @param {String} title - 标题
/// @param {Color} titleColor - 标题颜色包含导航返回按钮
/// @param {List<Widget>} rightBtn - 右侧
/// @param {PreferredSizeWidget} bottom - 导航底部内容一般放tabBar
/// @param {Brightness} brightness - 与状态栏文字反向类型
/// @param {double} borderWidth - 下划线
/// @param {Color} borderColor - 下划线颜色
/// @param {double} elevation - 阴影 0=去除
/// @param {Color} shadowColor - 阴影颜色
/// @param {Color} backgroundColor - 导航条背景色
/// @param {bool} leadingShow - 返回按钮是否显示
/// @param {Widget} leadingBtn - 左侧按钮(需要显示必须设置leadingShow=false)
/// ```
AppBar customAppBar(
  BuildContext context, {
  String title = '',
  Color? titleColor,
  List<Widget>? rightBtn,
  PreferredSizeWidget? bottom,
  Brightness? brightness,
  double borderWidth = 0,
  Color? borderColor,
  double elevation = 0,
  Color? shadowColor,
  Color? backgroundColor,
  bool leadingShow = true,
  Widget? leadingBtn,
}) {
  // 返回图标
  Widget? leading = leadingBtn;
  if (leadingShow) {
    leading = InkWell(
      onTap: () => Navigator.pop(context),
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: titleColor ?? ThemeScheme.getBlack(),
        size: 20,
      ),
    );
  }

  if (bottom == null && borderWidth > 0) {
    bottom = PreferredSize(
      preferredSize: Size.fromHeight(borderWidth),
      child: Divider(
        color:
            borderColor ?? ThemeScheme.color(const Color(0xffeeeeee)), // 下划线的颜色
        thickness: borderWidth, // 下划线的高度
        height: 0,
      ),
    );
  }
  return AppBar(
    /// 涉及到返回按钮和状态栏颜色会相反的 会冲突:[SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light)]
    systemOverlayStyle: brightness != null
        ? SystemUiOverlayStyle(
            //   // 设置状态栏的背景颜色
            //   // statusBarColor: Colors.white,
            //   // 状态栏的文字的颜色
            statusBarIconBrightness: brightness,
          )
        : null,
    centerTitle: true, // 标题居中
    elevation: elevation,
    shadowColor: shadowColor,
    leading: leading,
    automaticallyImplyLeading: leadingShow, // leading=null是去除不掉需要设置该属性
    backgroundColor: backgroundColor,
    actions: rightBtn,
    bottom: bottom,
    title: Text(
      title,
      style: TextStyle(
        color: titleColor ?? ThemeScheme.getBlack(),
        fontSize: 16,
      ),
    ),
  );
}
