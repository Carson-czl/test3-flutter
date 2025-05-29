import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';

enum AppInputType {
  /// 清除
  clear,

  /// 密码
  password,
}

class AppInput extends StatefulWidget {
  final AppInputType? type;
  final bool? isFocus;
  final String? hintText;
  final String? counterText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Widget? leftIconWidget;
  final IconData? leftIconData;
  final Widget? rightIconWidget;
  final IconData? rightIconData;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onSubmitted;

  /// 自定义的输入框
  /// ```
  /// @param {AppInputType} type - 输入框类型不写入默认
  /// @param {bool} isFocus - 是否获取焦点
  /// @param {String} hintText - 提示文字
  /// @param {String} counterText - 此处控制最大字符是否显示
  /// @param {int} minLines - 最小行数
  /// @param {int} maxLines - 最大行数
  /// @param {int} maxLength - 最大数量
  /// @param {TextStyle} textStyle
  /// @param {TextStyle} hintStyle
  /// @param {Widget} leftIconWidget - 左侧内容
  /// @param {IconData} leftIconData - 左侧图标
  /// @param {Widget} rightIconWidget - 左侧内容
  /// @param {IconData} rightIconData - 左侧图标
  /// @param {TextInputType} keyboardType - 键盘类型
  /// @param {List<TextInputFormatter>} inputFormatters - 键盘输入规则
  /// @param {ValueChanged<String>} onChanged
  /// @param {void Function(String)} onSubmitted
  /// ```
  const AppInput({
    super.key,
    this.type,
    this.isFocus,
    this.hintText,
    this.counterText,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.textStyle,
    this.hintStyle,
    this.leftIconWidget,
    this.leftIconData,
    this.rightIconWidget,
    this.rightIconData,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<AppInput> createState() => AppInputState();
}

class AppInputState extends State<AppInput> {
  bool showRightIcon = true;

  /// type password类型则会true
  bool obscureText = false;

  final TextEditingController controller = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    switch (widget.type) {
      case AppInputType.clear:
        showRightIcon = controller.text.isNotEmpty;
        focusNode.addListener(() {
          setState(() {
            showRightIcon = controller.text.isNotEmpty;
          });
        });
        break;
      case AppInputType.password:
        // showRightIcon = true;
        obscureText = true;
        break;
      default:
    }
    if (widget.isFocus == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget? iconWidget() {
    if (widget.leftIconWidget != null) {
      return widget.leftIconWidget;
    } else if (widget.leftIconData != null) {
      return Icon(
        widget.leftIconData,
        color: ThemeScheme.getLightBlack(),
        size: 25,
      );
    }
    return null;
  }

  Widget? suffixIconWidget() {
    if (!showRightIcon) {
      return null;
    }
    if (widget.rightIconWidget != null) {
      return widget.rightIconWidget;
    } else if (widget.rightIconData != null) {
      return Icon(
        widget.rightIconData,
        color: ThemeScheme.getLightBlack(),
        size: 25,
      );
    } else if (widget.type == AppInputType.password) {
      // 密码类型的右边按钮
      return IconButton(
        onPressed: () => {
          setState(() {
            obscureText = !obscureText;
          })
        },
        highlightColor: Colors.transparent,
        icon: obscureText
            ? Icon(
                Icons.visibility_off,
                size: 20,
                color: ThemeScheme.getLightBlack(),
              )
            : const Icon(
                Icons.remove_red_eye,
                size: 20,
                color: Color(0xff007fff),
              ),
      );
    } else if (widget.type == AppInputType.clear) {
      // 清除类型的右边按钮
      return IconButton(
        onPressed: () => {
          setState(() {
            showRightIcon = false;
            controller.clear();
            widget.onChanged?.call("");
          })
        },
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.highlight_off,
          size: 20,
          color: ThemeScheme.getLightBlack(),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: widget.textStyle ??
          TextStyle(
            color: ThemeScheme.getBlack(),
            height: 1,
          ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: ThemeScheme.getLightBlack(),
              height: 1,
            ),
        counterText: widget.counterText ?? '', // 此处控制最大字符是否显示
        contentPadding: EdgeInsets.only(
          left: widget.leftIconData == null ? 0 : -15,
        ),
        icon: iconWidget(),
        suffixIcon: suffixIconWidget(),
        // https://blog.csdn.net/senkai123/article/details/103159226
        border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: obscureText,
      onSubmitted: widget.onSubmitted,
      onChanged: (value) {
        widget.onChanged!(value);
        if (widget.type == AppInputType.clear) {
          setState(() {
            showRightIcon = value.isNotEmpty;
          });
        }
      },
    );
  }
}

/// 限制只允许输入浮点数字
class AppInputTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith('-')) {
      return oldValue;
    }
    // 只允许数字、小数点，不允许负号
    if (newValue.text.isEmpty) {
      return newValue;
    }
    // 判断是否符合数字格式（包括负号和小数点）
    final validText = RegExp(r'^-?\d*\.?\d*$').hasMatch(newValue.text);
    if (validText) {
      return newValue;
    } else {
      return oldValue; // 如果输入的不是有效数字，返回上一个有效值
    }
  }
}
