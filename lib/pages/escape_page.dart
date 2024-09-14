import 'package:flutter/material.dart';
import 'package:home_escape/constant/constant.dart';

class EscapePage extends StatelessWidget {
  const EscapePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width; // 端末の横の大きさを取得
    final double horizontalPadding = deviceWidth * 0.1;

    // 指示のリストを作成
    final List<String> firstInstruct = [
      '机の下に隠れてください',
      '屋外にいる場合は建物に近づかないでください',
      '可能であればガスの元栓を占めてください',
      '外に出られるドア、または窓を開けてください',
    ];

    final List<String> secondInstruct = [
      '枕元に用意した靴を履いてください',
      '火元を確認してください。出火していた場合初期消火を試みてください。無理な場合はすぐに逃げてください',
      '災害バッグを用意してください。ない場合はすぐに近くの避難所に避難してください',
      '近くの避難所に避難してください。大きな建物やブロック塀などをなるべく避けて避難してください',
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '避難指示',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFF38D49),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const Text(
              '落ち着いて以下の行動をとってください',
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 40),

            // 指示を動的に表示
            ...firstInstruct.asMap().entries.map((entry) {
              int index = entry.key;
              String instruction = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  // margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(Constant.mainColor)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}.',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          instruction, // リスト内の指示を表示
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 30),

            // 地震が収まった場合の表示
            const Text(
              '地震が収まった場合',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),

            // 指示を動的に表示
            ...secondInstruct.asMap().entries.map((entry) {
              int index = entry.key;
              String instruction = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}.',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        instruction, // リスト内の指示を表示
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
