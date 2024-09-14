import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_escape/constant/constant.dart';

import 'package:home_escape/main.dart';
import './start.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:home_escape/constant/constant.dart';

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

  @override
  Widget build(BuildContext context) {
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
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'password',
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
                            // 3行目 ユーザ登録ボタン
                            ElevatedButton(
                              child: const Text('ユーザ登録'),
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
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            // 4行目 ログインボタン
                            ElevatedButton(
                              child: const Text('ログイン'),
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
                                } catch (e) {
                                  print("えらーだよ！");
                                  print(e);
                                }
                              },
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
