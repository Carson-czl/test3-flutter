import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/app_wallet_info.dart';
import 'package:web_wallet/config/global_config.dart';

class AddressSelect extends StatefulWidget {
  final String addressType;
  const AddressSelect({
    super.key,
    required this.addressType,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddressSelectState();
  }
}

class _AddressSelectState extends State<AddressSelect> {
  List<String> addressList = ['ETH', 'TRX'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: context.l10n.selectAddressType,
      ),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: ListView.separated(
        itemBuilder: (context, index) {
          String item = addressList[index];
          WalletNetworkParma walletInfo = AppWalletInfo.getWalletInfo(item);
          return ListTile(
            leading: AppWalletInfo.getWalletIcon(item),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            title: Text(
              item,
              style: TextStyle(
                fontSize: 16,
                color: ThemeScheme.getBlack(),
              ),
            ),
            subtitle: Text(
              walletInfo.name,
              style: TextStyle(
                fontSize: 14,
                color: ThemeScheme.getLightBlack(),
              ),
            ),
            trailing: item == widget.addressType
                ? const Icon(
                    CupertinoIcons.checkmark_alt_circle,
                    color: Color(0xff007fff),
                  )
                : null,
            onTap: () => Navigator.pop(context, item),
          );
        },
        itemCount: addressList.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 0,
          color: ThemeScheme.color(const Color(0xffeeeeee)),
        ),
      ),
    );
  }
}
