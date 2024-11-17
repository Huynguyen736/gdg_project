import 'package:firebase_messaging/firebase_messaging.dart';

class Message {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotidications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");
  }

}