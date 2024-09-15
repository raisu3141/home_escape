import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_escape/constant/constant.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String isSelectedValue = '沖縄県'; // Default value
  String email = ''; // Placeholder for the user's email
  List<String> choices = <String>[
    '沖縄県',
    '三重県',
    '愛知県',
    '北海道',
  ];

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user's data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            email = user.email ?? 'No email found'; // Get user's email
            isSelectedValue = userDoc['place'] ?? isSelectedValue; // Get location
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _updateUserLocation(String newLocation) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .update({'place': newLocation});
        print('Location updated to $newLocation');
      }
    } catch (e) {
      print('Error updating location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'アカウント',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFF38D49),
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
              const SizedBox(height: 10),
              showEmail(),
              const SizedBox(height: 30),
              showLocation(),
              const SizedBox(height: 60),
            ],
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
            const Text(
              'メールアドレス',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          email,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        const Divider(color: Color(0xFF040404)),
      ],
    );
  }

  Widget showLocation() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: Constant.deviceWidth * 0.13),
            const Text(
              '所在地',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: 10),
        pullDown(),
        const SizedBox(height: 10),
        const Divider(color: Color(0xFF040404)),
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
              _updateUserLocation(value); // Update Firestore with new location
            });
          },
        ),
      ),
    );
  }
}
