import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';

class PaymentKeyboard extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final int passwordLength;

  const PaymentKeyboard({
    super.key,
    required this.onCompleted,
    this.passwordLength = 6,
  });

  @override
  State<PaymentKeyboard> createState() => _PaymentKeyboardState();
}

class _PaymentKeyboardState extends State<PaymentKeyboard> {
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  void _onNumberPressed(String number) {
    if (_password.length < widget.passwordLength) {
      setState(() {
        _password += number;
      });

      if (_password.length == widget.passwordLength) {
        widget.onCompleted(_password);
      }
    }
  }

  void _onDeletePressed() {
    if (_password.isNotEmpty) {
      setState(() {
        _password = _password.substring(0, _password.length - 1);
      });
    }
  }

  /// 密码显示框
  Widget _buildPasswordDisplay() {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: ThemeScheme.color(const Color(0xffededed)),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(widget.passwordLength, (index) {
          bool hasValue = index < _password.length;
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: index == 0
                      ? BorderSide.none
                      : BorderSide(
                          width: 2,
                          color: ThemeScheme.color(const Color(0xffededed)),
                        ),
                ),
              ),
              alignment: Alignment.center,
              child: hasValue
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: ThemeScheme.getBlack(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  : null,
            ),
          );
        }),
      ),
    );
  }

  /// 数字键盘
  Widget _buildKeyboardRow(List<String> keys) {
    return Row(
      children: List.generate(keys.length, (index) {
        return Expanded(
          child: _buildKeyButton(keys[index], index),
        );
      }),
    );
  }

  Widget _buildKeyButton(String text, int index) {
    if (text.isEmpty) {
      return Container(
        height: 50,
        color: ThemeScheme.color(const Color(0xffededed)),
      );
    } else {
      return Ink(
        color: text != 'DEL'
            ? ThemeScheme.getWhiteBackground()
            : ThemeScheme.color(const Color(0xffededed)),
        child: InkWell(
          onTap: () {
            if (text == 'DEL') {
              _onDeletePressed();
            } else {
              _onNumberPressed(text);
            }
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: ThemeScheme.color(const Color(0xffededed)),
                ),
                left: index == 0
                    ? BorderSide.none
                    : BorderSide(
                        width: 2,
                        color: ThemeScheme.color(const Color(0xffededed)),
                      ),
              ),
            ),
            child: text == 'DEL'
                ? Icon(
                    Icons.backspace,
                    color: ThemeScheme.getBlack(),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 24,
                      color: ThemeScheme.getBlack(),
                    ),
                  ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeScheme.getWhiteBackground(),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '输入支付密码',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeScheme.getBlack(),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: ThemeScheme.getLightBlack(),
                  ),
                ),
              ],
            ),
          ),
          _buildPasswordDisplay(),
          _buildKeyboardRow(['1', '2', '3']),
          _buildKeyboardRow(['4', '5', '6']),
          _buildKeyboardRow(['7', '8', '9']),
          _buildKeyboardRow(['', '0', 'DEL']),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
