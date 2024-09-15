import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_escape/constant/constant.dart';

import 'package:home_escape/main.dart';
import './start.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _ProfileData {
  String email = '';
  String emailAgain = '';
  String pass = '';
  String passAgain = '';
}

// 必須チェック
FormFieldValidator _requiredValidator(BuildContext context) =>
    (val) => val.isEmpty ? "必須" : null;

class _SignUpState extends State<SignUp> {
  //メールアドレス・パスワード
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    // Firebaseの初期化を行う
    Firebase.initializeApp();
  }

  // 新規作成時Firestoreにユーザーデータを登録する関数
  Future<void> _newUserCheckData(
    User? user,
    String? name,
    String place,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(user?.uid).set({
        'name': name,
        'place': place,
        'check': List.generate(9, (_) => false),
        'goods': List.generate(11, (_) => false),
      });
      print("ユーザーデータを登録したよ");
    } catch (e) {
      print("ユーザーデータの保存失敗！");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height; //端末の縦の大きさを取得
    final double deviceWidth = MediaQuery.of(context).size.width; //端末の横の大きさを取得
    return Scaffold(
      body: Container(
        color: Color(Constant.backGroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              //アイコン用Column
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
//                  decoration: BoxDecoration(
//                    color: const Color.fromARGB(255, 111, 111, 111),
//                    borderRadius: BorderRadius.circular(10),
//                  ),
                  child: const Icon(
                    IconData(0xee35, fontFamily: 'MaterialIcons'),
                    color: Color(Constant.mainColor),
                    size: 150,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Form(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 32.0,
                          bottom: 20.0,
                          left: 16.0,
                          right: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            //eメール入力フォーム(ノーマル)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'email',
                                labelStyle: TextStyle(
                                    color: Color(Constant.mainFontColor)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(Constant
                                        .accentColor), // フォーカスされたときの枠線の色
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Color(Constant.mainColor), // 通常時の枠線の色
                                  ),
                                ),
                              ),
                              validator: _requiredValidator(context),
                              maxLength: 100,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              onChanged: (String value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                            ),
                            const SizedBox(height: 5.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'password',
                                labelStyle: TextStyle(
                                    color: Color(Constant.mainFontColor)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(Constant
                                        .accentColor), // フォーカスされたときの枠線の色
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Color(Constant.mainColor), // 通常時の枠線の色
                                  ),
                                ),
                              ),
                              validator: _requiredValidator(context),
                              maxLength: 100,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              onChanged: (String value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                            ),
                            const SizedBox(height: 40.0),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center, // ボタンを中央に配置
                              //test
                              children: [
                                // 3行目 ユーザ登録ボタン
                                ElevatedButton(
                                  child: const Text('ユーザ登録'),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(deviceWidth * 0.3,
                                          deviceHeight * 0.1),
                                      backgroundColor:
                                          Color(Constant.accentColor),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () async {
                                    try {
                                      final User? user = (await FirebaseAuth
                                              .instance
                                              .createUserWithEmailAndPassword(
                                                  email: _email,
                                                  password: _password))
                                          .user;
                                      if (user != null)
                                        print(
                                            "ユーザ登録しました ${user.email} , ${user.uid}");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(
                                                    title: 'HomePage')),
                                      );
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                ),
                                SizedBox(width: deviceWidth * 0.1),
                                // 4行目 ログインボタン
                                ElevatedButton(
                                  child: const Text('ログイン'),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(deviceWidth * 0.3,
                                          deviceHeight * 0.1),
                                      backgroundColor:
                                          Color(Constant.mainColor),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () async {
                                    try {
                                      // メール/パスワードでログイン
                                      final User? user = (await FirebaseAuth
                                              .instance
                                              .signInWithEmailAndPassword(
                                                  email: _email,
                                                  password: _password))
                                          .user;
                                      if (user != null)
                                        print(
                                            "ログインしました　${user.email} , ${user.uid}");

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(
                                                    title: 'HomePage')),
                                      );
                                    } catch (e) {
                                      print("えらーだよ！");
                                      print(e);
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IsLogined extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //stream: FirebaseAuth.instance.authStateChanges(),
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (snapshot.hasData) {
          // Userデータがあるので、ユーザー情報表示画面へ
          return HomePage(title: 'HomePage');
        }
        // Userデータがないので、サインイン画面へ
        return const SignUp();
      },
    );
  }
}
