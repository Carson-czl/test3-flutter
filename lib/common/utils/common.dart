import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_scankit/flutter_scankit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_wallet/config/global_config.dart';

class Common {
  /// 内存转换单位子节(b)
  static String getPrintSize(
    int limit, {
    int digits = 2,
  }) {
    String size = "${limit.toStringAsFixed(digits)} B";
    if (limit < 1 * 1024 * 1024) {
      // 小于1MB，则转化成KB
      size = "${(limit / 1024).toStringAsFixed(digits)} KB";
    } else if (limit < 1 * 1024 * 1024 * 1024) {
      // 小于1GB，则转化成MB
      size = "${(limit / (1024 * 1024)).toStringAsFixed(digits)} MB";
    } else {
      // 其他转化成GB
      size = "${(limit / (1024 * 1024 * 1024)).toStringAsFixed(digits)} GB";
    }
    return size;
  }

  /// 复制文本
  static void clipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((value) {
      EasyLoading.showToast(
          navigatorKey.currentContext?.l10n.copySuccess ?? "");
    }).catchError((error) {
      EasyLoading.showToast(navigatorKey.currentContext?.l10n.copyError ?? "");
    });
  }

  /// 获取随机数
  static int getRandomInt(int min, int max) {
    return Random().nextInt((max - min).floor()) + min;
  }

  /// 开始扫码
  static Future<void> startScan(ScanKit scanKit) async {
    try {
      PermissionStatus cameraStatus = await Permission.camera.status;
      PermissionStatus photoStatus = await Permission.photos.status;
      if (cameraStatus.isGranted && photoStatus.isGranted) {
        // 有权限则调用
        await scanKit.startScan(
            scanTypes: ScanTypes.qRCode.bit |
                ScanTypes.code39.bit |
                ScanTypes.code128.bit);
      } else if (cameraStatus.isDenied || photoStatus.isDenied) {
        await [Permission.camera, Permission.photos].request();
      } else if (cameraStatus.isPermanentlyDenied ||
          photoStatus.isPermanentlyDenied) {
        openAppSettings();
      }
    } catch (error) {
      print("报错了$error");
    }
  }
}
