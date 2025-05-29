import 'package:flutter/material.dart';

/// 钱包图标配色和路径
class WalletNetworkParma {
  String name;
  String imgPath;
  Color imgBg;

  WalletNetworkParma({
    required this.name,
    required this.imgPath,
    required this.imgBg,
  });
}

class AppWalletInfo {
  static final Map<String, WalletNetworkParma> _imgInfo = {
    "ETH": WalletNetworkParma(
      name: 'Ethereum',
      imgPath: "assets/images/wallet_network/ethereum.png",
      imgBg: const Color(0xffe7f4fa),
    ),
    "TRX": WalletNetworkParma(
      name: "Tron",
      imgPath: "assets/images/wallet_network/tron.png",
      imgBg: const Color(0xfffdefee),
    )
  };

  static WalletNetworkParma getWalletInfo(String value) {
    return _imgInfo[value] ?? WalletNetworkParma(
      name: 'ETH',
      imgPath: "assets/images/wallet_network/ethereum.png",
      imgBg: const Color(0xffe7f4fa),
    );
  }

  /// 处理钱包图标控件
  static Widget getWalletIcon(String value,
      {double size = 40, double iconSize = 30, double marginRight = 10}) {
    WalletNetworkParma? info = _imgInfo[value];
    if (info == null) {
      return Container(
        width: size,
        height: size,
        margin: EdgeInsets.only(right: marginRight),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.only(right: marginRight),
      decoration: BoxDecoration(
        color: info.imgBg,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          info.imgPath,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}
