import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dateBox(String day, String date,bool isSelected,VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,

    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isSelected? Colors.blue:   CupertinoColors.opaqueSeparator,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "$day\n$date",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,
              color: isSelected?Colors.white:Colors.black),
        ),
      ),
    ),
  );
}
Widget timeBox(String time, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 69,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : CupertinoColors.opaqueSeparator,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}


