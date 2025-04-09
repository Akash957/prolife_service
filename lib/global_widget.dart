import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalWidgetAll{
  static TextFunction(String text){
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    );

  }
}
