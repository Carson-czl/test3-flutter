import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:web_wallet/config/global_config.dart';

import 'home/home_page.dart';
import 'my/my_page.dart';

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeTabBarState();
  }
}

class _HomeTabBarState extends State<HomeTabBar>
    with AutomaticKeepAliveClientMixin {
  int tabIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    updateApp();
    pageController = PageController(initialPage: tabIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /// 检测App更新
  void updateApp() {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        children: const <Widget>[
          HomePage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        onTap: (index) {
          if (tabIndex != index) {
            pageController.jumpToPage(index);
            setState(() {
              tabIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: ThemeScheme.getWhite(),
        selectedItemColor: const Color(0xff007fff),
        unselectedItemColor: ThemeScheme.getLightBlack(),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.l10n.home,
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_alt),
            label: context.l10n.my,
            tooltip: '',
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
