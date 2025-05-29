import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_wallet/common/utils/common.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/custom_button.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';

class ConfirmMnemonicPage extends StatefulWidget {
  final List<String> mnemonicList;

  const ConfirmMnemonicPage({
    super.key,
    required this.mnemonicList,
  });

  @override
  State<StatefulWidget> createState() {
    return _ConfirmMnemonicPageState();
  }
}

class _ConfirmMnemonicPageState extends State<ConfirmMnemonicPage> {
  List<String> selectList = [];
  List<String> shuffleMnemonicList = [];

  /// 计算属性判断选择后的数组数据是否与答案一至
  bool get isErrorTip {
    return widget.mnemonicList.take(selectList.length).join(',') !=
        selectList.join(',');
  }

  @override
  void initState() {
    shuffleList(widget.mnemonicList);
    super.initState();
  }

  /// 打乱数组
  void shuffleList(List<String> arr) {
    List<String> newArr = [];
    newArr.addAll(arr);
    for (var i = 1; i < newArr.length; i++) {
      int j = Common.getRandomInt(0, i);
      String t = newArr[i];
      newArr[i] = newArr[j];
      newArr[j] = t;
    }
    shuffleMnemonicList = newArr;
  }

  void removeSelectBtn(String item) {
    setState(() {
      selectList.remove(item);
    });
  }

  /// 选择好的列表展示
  Widget _selectCurrentList() {
    List<Widget> showSelectBtn = [];
    for (var i = 0; i < selectList.length; i++) {
      String item = selectList[i];
      bool isCorrect = widget.mnemonicList[i] == item;
      showSelectBtn.add(Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Ink(
              decoration: BoxDecoration(
                color: ThemeScheme.getWhite(),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: ThemeScheme.color(const Color(0xffededed)),
                ),
              ),
              child: InkWell(
                onTap: () => removeSelectBtn(item),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: ThemeScheme.getBlack(),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -5,
              top: -5,
              child: Offstage(
                offstage: isCorrect,
                child: GestureDetector(
                  onTap: () => removeSelectBtn(item),
                  child: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.redAccent,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    }

    return Container(
      width: double.maxFinite,
      constraints: const BoxConstraints(minHeight: 200),
      margin: const EdgeInsets.only(top: 10, bottom: 30, right: 10),
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: ThemeScheme.color(const Color(0xfffafbfd)),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: ThemeScheme.color(const Color(0xffededed)),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Wrap(
          children: showSelectBtn,
        ),
      ),
    );
  }

  Widget _mnemonicBtn() {
    List<Widget> btnList = [];
    for (var i = 0; i < shuffleMnemonicList.length; i++) {
      String item = shuffleMnemonicList[i];
      bool isSelected = selectList.contains(item);
      btnList.add(Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: isSelected
                ? ThemeScheme.color(const Color(0xfff1f2f7))
                : ThemeScheme.color(const Color(0xffededed)),
          ),
        ),
        child: InkWell(
          onTap: isSelected
              ? null
              : () {
                  if (!isSelected) {
                    setState(() {
                      selectList.add(item);
                    });
                  }
                },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              item,
              style: TextStyle(
                color: isSelected
                    ? ThemeScheme.color(const Color(0xffeaeef1))
                    : ThemeScheme.getBlack(),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ));
    }

    return Wrap(
      children: btnList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        borderWidth: 1,
      ),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '确认助记词',
              style: TextStyle(
                fontSize: 14,
                color: ThemeScheme.getBlack(),
              ),
            ),
            Text(
              '请按顺序点击助记词，以确认您正确备份。',
              style: TextStyle(
                fontSize: 12,
                color: ThemeScheme.getLightBlack(),
              ),
            ),
            const SizedBox(height: 10),
            Opacity(
              opacity: isErrorTip ? 1 : 0,
              child: const Text(
                "助记词顺序不正确，请校对",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 14,
                ),
              ),
            ),
            _selectCurrentList(),
            _mnemonicBtn(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        color: ThemeScheme.getWhiteBackground(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: customButton(
            context,
            title: context.l10n.next,
            disabled:
                widget.mnemonicList.length != selectList.length || isErrorTip,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
