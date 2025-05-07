import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models_booking.dart';

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  Future<void> fetchBookings() async {
    try {
      final snapshot = await _firestore.collection('bookings').get();
      _bookings = snapshot.docs.map((doc) {
        final data = doc.data();
        return Booking(
          category: data['category'] ?? '',
          status: data['status'] ?? '',
          statusColor: Color(int.parse(data['statusColor'] ?? '0xFFEAF4FF')),
          statusTextColor:
              Color(int.parse(data['statusTextColor'] ?? '0xFF007BFF')),
          title: data['title'] ?? '',
          dateTime: data['dateTime'] ?? '',
          amount: data['amount'] ?? '',
          showButton: data['showButton'] ?? true,
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

  Future<void> addBooking(Booking booking) async {
    try {
      await _firestore.collection('bookings').add({
        'category': booking.category,
        'status': booking.status,
        'statusColor': '#${booking.statusColor.value.toRadixString(16)}',
        'statusTextColor':
            '#${booking.statusTextColor.value.toRadixString(16)}',
        'title': booking.title,
        'dateTime': booking.dateTime,
        'amount': booking.amount,
        'showButton': booking.showButton,
      });
      notifyListeners();
    } catch (e) {
      print("Error adding booking: $e");
    }
  }
}
