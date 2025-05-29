import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/stores/app_settings.dart';

class OpenGesturePasswordPage extends StatefulWidget {
  const OpenGesturePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OpenGesturePasswordPageState();
  }
}

class _OpenGesturePasswordPageState extends State<OpenGesturePasswordPage> {
  List<int>? _answer;

  List<int> _drawingList = [];

  final int _completeWaitMilliseconds = 500;

  String _tipError = "";

  void _onSave() {
    if (_answer != null) {
      Provider.of<AppSettingsStore>(context, listen: false)
          .setOpenScreenPassword(_answer ?? []);
      Navigator.pop(context, 1);
    }
  }

  void _onComplete(List<int?> data) {
    _drawingList = data.cast<int>().toList();
    if (data.length >= 4) {
      if (_answer == null) {
        _answer = _drawingList;
        _tipError = "";
        _clearInfo();
      } else if (_answer?.join(',') != data.join(',')) {
        _tipError = context.l10n.twoGesturePasswordsMismatch;
        _clearInfo();
      } else {
        _onSave();
      }
    } else {
      _tipError = context.l10n.atLeastConnectPoints;
      _clearInfo();
    }
    setState(() {});
  }

  void _clearInfo() {
    Future.delayed(Duration(
      milliseconds: _completeWaitMilliseconds,
    )).then((value) {
      setState(() {
        _tipError = "";
        _drawingList = [];
      });
    });
  }

  Widget _displayDrawing() {
    return SizedBox(
      width: 48, // 控制wrap显示数量
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: List.generate(9, (index) {
          Border border = Border.all(
            width: 1,
            color: ThemeScheme.color(const Color(0xFFBFBFBF)),
          );
          var isSelected = _drawingList.contains(index);
          return Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xff0C6BFE) : Colors.transparent,
              shape: BoxShape.circle,
              border: !isSelected ? border : null,
            ),
          );
        }),
      ),
    );
  }

  Widget _tipStr() {
    return Text(
      _tipError == "" ? context.l10n.setDrawGesturePassword : _tipError,
      style: TextStyle(
        fontSize: 14,
        color: _tipError == '' ? ThemeScheme.getLightBlack() : Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.enableGesturePasscode,
      ),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          _displayDrawing(),
          const SizedBox(height: 10),
          _tipStr(),
          const SizedBox(height: 50),
          Center(
            child: GesturePasswordWidget(
              lineColor: const Color(0xff0C6BFE),
              errorLineColor: Colors.redAccent,
              singleLineCount: 3,
              identifySize: 90,
              minLength: 4,
              completeWaitMilliseconds: _completeWaitMilliseconds,
              errorItem: Image.asset(
                'assets/images/gesture_password/selected.png',
                color: Colors.redAccent,
              ),
              normalItem: Image.asset(
                'assets/images/gesture_password/normal.png',
                color: ThemeScheme.color(const Color(0xFFBFBFBF)),
              ),
              selectedItem: Image.asset(
                'assets/images/gesture_password/selected.png',
                color: const Color(0xff0C6BFE),
              ),
              arrowItem: Image.asset(
                'assets/images/gesture_password/arrow.png',
                width: 20.0,
                height: 20.0,
                color: const Color(0xff0C6BFE),
                fit: BoxFit.fill,
              ),
              errorArrowItem: Image.asset(
                'assets/images/gesture_password/arrow.png',
                width: 20.0,
                height: 20.0,
                fit: BoxFit.fill,
                color: Colors.redAccent,
              ),
              answer: _answer,
              color: Colors.transparent,
              onComplete: _onComplete,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
        child: customButton(
          context,
          onPressed: () => {
            setState(() {
              _answer = null;
              _tipError = "";
            })
          },
          title: context.l10n.repaint,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
