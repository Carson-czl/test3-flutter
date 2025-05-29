import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'common.dart';

class Cache {
  /// 获取目录并计算
  static Future<String> getCache() async {
    int value = 0;
    try {
      Directory tempDir = await getTemporaryDirectory();
      var res = await getTotalSizeOfFilesInDir(tempDir);
      value = res.ceil();
    } catch (err) {
      value = 0;
    }
    return Common.getPrintSize(value);
  }

  /// 缓存计算大小
  static Future<double> getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List children = file.listSync();
      double total = 0;
      for (final FileSystemEntity child in children) {
        total += await getTotalSizeOfFilesInDir(child);
      }
      return total;
    }
    return 0;
  }

  /// 删除目录
  static Future<void> deleteDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await deleteDir(child);
      }
    }
    await file.delete();
  }

  /// 获取所有删除的目录
  static Future<Directory> getAllDirectory() async {
    try {
      var value = await getTemporaryDirectory();
      return value;
    } catch (error) {
      return Future.error(error);
    }
  }
}
