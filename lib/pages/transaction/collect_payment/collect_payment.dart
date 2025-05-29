import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web_wallet/common/utils/common.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/config/global_config.dart';

class CollectPaymentPage extends StatefulWidget {
  const CollectPaymentPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CollectPaymentPageState();
  }
}

class _CollectPaymentPageState extends State<CollectPaymentPage> {
  String walletAddress =
      "123asdd123asdd123asdd123asdd123asdd123asdd123asdd123asdd";

  Widget collectPaymentQrCode() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          bottom: 0,
          child: Image.asset("assets/images/corner_left_bottom.png", width: 25),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child:
              Image.asset("assets/images/corner_right_bottom.png", width: 25),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: Image.asset("assets/images/corner_left_top.png", width: 25),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Image.asset("assets/images/corner_right_top.png", width: 25),
        ),
        QrImageView(
          data: walletAddress,
          version: QrVersions.auto,
          size: 210,
          padding: const EdgeInsets.all(15),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.receive,
        borderWidth: 1,
        titleColor: Colors.white,
        brightness: Brightness.light,
        backgroundColor: const Color(0xffdd2e3b),
      ),
      backgroundColor: const Color(0xffdd2e3b),
      body: Column(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.l10n
                      .onlySupportsAssetsAgreement('（TRC10/TRC20）', 'Tron'),
                  style: const TextStyle(
                    color: Color(0xff2b2e30),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                collectPaymentQrCode(),
                const SizedBox(height: 10),
                Text(
                  context.l10n.walletAddress,
                  style: const TextStyle(
                    color: Color(0xff868688),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Common.clipboard(walletAddress),
                  child: Text(
                    walletAddress,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff2b2e30),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Material(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: const Color(0xfff4f6f9),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: customButton(
                      context,
                      onPressed: () => Common.clipboard(walletAddress),
                      title: context.l10n.share,
                      height: 60,
                      iconChild: const Icon(
                        Icons.share,
                        color: Color(0xff2b2e30),
                        size: 18,
                      ),
                      backgroundColor: Colors.transparent,
                      fontColor: const Color(0xff2b2e30),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: const Color(0xFFD2D2D2),
                  ),
                  Expanded(
                    child: customButton(
                      context,
                      onPressed: () => Common.clipboard(walletAddress),
                      title: context.l10n.copy,
                      height: 60,
                      iconChild: const Icon(
                        Icons.copy,
                        color: Color(0xff2b2e30),
                        size: 18,
                      ),
                      backgroundColor: Colors.transparent,
                      fontColor: const Color(0xff2b2e30),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
