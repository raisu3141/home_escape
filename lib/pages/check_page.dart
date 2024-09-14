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

  List<ChecklistItem> _items = [
    ChecklistItem(name: "aaa", isChecked: true),
    ChecklistItem(name: "aaa", isChecked: false),
    ChecklistItem(name: "aaa", isChecked: true),
    ChecklistItem(name: "aaa", isChecked: true),
    ChecklistItem(name: "aaa", isChecked: true),
    ChecklistItem(name: "aaa", isChecked: true),
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
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TODOタブの内容
          ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(_items[index].name),
                value: _items[index].isChecked,
                activeColor: Colors.orange,
                onChanged: (bool? value) {
                  setState(() {
                    _items[index].isChecked = value ?? false;
                  });
                },
              );
            },
          ),
          // 防災グッズタブの内容
          Center(
            child: Text("防災グッズのリスト"),
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
