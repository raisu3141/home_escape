import 'package:flutter/material.dart';
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
            MaterialPageRoute(builder: (context) => const SignUp()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: deviceHeight * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // ロゴ画像
              child: Center(
                child: Container(
                  child: Image.asset('assets/images/icon.png'),
                  width: deviceHeight * 0.4,
                ),
              ),
            ),
            // SizedBox(height: deviceHeight * 0.03),
            // Padding(
            //     // ログインスタートボタン
            //     padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            //     child: Center(
            //       child: ElevatedButton(
            //         onPressed: () {
            //           // toDo: ボタンを押すとログインページに遷移
            //           Navigator.pushReplacement(
            //             context,
            //             MaterialPageRoute(builder: (context) => const SignUp()),
            //           );
            //         },
            //         style: ElevatedButton.styleFrom(
            //           fixedSize: Size(deviceWidth * 0.75, deviceHeight * 0.09),
            //           backgroundColor: Colors.white,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             // side: BorderSide(
            //             //   color: Colors.white, // 枠線の色を白に設定
            //             //   width: 2, // 枠線の太さを設定（例: 2）
            //             // ),
            //           ),
            //         ),
            //         child: Text(
            //           'ログイン',
            //           style: TextStyle(
            //             fontSize: 30,
            //             color: Color(Constant.mainColor),
            //           ),
            //         ),
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }
}
