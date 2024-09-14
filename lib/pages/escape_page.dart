import 'package:flutter/material.dart';

class EscapePage extends StatelessWidget {
  const EscapePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height; //端末の縦の大きさを取得
    final double deviceWidth = MediaQuery.of(context).size.width; //端末の横の大きさを取得
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '避難指示',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFF38D49),
      ),
      body: const Column(
        children: [
          Text(
            '落ち着いて以下の行動をとってください',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1.',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '机の下に隠れてください',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2.',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '屋外にいる場合は建物に近づかないでください',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
