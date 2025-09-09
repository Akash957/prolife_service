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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Service Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalWidget.ServiceDateilImage(
                context,
                widget.product.workingImageUrl.toString(),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: 4.5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(50 Reviews)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GlobalWidget.WorkNameText(
                context,
                widget.product.workType,
              ),
              const SizedBox(height: 8),
              GlobalWidget.TextSpanTextOriginal(
                context,
                widget.product.originalPrice,
                widget.product.discountPrice,
              ),
              const SizedBox(height: 15),
              GlobalWidget.WorkNameText(context, "Descriptions"),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Text(
                  "I am a complete fully cleaning work",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "About Service Provider",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GlobalWidget.BestServicesCircleAvatar2(
                      context, widget.product.profileImage),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.product.partnerName}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${widget.product.workType}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Reviews",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              _reviewCard(
                name: "Vikas Kumar",
                rating: 5,
                date: "29-03-2025",
                comment:
                    "I can't say in words, this electrician is amazing. He made all my electrical work perfect.",
              ),
              const SizedBox(height: 10),
              _reviewCard(
                name: "Chhotu Kumar",
                rating: 4,
                date: "29-03-2025",
                comment:
                    "He is better than other electricians. His work impressed me a lot.",
              ),
              const SizedBox(height: 80), // Space for bottom button
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.to(BookingSummaryScreen(
                product: widget.product,
              ));
            },
            child: const Text(
              "Book Service",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _reviewCard({
    required String name,
    required double rating,
    required String date,
    required String comment,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/image/default_profile.png'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 18,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    comment,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
