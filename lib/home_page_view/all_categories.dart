import 'package:flutter/material.dart';

import '../globle_widget/globle_screen.dart';
import 'click_on_categories.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 25,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              GlobleWidget.WorkNameText(context, "All Categories"),
              Spacer(),
              GlobleWidget.ClickIcon(() {}, context, Icons.search),
              SizedBox(width: 10,),
              GlobleWidget.ClickIcon(() {}, context,
                  Icons.shopping_cart_outlined),
            ],),
          ),
          Expanded(child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                GlobleWidget.AllCategoryImage(
                  context,
                  "Carpenter",
                  "20 Service",
                  "assets/image/carpernter_bc.png",
                      () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ClickOnCategories(),));
                  },

                ),
                GlobleWidget.AllCategoryImage(
                  context,
                  "Cleaner",
                  "14 Service",
                  "assets/image/cliner.png",
                      () {},

                ),
                GlobleWidget.AllCategoryImage(
                  context,
                  "Painter",
                  "8 Service",
                  "assets/image/painter_bc.png",
                      () {},

                ),
                GlobleWidget.AllCategoryImage(
                  context,
                  "Electrician",
                  "15 Service",
                  "assets/image/electric_bc.png",
                      () {},

                ),
                GlobleWidget.AllCategoryImage(
                  context,
                  "Ac Repair",
                  "10 Service",
                  "assets/image/ac_repairing_bc.png",
                      () {},

                ),
                GlobleWidget.AllCategoryImage(
                  context,
                  "Plumber",
                  "25 Service",
                  "assets/image/plumber.png",
                      () {},

                ),
                GlobleWidget.AllCategoryImage(
                  context,
                  "Men's Salon",
                  "5 Service",
                  "assets/image/salon.jpeg",
                      () {},

                ),

              ],
            ),
          ))

        ],
      ),
    );
  }
}
