import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prolife_service/models/partners_model.dart';
import '../global_widget/globle_screen.dart';
import 'booking_summery.dart';

class ServiceDetailsPage extends StatefulWidget {
  final PartnersModel product;

  const ServiceDetailsPage({super.key, required this.product});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Service Details"))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalWidget.ServiceDateilImage(
                    context, widget.product.workingImageUrl.toString()),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: 4.5,
                      itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 25,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '4.5',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                GlobalWidget.WorkNameText(
                  context,
                  widget.product.name,
                ),
                GlobalWidget.TextSpanTextOriginal(context,
                    widget.product.originalPrice, widget.product.discountPrice),
                GlobalWidget.WorkNameText(context, "Descriptions"),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "I am a complete fully cleaning work",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                GlobalWidget.WorkNameText(context, "About Service Provider"),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 50),
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
              Get.to(BookingSummaryScreen(
                product: widget.product,
              ));
            },
            child: const Text(
              "Booking Service",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
