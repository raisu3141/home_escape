import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<ChecklistItem> _lists = [];
  List<ChecklistItem> _goods = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchChecklistData(); // Firestoreからデータを取得する
  }

  // Firestoreからチェックリストデータを取得する関数
  Future<void> _fetchChecklistData() async {
    try {
      print("データ取得中...");
      final uid = FirebaseAuth.instance.currentUser?.uid;
      print(uid);
      if (uid != null) {
        final userDoc = await FirebaseFirestore.instance.collection('user').doc(uid).get();
        print(userDoc.data());

        if (userDoc.exists) {
          final checkData = List<bool>.from(userDoc.data()?['check'] ?? List.filled(9, false));
          final goodsData = List<bool>.from(userDoc.data()?['goods'] ?? List.filled(11, false));

          // Firestoreのデータをチェックリストに反映
          setState(() {
            _lists = [
              ChecklistItem(name: "枕元にスリッパを置く", isChecked: checkData[0]),
              ChecklistItem(name: "ガスの元栓確認", isChecked: checkData[1]),
              ChecklistItem(name: "消火器の場所確認", isChecked: checkData[2]),
              ChecklistItem(name: "家電をベルトやストッパーで固定", isChecked: checkData[3]),
              ChecklistItem(name: "窓ガラスの近くに大型の家電や家具を置いていない", isChecked: checkData[4]),
              ChecklistItem(name: "ガラスにフィルムを張るなど飛散防止", isChecked: checkData[5]),
              ChecklistItem(name: "家具が転倒しても、避難経路を塞がないように置く", isChecked: checkData[6]),
              ChecklistItem(name: "吊り下げ式の家具に揺れ防止", isChecked: checkData[7]),
              ChecklistItem(name: "防災グッズの用意", isChecked: checkData[8]),
            ];

            _goods = [
              ChecklistItem(name: "水", isChecked: goodsData[0]),
              ChecklistItem(name: "レトルト食品(アルファ米/ビスケット/乾パン)", isChecked: goodsData[1]),
              ChecklistItem(name: "防災用ヘルメット/頭巾", isChecked: goodsData[2]),
              ChecklistItem(name: "衣類/下着", isChecked: goodsData[3]),
              ChecklistItem(name: "予備電池/携帯充電器", isChecked: goodsData[4]),
              ChecklistItem(name: "ラジオ", isChecked: goodsData[5]),
              ChecklistItem(name: "緊急用品", isChecked: goodsData[6]),
              ChecklistItem(name: "ブランケット", isChecked: goodsData[7]),
              ChecklistItem(name: "歯ブラシ", isChecked: goodsData[8]),
              ChecklistItem(name: "タオル", isChecked: goodsData[9]),
              ChecklistItem(name: "貴重品(通帳/パスポート/マイナンバー/etc...)", isChecked: goodsData[10]),
            ];

            _loading = false; // データ取得完了
          });
        }
      }
    } catch (e) {
      print("データ取得エラー: $e");
    }
  }

  // Firestoreにチェックリストデータを保存する関数
  Future<void> _updateChecklistData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('user').doc(uid).update({
          'check': _lists.map((item) => item.isChecked).toList(),
          'goods': _goods.map((item) => item.isChecked).toList(),
        });
      }
    } catch (e) {
      print("データ更新エラー: $e");
    }
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
            tabs: [
              Tab(text: "TODO"),
              Tab(text: "防災グッズ"),
            ],
            indicator: BoxDecoration(
              color: Color(Constant.mainColor),
              borderRadius: BorderRadius.circular(5),
            ),
            indicatorPadding: EdgeInsets.fromLTRB(-8.0, 6.0, -8.0, 6.0),
            overlayColor: MaterialStateProperty.all<Color>(
                Color(Constant.mainColor).withOpacity(0.2)),
          ),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
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
                        _updateChecklistData(); // Firestoreに変更を反映
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
                        _updateChecklistData(); // Firestoreに変更を反映
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
