import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'request':
        return Colors.blue;
      case 'conform':
        return Colors.orange;
      case 'complete':
        return Colors.green;
      case 'reject':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'request':
        return Colors.blue.shade50;
      case 'conform':
        return Colors.orange.shade100;
      case 'complete':
        return Colors.green.shade100;
      case 'reject':
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
    final status = data['booking_status'] ?? 'Unknown';
    final title = data['serviceName'] ?? 'No Title';
    final amountPaid = data['originalPrice'] != null
        ? "Amount Paid ₹${data['originalPrice']}"
        : null;
    final timestamp = _formatTimestamp(data['timestamp']);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
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
              timestamp,
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
                      Text('Payment Success',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Text(
                    amountPaid,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      debugPrint("No authenticated user found.");
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    debugPrint("Fetching bookings for userId: ${currentUser.uid}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('My Bookings',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_bookings')
              .where('userId', isEqualTo: currentUser.uid)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              debugPrint("StreamBuilder error: ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              debugPrint("No bookings found for userId: ${currentUser.uid}");
              return const Center(child: Text('No bookings found.'));
            }

            final bookings = snapshot.data!.docs;
            debugPrint(
                "Found ${bookings.length} bookings for userId: ${currentUser.uid}");

            final orderPlacedBookings = bookings.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final status = data['booking_status'] ?? '';
              return status.toLowerCase() == 'request';
            }).toList();

            final dispatchedBookings = bookings.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final status = data['booking_status'] ?? '';
              return status.toLowerCase() == 'conform';
            }).toList();

            final deliveredBookings = bookings.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final status = data['booking_status'] ?? '';
              return status.toLowerCase() == 'complete';
            }).toList();

            final cancelledBookings = bookings.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final status = data['booking_status'] ?? '';
              return status.toLowerCase() == 'reject';
            }).toList();

            return ListView(
              children: [
                if (orderPlacedBookings.isNotEmpty) ...[
                  const Text(
                    "🕒 Order Placed Bookings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...orderPlacedBookings.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return buildBookingCard(
                      context: context,
                      data: data,
                      docId: doc.id,
                    );
                  }),
                  const SizedBox(height: 20),
                ],
                if (dispatchedBookings.isNotEmpty) ...[
                  const Text(
                    "🚚 Dispatched Bookings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...dispatchedBookings.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return buildBookingCard(
                      context: context,
                      data: data,
                      docId: doc.id,
                    );
                  }),
                  const SizedBox(height: 20),
                ],
                if (deliveredBookings.isNotEmpty) ...[
                  const Text(
                    "✅ Delivered Bookings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...deliveredBookings.map((doc) {
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
                  const Text(
                    "❌ Cancelled Bookings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
