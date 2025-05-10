import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../global_widget/globle_screen.dart';
import '../../models/booking_model.dart';

class CustomColors {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.blue;
  static const Color white = Colors.white;
}
class BookingStates extends StatefulWidget {
  const BookingStates({super.key});

  @override
  _BookingStatesState createState() => _BookingStatesState();
}

class _BookingStatesState extends State<BookingStates> {
  // Your steps are now part of the state.
  final List<Map<String, String>> steps = [
    {
      "date": "2025-05-08",
      "time": "10:00 AM",
      "status": "Order Placed",
      "desc": "You have successfully placed the order",
    },
    {
      "date": "2025-05-09",
      "time": "2:00 PM",
      "status": "Dispatched",
      "desc": "Your package has been dispatched",
    },
    {
      "date": "2025-05-10",
      "time": "6:00 PM",
      "status": "Delivered",
      "desc": "Package delivered at your doorstep",
    },
  ];
  Widget buildBookingCard({
    required BuildContext context,
    required BookingModel booking,
  }) {
    var heightScreen = MediaQuery.of(context).size.height;
    final title = booking.serviceName;
    final originalPrice = booking.originalPrice;
    final discountPrice = booking.discountPrice;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (booking.imageUrl.isNotEmpty)
                  GlobalWidget.BookingImage(context, booking.imageUrl),
                ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: 3.5,
                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
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
                    const SizedBox(height: 15),
                    Text("₹$originalPrice", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  ],
                ),
              ]
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.blue, width: 1.5),
                          ),
                        ),
                        onPressed: () {
                          // Add your logic to navigate to a review page
                        },
                        child: const Text("Write a Review", style: TextStyle(fontSize: 18, color: Colors.blue)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Add your logic to book again
                        },
                        child: const Text("Book Again", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: const Text("About Service Provider", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            SizedBox(
              height:heightScreen*0.11,
              child: Card(
                elevation: 0.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    CircleAvatar(
                      backgroundImage: NetworkImage(booking.profileImage),
                      radius: 24,
                    ),
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(booking.useName),
                        Text(booking.serviceName),
                      ],
                    ),
                    Spacer(),
                    Card(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call, color: Colors.white),
                      ),
                    ),

                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.blue, width: 1.5),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.message, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Booking Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    SizedBox(
                      height: heightScreen*0.40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ListView.builder(
                            itemCount: steps.length,
                            itemBuilder: (context, index) {
                              return TimelineTile(
                                alignment: TimelineAlign.start,
                                isFirst: index == 0,
                                isLast: index == steps.length - 1,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  indicator: Material(
                                    elevation: 4,
                                    shape: const CircleBorder(),
                                    color: CustomColors.primary,
                                    child: const SizedBox(
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: CustomColors.primary,
                                  thickness: 2,
                                ),
                                afterLineStyle: const LineStyle(
                                  color: CustomColors.primary,
                                  thickness: 2,
                                ),
                                endChild: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        steps[index]['status']!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        steps[index]['desc']!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${steps[index]['date']} at ${steps[index]['time']}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Payment Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ),

                    priceRow("Item Total",originalPrice ),
                    priceRow("Discount", discountPrice),
                    // priceRow("Service Fee" free: true),
                    const Divider(
                        indent: 10, endIndent: 10, height: 30, thickness: 2),
                    priceRow("Grand Total", originalPrice),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user_bookings')
                    .orderBy('timestamp', descending: true)
                    .limit(1) // 👉 Only get the latest booking
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No bookings found.'));
                  }
                  final bookingDoc = snapshot.data!.docs.first;
                  final booking = BookingModel.fromDocument(bookingDoc);

                  return buildBookingCard(
                    context: context,
                    booking: booking,
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget priceRow(String text, String price, {bool free = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 20, color: free ? Colors.blue : Colors.black,fontWeight: FontWeight.bold)),
          Spacer(),
          Text(free ? "Free" : "₹$price",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: free ? Colors.blue : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

