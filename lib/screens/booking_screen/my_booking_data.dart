import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.blue.shade50;
      case 'cancelled':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return '';
    final dateTime = timestamp.toDate();
    return DateFormat('EEE, MMM d, yyyy – hh:mm a').format(dateTime);
  }
  Widget buildBookingCard({
    required BuildContext context,
    required Map<String, dynamic> data,
    required String docId,
  }) {
    final status = data['status'] ?? 'Unknown';
    final title = data['serviceName'] ?? 'No Title';
    final amountPaid = data['originalPrice'] != null
        ? "Amount Paid ₹${data['originalPrice']}"
        : null;
    final timestamp = _formatTimestamp(data['timestamp']);

    return Card(
      color: Colors.red,
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
                color: _getStatusBgColor(status),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status.toUpperCase(),
                style: TextStyle(
                  color: _getStatusColor(status),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              timestamp, style: const TextStyle(color: Colors.grey),),
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
                  Text(amountPaid, style: const TextStyle(fontWeight: FontWeight.w500),
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
        title: const Text('My Bookings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_bookings')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No bookings found.'));
            }

            final bookings = snapshot.data!.docs;

            final paidBookings = bookings
                .where((doc) =>
                    (doc.data() as Map<String, dynamic>)['status']
                        ?.toString()
                        .toLowerCase() ==
                    'paid')
                .toList();

            final cancelledBookings = bookings
                .where((doc) =>
                    (doc.data() as Map<String, dynamic>)['status']
                        ?.toString()
                        .toLowerCase() ==
                    'cancelled')
                .toList();

            return ListView(
              children: [
                if (paidBookings.isNotEmpty) ...[
                  const Text("✅ Completed Bookings",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ...paidBookings.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return buildBookingCard(
                      context: context,
                      data: data,
                      docId: doc.id,
                    );
                  }),
                  const SizedBox(height: 20),
                ],
                if (cancelledBookings.isNotEmpty) ...[
                  const Text("❌ Cancelled Bookings",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ...cancelledBookings.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return buildBookingCard(
                      context: context,
                      data: data,
                      docId: doc.id,
                    );
                  }),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
