import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height; //端末の縦の大きさを取得

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
        body: Center(
          child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.06),
              const Icon(
                  IconData(0xee35, fontFamily: 'MaterialIcons'),
                  color: Color(0xFFF38D49),
                  size: 150,
                ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child:  Text(
                  'よしにき',
                  style: TextStyle(fontSize: 30)
                ),
              ),

              showEmail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showEmail(){
    return const Column(
      children: [
        Row(
          children: [
            Text(
              'mail'
            ),
          ],
        ),
      ],
    );
  }
}
