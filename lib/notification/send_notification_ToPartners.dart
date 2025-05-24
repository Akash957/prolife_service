import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SendNotificationToPartners {
  var baseUrl =
      "https://fcm.googleapis.com/v1/projects/image-uplode-4d545/messages:send";

  Future<void> sendNotificationToPartners({
    required String token,
    required String title,
    required String message,
    required String otherUid,
  }) async {
    String? serverKey = await GetServerKey().getServerKeyToken();
    var header = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };
    Map<String, dynamic> body = {
      "message": {
        "token": token,
        "notification": {
          "body": message,
          "title": title,
        }
      }
    };
    try {
      http.Response response = await http.post(
        Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode(body),
      );
      print(response);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Notification sent successfully",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.blue,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to send notification: ${response.statusCode}",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    }
  }
}
