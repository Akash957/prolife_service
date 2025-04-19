import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import '../models/partners_model.dart';

class BookingSummaryScreen extends StatefulWidget {
  final PartnersModel product;
  const BookingSummaryScreen({super.key,required this.product});


  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final categoryController = Get.put(GetService());
  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Booking Summary")),
      body: Column(
        children: [
        Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalWidget.BookingImage(
              context,widget.product.imageUrl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              GlobalWidget.WorkNameText(context,widget.product.name),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RatingBar.builder(
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.blue),
                  onRatingUpdate: (rating) {
                  },
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 5,),
                  // Text("₹${product.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                  SizedBox(width: 80),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(
                            5,
                          ), // Border radius yahan set hota hai
                        ),
                        child: Divider(
                          color: Colors.white,
                          endIndent: 8,
                          thickness: 3,
                          indent: 8,
                        ),
                      ),
                      SizedBox(width: 20),
                      GlobalWidget.IncreaseDecreaseButton(
                            () {},
                        context,
                        Icons.add,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

        ],
      ),
    );
  }
}
