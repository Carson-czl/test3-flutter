import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';


class CustomShowDialog {
  /// Android样式弹窗
  static void androidAlert(
    BuildContext context, {
    String title = '提示',
    String content = '',
    bool showCancel = true, // 是否显示取消按钮
    String confirmText = '确认',
    String cancelText = '取消',
    bool barrierDismissible = false,
    void Function()? onSuccess,
    void Function()? onFail,
    bool canPop = true, // 是否屏蔽安卓返回true不拦截
    PopInvokedWithResultCallback<bool>? onPopInvokedWithResult, // canPop=false时候拦截触发
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: canPop,
          onPopInvokedWithResult: onPopInvokedWithResult,
          child: AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                color: ThemeScheme.getBlack(),
                fontSize: 20,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    content,
                    style: TextStyle(
                      color: ThemeScheme.getBlack(),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Offstage(
                offstage: !showCancel,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onFail?.call();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        color: ThemeScheme.getBlack(),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onSuccess?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(
                    confirmText,
                    style: TextStyle(
                      color: ThemeScheme.getBlack(),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {});
  }
}
