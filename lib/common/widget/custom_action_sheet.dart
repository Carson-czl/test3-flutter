import 'package:flutter/material.dart';
import 'package:web_wallet/config/global_config.dart';

import 'theme_scheme.dart';

// DraggableScrollableSheet 可以滚动的拖拽框

class CustomActionSheet {
  /// 底部弹窗选择器，list建议不要超过5个
  static void selectorList(
    BuildContext context, {
    required List<String> list,
    bool isDismissible = true, // 是否允许点击mask关闭
    void Function(int)? onTap,
  }) {
    Widget renderListItem({
      int index = 0,
      double borderWidth = 1,
      String title = '',
    }) {
      return Ink(
        width: double.maxFinite,
        height: 50,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            onTap?.call(index);
          },
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: ThemeScheme.getBlack(),
              ),
            ),
          ),
        ),
      );
    }

    List<Widget> renderList() {
      List<Widget> nodeList = [];
      int length = list.length;
      for (var i = 0; i < length; i++) {
        String title = list[i];
        nodeList.add(renderListItem(
          title: title,
          index: i,
        ));
        nodeList.add(
          Divider(
            height: 0,
            thickness: 1,
            color: ThemeScheme.color(const Color(0xFFF0F1F3)),
          ),
        );
      }
      return nodeList;
    }

    showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: false,
      backgroundColor: ThemeScheme.getWhiteBackground(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      builder: (BuildContext context) {
        double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...renderList(),
            Divider(
              height: 0,
              thickness: 5,
              color: ThemeScheme.color(const Color(0xFFF0F1F3)),
            ),
            renderListItem(
                title: context.l10n.cancel, borderWidth: 6, index: -1),
            SizedBox(height: bottomPadding),
          ],
        );
      },
    );
  }

  /// 底部可拖拽关闭的弹窗
  static dragBottomSheet(
    BuildContext context, {
    double? height,
    String title = "",
    bool isDismissible = true,
    bool isScrollControlled = false,
    Color? backgroundColor,
    required List<Widget> children,
  }) {
    customContent(
      context,
      height: height,
      title: "",
      isHideClose: true,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      children: <Widget>[
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: ThemeScheme.getLightBlack(),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Offstage(
          offstage: title == "",
          child: Text(
            title,
            style: TextStyle(
              color: ThemeScheme.getBlack(),
              fontSize: 16,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  /// 自定义内容
  /// ValueNotifier对付在外部数据变动后控件内部不更新的情况
  static void customContent(
    BuildContext context, {
    double? height,
    String title = "",
    bool isHideClose = false,
    bool enableDrag = false,
    bool isDismissible = false,
    bool isScrollControlled = false,
    Color? backgroundColor,
    required List<Widget> children,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: isScrollControlled,
      builder: (BuildContext context) {
        double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
        return SizedBox(
          width: double.maxFinite,
          height: height != null ? height + 40 : null,
          child: Column(
            children: <Widget>[
              Offstage(
                offstage: isHideClose,
                child: SizedBox(
                  width: double.maxFinite,
                  height: 40,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          color: ThemeScheme.getBlack(),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            color: ThemeScheme.getBlack(),
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ...children,
              SizedBox(height: bottomPadding),
            ],
          ),
        );
      },
    );
  }
}
