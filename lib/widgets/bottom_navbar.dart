// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:notion_wordbook/screens/connecting_page.dart';
import 'package:notion_wordbook/screens/home_page.dart';
import 'package:notion_wordbook/screens/hook_test_page.dart';
import 'package:notion_wordbook/screens/my_info_page.dart';
import 'package:notion_wordbook/screens/review_page.dart';
import 'package:notion_wordbook/screens/user_page.dart';

class NavigatedPages extends StatefulWidget {
  const NavigatedPages({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<NavigatedPages> {
  var _navIndex = 0;
  final screens = [
    HomePage(),
    const ReviewPage(),
    const MyInfoPage(),
    ConnectingPage(),
    const HookPage(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: '単語帳一覧'),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_edit_outline),
            label: '復習',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: '学習データ',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'マイページ'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'マイページ'),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(
            () {
              _navIndex = index;
            },
          );
        },
        currentIndex: _navIndex,
      ),
      body: screens[_navIndex],
    );
  }
}
