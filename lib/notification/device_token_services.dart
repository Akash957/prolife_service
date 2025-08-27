import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeviceTokenServices {
  final partnerDeviceToken = FirebaseFirestore.instance.collection("partnerDeviceToken");

  Future<void> storeDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'deviceToken': token,
      });
      print(' Device token stored in Firestore: $token');
      await partnerDeviceToken.doc(uid).set({'deviceToken': token},SetOptions(merge: true));
    }
    else {
      print(' Failed to get device token');
    }
  }

  static Future<String?> getDeviceToken(String partnerId) async {
    final doc = await FirebaseFirestore.instance
        .collection('partners')
        .doc(partnerId)
        .get();

    if (doc.exists) {
      return doc.data()?['deviceToken'];
    }
    return null;
  }
}
