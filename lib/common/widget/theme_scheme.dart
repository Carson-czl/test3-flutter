import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeScheme {
  static bool isLightMode =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light;

  /// 浅黑色
  static Color getLightBlack() {
    if (isLightMode) {
      return const Color(0xff868688);
    } else {
      return const Color(0xffc0c0c0);
    }
  }

  /// 白色背景
  static Color getWhiteBackground() {
    if (isLightMode) {
      return Colors.white;
    } else {
      return const Color(0xff171719);
    }
  }

  /// 黑色颜色
  static Color getBlack() {
    if (isLightMode) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  /// 白色颜色
  static Color getWhite() {
    if (isLightMode) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static Color color(Color value) {
    if (!isLightMode) {
      // 黑色主题修改颜色
      switch (value) {
        case const Color(0xfff0f1f3): // 主题背景色
          value = const Color(0xFF2C2C2C);
          break;
        case const Color(0xffeeeeee):
          value = const Color(0xff242424);
          break;
        case const Color(0xffededed): // 线条颜色
          value = const Color(0xff282828);
          break;
      }
    }
    return value;
  }
}
