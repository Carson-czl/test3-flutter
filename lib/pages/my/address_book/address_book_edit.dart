import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_dialog.dart';
import 'package:web_wallet/common/widget/custom_icons.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/components/app_input/app_input.dart';
import 'package:web_wallet/components/my_list_item/my_list_item.dart';
import 'package:web_wallet/config/app_wallet_info.dart';
import 'package:web_wallet/config/global_config.dart';
import 'package:web_wallet/pages/my/address_book/address_select.dart';

class AddressBookEditPage extends StatefulWidget {
  final int addressId;
  const AddressBookEditPage({
    super.key,
    this.addressId = 0,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddressBookEditPageState();
  }
}

class _AddressBookEditPageState extends State<AddressBookEditPage> {
  int addressId = 0;

  String addressType = 'ETH';

  String walletAddress = '';

  String walletName = '';

  String walletDes = '';

  @override
  void initState() {
    addressId = widget.addressId;
    super.initState();
  }

  void onSave() {
    if (walletAddress == '') {
      EasyLoading.showToast(context.l10n.pleaseEnterAddress);
    } else if (walletName == '') {
      EasyLoading.showToast(context.l10n.pleaseEnterName);
    } else {
      Navigator.pop(context);
    }
  }

  void onDelete() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: addressId == 0
            ? context.l10n.newAddressBook
            : context.l10n.editAddressBook,
        backgroundColor: ThemeScheme.color(const Color(0xFFF0F1F3)),
        rightBtn: <Widget>[
          TextButton(
            onPressed: onSave,
            style: ButtonStyle(
                overlayColor: WidgetStateProperty.resolveWith((states) {
              return Colors.transparent;
            })),
            child: Text(
              context.l10n.save,
              style: const TextStyle(
                color: Color(0xff007fff),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        children: <Widget>[
          MyListItem(
            title: addressType,
            leftWidget: AppWalletInfo.getWalletIcon(addressType),
            borderRadius: BorderRadius.circular(10),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressSelect(addressType: addressType),
                ),
              ).then((result) {
                if (result != null) {
                  setState(() {
                    addressType = result as String;
                  });
                }
              });
            },
          ),
          const SizedBox(height: 15),
          Text(
            context.l10n.addressInformation,
            style: TextStyle(
              color: ThemeScheme.getLightBlack(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: ThemeScheme.getWhiteBackground(),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                AppInput(
                  hintText: context.l10n.pleaseEnterAddress,
                  keyboardType: TextInputType.multiline,
                  maxLength: 80,
                  minLines: 1,
                  maxLines: 5,
                  rightIconWidget: IconButton(
                    onPressed: () {},
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      CustomIcons.scan,
                      size: 20,
                      color: ThemeScheme.getBlack(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      walletAddress = value;
                    });
                  },
                ),
                Divider(
                  height: 0,
                  color: ThemeScheme.color(const Color(0xffededed)),
                ),
                AppInput(
                  maxLength: 20,
                  hintText: context.l10n.pleaseEnterName,
                  type: AppInputType.clear,
                  onChanged: (value) {
                    setState(() {
                      walletName = value;
                    });
                  },
                ),
                Divider(
                  height: 0,
                  color: ThemeScheme.color(const Color(0xffededed)),
                ),
                AppInput(
                  maxLength: 50,
                  hintText: context.l10n.descriptionOptional,
                  type: AppInputType.clear,
                  onChanged: (value) {
                    setState(() {
                      walletDes = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Ink(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeScheme.getWhiteBackground(),
            ),
            child: InkWell(
              onTap: () => {
                CustomDialog.confirm(
                  context,
                  content: context.l10n.confirmDeleteAddress,
                  onSuccess: onDelete,
                )
              },
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: Text(
                  context.l10n.delete,
                  style: const TextStyle(
                    color: Color(0xffea766d),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
