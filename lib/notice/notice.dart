import 'package:firebase_messaging/firebase_messaging.dart';

class Notice {
  Future getDeviceToken() async{
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? DeviceToken = await _firebaseMessage.getToken();
    return (DeviceToken == null) ? "" : DeviceToken;
  }
}