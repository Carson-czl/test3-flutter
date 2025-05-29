import 'package:flutter/material.dart';

/// 自定义按钮
/// ```
/// @param {BuildContext} - context 如果context存在：左边有返回按钮，反之默认按钮
/// @param {String} title - 标题
/// @param {double} height - 按钮高度
/// @param {double} fontSize - 按钮字体大小
/// @param {Widget} iconChild - icon节点
/// @param {Color} backgroundColor - 背景色
/// @param {Color} disabledBackgroundColor - 禁用背景色
/// @param {Color} fontColor - 字体颜色
/// @param {Color} disabledFontColor - 禁用字体色
/// @param {bool} loading - loading
/// @param {bool} disabled - 是否禁用
/// @param {BorderRadius} borderRadius - 按钮圆边
/// ```
Widget customButton(
  BuildContext context, {
  required void Function() onPressed,
  required String title,
  double width = double.maxFinite,
  double height = 50,
  double fontSize = 16,
  Widget? iconChild,
  Color? backgroundColor,
  Color? disabledBackgroundColor,
  Color? fontColor,
  Color? disabledFontColor,
  bool? loading,
  bool? disabled,
  BorderRadius? borderRadius,
}) {
  backgroundColor ??= const Color(0xff007fff);
  disabledBackgroundColor ??= const Color(0xff90c4f8);
  fontColor ??= Colors.white;
  disabledFontColor ??= Colors.white;
  borderRadius ??= BorderRadius.circular(5);

  if (loading == true) {
    iconChild = SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(fontColor),
        strokeWidth: 2,
      ),
    );
  }

  return Ink(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: disabled == true ? disabledBackgroundColor : backgroundColor,
      borderRadius: borderRadius,
    ),
    child: InkWell(
      onTap: disabled == true ? null : onPressed,
      borderRadius: borderRadius,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Offstage(
            offstage: iconChild == null,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: iconChild,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabled == true ? disabledFontColor : fontColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    ),
  );
}
