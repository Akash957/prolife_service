import 'package:flutter/cupertino.dart';

Widget dateBox(String day, String date) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 6),
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: CupertinoColors.opaqueSeparator,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        "$day\n$date",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
Widget timeBox(String day) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    width: 69,
    height: 40,
    decoration: BoxDecoration(
      color: CupertinoColors.opaqueSeparator,
      borderRadius: BorderRadius.circular(2),
    ),
    child: Center(
      child: Text(
        "$day",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

