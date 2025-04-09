import 'package:flutter/material.dart';

import '../globle_widget/globle_screen.dart';

class ClickOnCategories extends StatefulWidget {
  const ClickOnCategories({super.key});

  @override
  State<ClickOnCategories> createState() => _ClickOnCategoriesState();
}

class _ClickOnCategoriesState extends State<ClickOnCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 25,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              GlobleWidget.WorkNameText(context, "Cleaner"),
              Spacer(),
              GlobleWidget.ClickIcon(() {
              }, context,Icons.search),
              SizedBox(width: 10,),
              GlobleWidget.ClickIcon(() {}, context,Icons.shopping_cart_outlined),
            ],),
          ),
        ],
      ),
    );
  }
}
