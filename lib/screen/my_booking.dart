import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models_booking.dart';
import '../provider/booking_provider.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({super.key});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<BookingProvider>(context, listen: false).fetchBookings();
  }

  Widget buildBookingCard(Booking booking) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: booking.statusColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                booking.status,
                style: TextStyle(
                  color: booking.statusTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              booking.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              booking.dateTime,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.blue, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      "Amount Paid ${booking.amount}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                if (booking.showButton)
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text("Book Again"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("My Booking", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookingProvider.bookings.length,
        itemBuilder: (context, index) {
          final booking = bookingProvider.bookings[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(booking.category,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              buildBookingCard(booking),
            ],
          );
        },
      ),
    );
  }
}
