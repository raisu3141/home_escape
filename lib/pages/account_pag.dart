import 'package:flutter/material.dart';
import 'package:home_escape/constant/constant.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
        body: Center(
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
                child:  Text(
                  'よしにき',
                  style: TextStyle(fontSize: 30)
                ),
              ),

              SizedBox(height: Constant.deviceHeight * 0.1),
              showEmail(),
              SizedBox(height: Constant.deviceHeight * 0.03),
              showLocation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showEmail(){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: Constant.deviceWidth * 0.13),
            const Text(
              'mail',
              style: TextStyle(
                fontSize: 20,
              )
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'motoki@gmail.com',
          style: TextStyle(
            fontSize: 20
          ),
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Color(0xFF040404),
        ),
      ],
    );
  }

  Widget showLocation(){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: Constant.deviceWidth * 0.13),
            const Text(
              '所在地',
              style: TextStyle(
                fontSize: 20,
              )
            ),
          ],
        )
      ],
    );
  }
}
