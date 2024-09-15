import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_escape/constant/constant.dart';

import 'package:home_escape/main.dart';
import 'package:home_escape/pages/sign_in.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight =
        MediaQuery.of(context).size.height; //端末の縦の大きさを取得
    final double deviceWidth = MediaQuery.of(context).size.width; //端末の横の大きさを取得

    return Scaffold(
      backgroundColor: Color(Constant.mainColor),
      body: GestureDetector(
        onTap: () {
          // 画面をタップしたときにログインページに遷移
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUp()),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Center(
                // ロゴ画像を中央に配置
                child: Container(
                  width: deviceHeight * 0.4,
                  child: Image.asset('assets/images/icon.png'),
                ),
              ),
            ),
            const Text(
              '- 画面をタップしてスタート -',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
