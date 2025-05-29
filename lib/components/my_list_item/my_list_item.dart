import 'package:flutter/material.dart';
import '/common/widget/theme_scheme.dart';

class MyListItem extends StatelessWidget {
  final String title;
  final FontWeight? titleWeight;
  final double height;
  final String leftPicture;
  final double leftPictureSize;
  final Widget? leftWidget;
  final IconData? leftIconData;
  final Color? leftIconColor;
  final double? leftIconSize;
  final String extra;
  final Widget? content;
  final String label;
  final Widget? renderExtra;
  final bool rightIconShow;
  final IconData? rightIconData;
  final Color? rightIconColor;
  final double? rightIconSize;
  final Border? border;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final Color? bgColor;
  final void Function()? onPressed;

  /// MyListItem 列表菜单
  /// ```
  /// @param {String} title - 标题
  /// @param {String} titleWeight - 标题是否加粗
  /// @param {double} height - 高度
  /// @param {String} leftPicture - 左侧图片优先级大于icon
  /// @param {String} leftPictureSize
  /// @param {Widget} leftWidget - 左侧自定义渲染
  /// @param {IconData} leftIconData - 左侧icon
  /// @param {Color} leftIconColor - 左侧icon颜色
  /// @param {double} leftIconSize - 左侧icon大小
  /// @param {String} content - 标题隔壁自定义内容
  /// @param {String} extra - 右侧文本
  /// @param {String} label - 描述文本
  /// @param {Widget} renderExtra - 右侧渲染内容优先级高于文本
  /// @param {IconData} rightIconShow - 右侧icon是否显示默认显示
  /// @param {IconData} rightIconData - 右侧icon
  /// @param {Color} rightIconColor - 右侧icon颜色
  /// @param {double} rightIconSize - 右侧icon大小
  /// @param {Border} border
  /// @param {double} borderWidth
  /// @param {BorderRadius} borderRadius
  /// @param {Color} bgColor
  /// @param {Function} onPressed - 点击回调
  /// ```
  const MyListItem({
    super.key,
    this.title = '',
    this.titleWeight,
    this.height = 60,
    this.leftPicture = '',
    this.leftPictureSize = 30,
    this.leftWidget,
    this.leftIconData,
    this.leftIconColor,
    this.leftIconSize,
    this.content,
    this.extra = "",
    this.label = "",
    this.renderExtra,
    this.rightIconShow = true,
    this.rightIconData,
    this.rightIconColor,
    this.rightIconSize,
    this.border,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.bgColor,
    this.onPressed,
  });

  Widget renderLeftIcon(BuildContext context) {
    if (leftPicture != "") {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Image.asset(
          leftPicture,
          width: leftPictureSize,
          height: leftPictureSize,
        ),
      );
    } else if (leftIconData != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          leftIconData,
          size: leftIconSize ?? 20,
          color: leftIconColor ?? ThemeScheme.getLightBlack(),
        ),
      );
    } else {
      return leftWidget ?? const SizedBox.shrink();
    }
  }

  Widget renderContext(BuildContext context) {
    Color? itemBgColor = bgColor ?? ThemeScheme.getWhiteBackground();
    if (onPressed != null) {
      itemBgColor = null; // 如果有点击事件则取消掉颜色
    }
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: itemBgColor, // 设置了这里颜色点击效果就无法显示
        borderRadius: borderRadius,
        border: border ??
            Border(
              bottom: borderWidth > 0
                  ? BorderSide(
                      width: borderWidth,
                      color: ThemeScheme.color(const Color(0xffededed)),
                    )
                  : BorderSide.none,
            ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              renderLeftIcon(context),
              // title 和 content
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: titleWeight,
                        color: ThemeScheme.getBlack(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: content,
                    ),
                  ],
                ),
              ),
              // right
              Row(
                children: <Widget>[
                  renderExtra ??
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          extra, // 右侧文字
                          style: TextStyle(
                            fontSize: 12.5,
                            color: ThemeScheme.getLightBlack(),
                          ),
                        ),
                      ),
                  Offstage(
                    offstage: !rightIconShow,
                    child: Icon(
                      rightIconData ?? Icons.arrow_forward_ios_outlined,
                      size: rightIconSize ?? 20,
                      color: rightIconColor ?? ThemeScheme.getLightBlack(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          label != ''
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: leftPicture != "" || leftIconData != null ? 30 : 0,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: ThemeScheme.getLightBlack(),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return renderContext(context);
    } else {
      return Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: bgColor ?? ThemeScheme.getWhiteBackground(), // 使用Ink包裹，在这里设置颜色
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius,
          // highlightColor: ThemeScheme.color(const Color(0xffededed)),
          child: renderContext(context),
        ),
      );
    }
  }
}
