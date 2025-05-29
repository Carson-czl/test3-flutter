import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 公共方法没法获取context 通过挂载全局获取
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

extension LocalizedBuildContext on BuildContext {
  /// 直接获取l10n方法
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
