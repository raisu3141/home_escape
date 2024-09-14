import 'package:flutter/material.dart';
import '../constant/constant.dart';

class CheckPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class ColoredTabBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget tabBar;
  final Color color;

  ColoredTabBar({required this.tabBar, required this.color});

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: color,
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => tabBar.preferredSize;
}

class _ChecklistPageState extends State<CheckPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<ChecklistItem> _lists = [
    ChecklistItem(name: "枕元にスリッパを置く", isChecked: false),
    ChecklistItem(name: "ガスの元栓確認", isChecked: false),
    ChecklistItem(name: "消火器の場所確認", isChecked: false),
    ChecklistItem(name: "家電をベルトやストッパーで固定", isChecked: false),
    ChecklistItem(name: "窓ガラスの近くに大型の家電や家具を置いていない", isChecked: false),
    ChecklistItem(name: "ガラスにフィルムを張るなど飛散防止", isChecked: false),
    ChecklistItem(name: "家具が転倒しても、避難経路を塞がないように置く", isChecked: false),
    ChecklistItem(name: "吊り下げ式の家具に揺れ防止", isChecked: false),
    ChecklistItem(name: "防災グッズの用意", isChecked: false),
  ];

  List<ChecklistItem> _goods = [
    ChecklistItem(name: "水", isChecked: false),
    ChecklistItem(name: "レトルト食品(アルファ米/ビスケット/乾パン)", isChecked: false),
    ChecklistItem(name: "防災用ヘルメット/頭巾", isChecked: false),
    ChecklistItem(name: "衣類/下着", isChecked: false),
    ChecklistItem(name: "予備電池/携帯充電器", isChecked: false),
    ChecklistItem(name: "ラジオ", isChecked: false),
    ChecklistItem(name: "緊急用品", isChecked: false),
    ChecklistItem(name: "ブランケット", isChecked: false),
    ChecklistItem(name: "歯ブラシ", isChecked: false),
    ChecklistItem(name: "タオル", isChecked: false),
    ChecklistItem(name: "貴重品(通帳/パスポート/マイナンバー/etc...)", isChecked: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2つのタブを作成
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('防災チェックリスト'),
        foregroundColor: Colors.white,
        backgroundColor: Color(Constant.mainColor),
        bottom: ColoredTabBar(
          color: Color(Constant.backGroundColor),
          tabBar: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Color(Constant.mainColor),
            // dividerColor: Color(Constant.mainColor),
            // overlayColor: Color(Constant.mainColor),
            tabs: [
              Tab(text: "TODO"),
              Tab(text: "防災グッズ"),
            ],
            indicator: BoxDecoration(
              color: Color(Constant.mainColor),
              borderRadius: BorderRadius.circular(5),
            ), // インジケータの色を指定
            indicatorPadding:
                EdgeInsets.fromLTRB(-8.0, 6.0, -8.0, 6.0), // 左右8.0, 上下4.0の余白
            overlayColor: MaterialStateProperty.all<Color>(
                Color(Constant.mainColor).withOpacity(0.2)),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TODOタブの内容
          ListView.builder(
            itemCount: _lists.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(_lists[index].name),
                value: _lists[index].isChecked,
                activeColor: Color(Constant.mainColor),
                onChanged: (bool? value) {
                  setState(() {
                    _lists[index].isChecked = value ?? false;
                  });
                },
              );
            },
          ),
          // 防災グッズタブの内容
          ListView.builder(
            itemCount: _goods.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(_goods[index].name),
                value: _goods[index].isChecked,
                activeColor: Colors.orange,
                onChanged: (bool? value) {
                  setState(() {
                    _goods[index].isChecked = value ?? false;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ChecklistItem {
  String name;
  bool isChecked;

  ChecklistItem({required this.name, required this.isChecked});
}
