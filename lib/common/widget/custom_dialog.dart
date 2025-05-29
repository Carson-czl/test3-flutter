import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';

class CustomDialog {
  /// 确认弹窗
  static void confirm(
    BuildContext context, {
    String? title,
    String? content,
    bool canPop = true, // 是否屏蔽安卓返回true不拦截
    bool showCancel = true, // 是否显示取消按钮
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = false,
    void Function()? onSuccess,
    void Function()? onFail,
    PopInvokedWithResultCallback<bool>?
        onPopInvokedWithResult, // canPop=false时候拦截触发
  }) {
    customContent(
      context,
      title: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          content ?? "",
          style: TextStyle(
            color: ThemeScheme.getLightBlack(),
            fontSize: 14,
          ),
        ),
      ),
      canPop: canPop,
      showCancel: showCancel,
      confirmText: confirmText,
      cancelText: cancelText,
      barrierDismissible: barrierDismissible,
      onSuccess: onSuccess,
      onFail: onFail,
      onPopInvokedWithResult: onPopInvokedWithResult,
    );
  }

  /// 自定义内容
  static void customContent(
    BuildContext context, {
    String? title,
    required Widget child,
    bool canPop = true, // 是否屏蔽安卓返回true不拦截
    bool showCancel = true, // 是否显示取消按钮
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = false,
    void Function()? onSuccess,
    void Function()? onFail,
    PopInvokedWithResultCallback<bool>?
        onPopInvokedWithResult, // canPop=false时候拦截触发
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: canPop,
          onPopInvokedWithResult: onPopInvokedWithResult,
          child: Dialog(
            backgroundColor: ThemeScheme.getWhiteBackground(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Text(
                      title ?? navigatorKey.currentContext?.l10n.tips ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeScheme.getBlack(),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: child),
                  ..._defaultBtnList(
                    context,
                    showCancel: showCancel,
                    confirmText: confirmText ??
                        navigatorKey.currentContext?.l10n.confirm ??
                        "",
                    cancelText: cancelText ??
                        navigatorKey.currentContext?.l10n.cancel ??
                        "",
                    onSuccess: onSuccess,
                    onFail: onFail,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {});
  }

  static List<Widget> _defaultBtnList(
    BuildContext context, {
    bool showCancel = true, // 是否显示取消按钮
    required String confirmText,
    required String cancelText,
    void Function()? onSuccess,
    void Function()? onFail,
  }) {
    return [
      Divider(
        height: 0,
        color: ThemeScheme.color(const Color(0xffededed)),
      ),
      Row(
        children: <Widget>[
          showCancel
              ? Expanded(
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: ThemeScheme.color(const Color(0xffededed)),
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onFail?.call();
                      },
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Text(
                        cancelText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeScheme.getLightBlack(),
                          fontSize: 14,
                          height: 3.2,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.fromSize(),
          Expanded(
            child: Ink(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onSuccess?.call();
                },
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(showCancel ? 0 : 10),
                  bottomRight: const Radius.circular(10),
                ),
                child: Text(
                  confirmText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeScheme.getBlack(),
                    fontSize: 14,
                    height: 3.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ];
  }
}
