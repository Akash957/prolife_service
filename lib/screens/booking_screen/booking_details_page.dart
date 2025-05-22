import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prolife_service/screens/booking_screen/vertical_step_progress_view.dart';
import 'package:prolife_service/screens/booking_screen/write_review.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../global_widget/globle_screen.dart';
import '../../models/booking_model.dart';
import '../../provider/review_provider.dart';
import '../../service/call_support.dart';

class BookingStates extends StatefulWidget {
  const BookingStates({super.key});

  @override
  _BookingStatesState createState() => _BookingStatesState();
}

class _BookingStatesState extends State<BookingStates> {
  final List<Map<String, String>> statusSteps = [
    {"status": "request", "desc": "You have successfully placed the order"},
    {"status": "conform", "desc": "Your service has been dispatched"},
    {"status": "complete", "desc": "Service delivered successfully"},
  ];

  List<Map<String, String>> getTimelineSteps(String currentStatus) {
    int currentIndex =
    statusSteps.indexWhere((step) => step['status'] == currentStatus);
    if (currentIndex == -1) currentIndex = 0;

    List<Map<String, String>> steps = [];
    for (int i = 0; i <= currentIndex; i++) {
      steps.add({
        'status': statusSteps[i]['status']!,
        'desc': statusSteps[i]['desc']!,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      });
    }
    return steps;
  }

  int getCurrentStep(String status) {
    switch (status) {
      case 'request':
        return 0;
      case 'conform':
        return 1;
      case 'complete':
        return 2;
      default:
        return 0;
    }
  }

  Widget buildBookingCard({
    required BuildContext context,
    required BookingModel booking,
  }) {
    final title = booking.serviceName;
    final originalPrice = booking.originalPrice;
    final discountPrice = booking.discountPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (booking.workingImageUrl.isNotEmpty)
                  GlobalWidget.BookingImage(context, booking.workingImageUrl)
                else
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: 3.5,
                            itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 20,
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
                      const SizedBox(height: 10),
                      Text("₹$originalPrice",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                color: Colors.blue, width: 1.5),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (_) => ReviewProvider(),
                                child: WriteReviewPage(booking: booking),
                              ),
                            ),
                          );
                        },
                        child: const Text("Write a Review",
                            style: TextStyle(fontSize: 16, color: Colors.blue)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Book Again Action
                        },
                        child: const Text("Book Again",
                            style:
                            TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text("About Service Provider",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: booking.profileImage.isNotEmpty
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(booking.profileImage),
                )
                    : const CircleAvatar(child: Icon(Icons.person)),
                title: Text(booking.name),
                subtitle: Text(booking.serviceName),
                trailing: IconButton(
                  icon: const Icon(Icons.call, color: Colors.blue),
                  onPressed: () {
                    callSupport();
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text("Booking Status",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            const SizedBox(height: 20),
            VerticalStepProgressView(
              curStep: getCurrentStep(booking.bookingStatus),
              steps: ['Order Placed', 'Dispatched', 'Delivered'],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Payment Summary",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            priceRow("Item Total", originalPrice),
            priceRow("Discount", discountPrice),
            const Divider(indent: 10, endIndent: 10, height: 30, thickness: 2),
            priceRow("Grand Total", originalPrice),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Booking')),
        body: const Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Booking')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user_bookings')
                .where('userId', isEqualTo: currentUser.uid)
                .orderBy('timestamp', descending: true)
                .limit(1)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No bookings found.'));
              }
              final bookingDoc = snapshot.data!.docs.first;
              final booking = BookingModel.fromDocument(bookingDoc);
              return buildBookingCard(context: context, booking: booking);
            },
          ),
        ),
      ),
    );
  }

  Widget priceRow(String text, String price, {bool free = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: free ? Colors.blue : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            free ? "Free" : "₹$price",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: free ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
