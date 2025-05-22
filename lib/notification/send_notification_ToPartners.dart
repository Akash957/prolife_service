import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'get_service_key.dart';

class SendNotificationToUser{
  var baseUrl = "https://fcm.googleapis.com/v1/projects/image-uplode-4d545/messages:send";
  Future<void> sendNotificationToUser({
    required String token,
    required String title,
    required String message,
    required String otherUid,}) async {
    String? serverKey = await GetServerKey().getServerKeyToken();
    var header = <String, String>{
      'Content_Type': 'secret_key.json',
      'Authorization': 'Bearer $serverKey',
    };
    Map<String,dynamic> body = {
      "message":{
        "token":token,
        "notification":{
          "body":message,
          "title":title,
        }
      }
    };
    try{
      http.Response response = await http.post(
        Uri.parse(baseUrl),
        headers : header,
        body: jsonEncode(body),
      );
      if(response.statusCode == 200){
        Fluttertoast.showToast(msg: "Send Notification success",toastLength:Toast.LENGTH_LONG,backgroundColor: Colors.blue);

      }else{
        Fluttertoast.showToast(msg: "failed to Send Notification ",toastLength:Toast.LENGTH_LONG,backgroundColor: Colors.blue);
      }
    }catch(e){
      Fluttertoast.showToast(msg: "Expectation $e");
    }
    }
}