

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../global_widget/globle_screen.dart';

class ClickOnCategories extends StatefulWidget {
  const ClickOnCategories({super.key});

  @override
  State<ClickOnCategories> createState() => _ClickOnCategoriesState();
}

class _ClickOnCategoriesState extends State<ClickOnCategories> {
  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(actionsIconTheme: IconThemeData(size: 30),toolbarHeight: 45,title:Center(child: Text("Cleaner",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),actions: [
        GlobalWidget.ClickIcon(() {
        }, context,Icons.search),
        SizedBox(width: 25,)

      ],),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: heightScreen * 0.4,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalWidget.ReferImage(
                          context,
                          "https://wpblogassets.paytm.com/paytmblog/uploads/2021/12/25_Refer_Win_Paytms-Refer-_-Earn-Refer-a-friend-and-earn-guaranteed-cashback.jpg",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: RatingBar.builder(
                            // minRating: 0,
                            // direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            onRatingUpdate: (rating) {
                              print('User selected rating: $rating');
                            },
                          ),
                        ),
                        GlobalWidget.WorkNameText(
                            context, "Complete Kitchen Cleaning"),
                        Row(
                          children: [
                            GlobalWidget.TextSpanTextOriginal(
                                context, "150", "50"),
                            Spacer(),
                            GlobalWidget.ServicesProvideAddButton(
                                    () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailsPage(),));
                                }, context, "Add")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: heightScreen * 0.4,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalWidget.ReferImage(
                          context,
                          "https://wpblogassets.paytm.com/paytmblog/uploads/2021/12/25_Refer_Win_Paytms-Refer-_-Earn-Refer-a-friend-and-earn-guaranteed-cashback.jpg",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: RatingBar.builder(
                            // minRating: 0,
                            // direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            onRatingUpdate: (rating) {
                              print('User selected rating: $rating');
                            },
                          ),
                        ),
                        GlobalWidget.WorkNameText(
                            context, "Complete Kitchen Clinaning"),
                        Row(
                          children: [
                            GlobalWidget.TextSpanTextOriginal(
                                context, "150", "50"),
                            Spacer(),
                            GlobalWidget.ServicesProvideAddButton(
                                    () {}, context, "Add")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: heightScreen * 0.4,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalWidget.ReferImage(
                          context,
                          "https://wpblogassets.paytm.com/paytmblog/uploads/2021/12/25_Refer_Win_Paytms-Refer-_-Earn-Refer-a-friend-and-earn-guaranteed-cashback.jpg",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: RatingBar.builder(
                            // minRating: 0,
                            // direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            onRatingUpdate: (rating) {
                              print('User selected rating: $rating');
                            },
                          ),
                        ),
                        GlobalWidget.WorkNameText(
                            context, "Complete Kitchen Clinaning"),
                        Row(
                          children: [
                            GlobalWidget.TextSpanTextOriginal(
                                context, "150", "50"),
                            Spacer(),
                            GlobalWidget.ServicesProvideAddButton(
                                    () {}, context, "Add")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: heightScreen * 0.4,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalWidget.ReferImage(
                          context,
                          "https://wpblogassets.paytm.com/paytmblog/uploads/2021/12/25_Refer_Win_Paytms-Refer-_-Earn-Refer-a-friend-and-earn-guaranteed-cashback.jpg",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: RatingBar.builder(
                            // minRating: 0,
                            // direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            onRatingUpdate: (rating) {
                              print('User selected rating: $rating');
                            },
                          ),
                        ),
                        GlobalWidget.WorkNameText(
                            context, "Complete Kitchen Clinaning"),
                        Row(
                          children: [
                            GlobalWidget.TextSpanTextOriginal(
                                context, "150", "50"),
                            Spacer(),
                            GlobalWidget.ServicesProvideAddButton(
                                    () {}, context, "Add")
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ))
        ],
      ),
    );
  }
}
