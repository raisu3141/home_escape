import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:home_escape/constant/constant.dart';
import 'package:home_escape/pages/check_page.dart';

import 'pages/account_pag.dart';
import 'pages/escape_page.dart';
import 'pages/check_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  const app = MyApp();
  const scope = ProviderScope(child: app);
  runApp(scope);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Constant.deviceHeight = MediaQuery.of(context).size.height;
    Constant.deviceWidth = MediaQuery.of(context).size.width;
    
    return MaterialApp(
      title: 'HomeEscape',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

        // フォントの設定
        fontFamily: 'dotGothic16',
      ),
      home: const HomePage( title: 'HomeEscape'),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // BottomNavigationBarのインデックスをuseStateで管理
    final _selectedIndex = useState(0);

    // 画面のサイズを取得
    final screenSize = MediaQuery.of(context).size;

    // 画面幅に基づいてパディングを計算
    final double bottomPadding = screenSize.height * 0.03; // 画面高さの3%
    final double horizontalPadding = screenSize.width * 0.05; // 画面幅の5%
    final double iconTopPadding = 10; // アイコンの上に追加するパディング

    // 各タブに表示するページのリスト
    final List<Widget> _pages = <Widget>[
      // const AccountPage(), //ここに追加する
      // const checkPage(),
      const AccountPage(),
      
    ];

    // タブが選択された時にインデックスを更新するメソッド
    void _onItemTapped(int index) {
      _selectedIndex.value = index;
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex.value,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey, // 線の色
              width: 1.0,        // 線の太さ
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex.value,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '防災リスト',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              label: '避難指示',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'アカウント',
            ),
          ],
          selectedItemColor: Colors.orange,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconSize: 30,
        ),
      ),
);
  }
}
