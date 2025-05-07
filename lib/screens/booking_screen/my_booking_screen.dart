  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'booking_details_page.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  Widget buildBookingCard({
    required String status,
    required Color statusColor,
    required Color statusBgColor,
    required String title,
    required String dateTime,
    String? amountPaid,
    required BuildContext context,
    bool showBookAgain = false,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dateTime,
              style: const TextStyle(color: Colors.grey),
            ),
            if (amountPaid != null) ...[
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.blue),
                      SizedBox(width: 6),
                    ],
                  ),
                  Text(
                    amountPaid,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  if (showBookAgain)
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.to(() => const BookingDetailsPage());
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        child: Text(
                          'Book Again',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("Carpenters",
                style: TextStyle(fontWeight: FontWeight.bold)),
            buildBookingCard(
              status: "JOB COMPLETED",
              statusColor: Colors.blue,
              statusBgColor: Colors.blue.shade50,
              title: "Living Room Cleaning",
              dateTime: "Mon, Mar 28, 2025 at 10:00 AM",
              amountPaid: "Amount Paid ₹190",
              showBookAgain: true,
              context: context,
            ),
            const SizedBox(height: 8),
            const Text("Plumbers",
                style: TextStyle(fontWeight: FontWeight.bold)),
            buildBookingCard(
              status: "BOOKING CANCELLED",
              statusColor: Colors.red,
              statusBgColor: Colors.red.shade100,
              title: "Flush Tank Repair",
              dateTime: "Mon, Mar 25, 2025 at 11:00 AM",
              context: context,
            ),
            const SizedBox(height: 8),
            const Text("Carpenters",
                style: TextStyle(fontWeight: FontWeight.bold)),
            buildBookingCard(
                status: "JOB COMPLETED",
                statusColor: Colors.blue,
                statusBgColor: Colors.blue.shade50,
                title: "Main Door Repair",
                dateTime: "Mon, Mar 25, 2025 at 11:00 AM",
                amountPaid: "Amount Paid ₹290",
                showBookAgain: true,
                context: context),
          ],
        ),
      ),
    );
  }
}
