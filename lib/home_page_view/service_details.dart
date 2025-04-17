import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../global_widget/globle_screen.dart';
import '../models/partner.dart';
import 'booking_summery.dart';

class ServiceDetailsPage extends StatefulWidget {
  final PartnerModel product;
  const ServiceDetailsPage({super.key,required this.product});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Service Details"))),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalWidget.ServiceDateilImage(
                    context, widget.product.imageUrl),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: RatingBar.builder(
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Colors.blue),
                    onRatingUpdate: (rating) {
                      print('User selected rating: $rating');
                    },
                  ),
                ),
                GlobalWidget.WorkNameText(
                  context,
                  widget.product.name,
                ),
                // GlobalWidget.TextSpanTextOriginal(
                //     context, widget.product, widget.product.price2),
                GlobalWidget.WorkNameText(context, "Descriptions"),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "I am a complete fully cleaning work",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                GlobalWidget.WorkNameText(
                    context, "About Service Provider"),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 250,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ), // Border radius 5
              ),
            ),
            onPressed: () {
              Get.to(BookingSummaryScreen());
            },
            child: Text(
              "Booking Service",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

