import 'package:flutter/material.dart';
import 'package:home_escape/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String isSelectedValue = '沖縄県';
  List<String> choices = <String>[
    '沖縄県',
    '三重県',
    '愛知県',
    '北海道',
  ];
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
        final userDoc =
            await FirebaseFirestore.instance.collection('user').doc(uid).get();
        print(userDoc.data());

        if (userDoc.exists) {
          final checkData = List<bool>.from(
              userDoc.data()?['check'] ?? List.filled(9, false));
          final goodsData = List<bool>.from(
              userDoc.data()?['goods'] ?? List.filled(11, false));

          _loading = false; // データ取得完了
        }
        ;
      }
    } catch (e) {
      print("データ取得エラー: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'アカウント',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFF38D49),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: Constant.deviceHeight * 0.06),
                const Icon(
                  IconData(0xee35, fontFamily: 'MaterialIcons'),
                  color: Color(0xFFF38D49),
                  size: 150,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('よしにき', style: TextStyle(fontSize: 30)),
                ),
                SizedBox(height: Constant.deviceHeight * 0.17),
                showEmail(),
                SizedBox(height: Constant.deviceHeight * 0.03),
                showLocation(),
                const SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showEmail() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: Constant.deviceWidth * 0.13),
            const Text('mail',
                style: TextStyle(
                  fontSize: 20,
                )),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'motoki@gmail.com',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Color(0xFF040404),
        ),
      ],
    );
  }

  Widget showLocation() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: Constant.deviceWidth * 0.13),
            const Text('所在地',
                style: TextStyle(
                  fontSize: 20,
                )),
          ],
        ),
        const SizedBox(height: 10),
        pullDown(),
        const SizedBox(height: 10),
        const Divider(
          color: Color(0xFF040404),
        ),
      ],
    );
  }

  Widget pullDown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF040404)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: choices.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: isSelectedValue,
          onChanged: (String? value) {
            setState(() {
              isSelectedValue = value!;
            });
          },
        ),
      ),
    );
  }
}
