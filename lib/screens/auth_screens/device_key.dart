import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _fcm = FirebaseMessaging();

get_device_token() {
  String device_key;
  // To get and store the device key during registration for FCM
  _fcm.getToken().then((token) {
    device_key = token;
    print('The device token is:' + device_key);
    return device_key;
  });
}
