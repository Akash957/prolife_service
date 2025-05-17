import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String userId;
  final String partnerId;
  final String name;
  final String serviceName;
  final String originalPrice;
  final String workingImageUrl;
  final int quantity;
  final DateTime bookingDate;
  final String startTime;
  final String endTime;
  final String bookingStatus;
  final String bookingId;
  final String paymentId;
  final DateTime timestamp;
  final String profileImage;
  final String discountPrice;

  BookingModel({
    required this.id,
    required this.userId,
    required this.partnerId,
    required this.bookingId,
    required this.name,
    required this.serviceName,
    required this.originalPrice,
    required this.workingImageUrl,
    required this.quantity,
    required this.bookingDate,
    required this.startTime,
    required this.endTime,
    required this.bookingStatus,
    required this.paymentId,
    required this.timestamp,
    this.profileImage = '',
    this.discountPrice = '0',
  });

  factory BookingModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      bookingId: data['bookingId'] ?? '',
      userId: data['userId'] ?? '',
      partnerId: data['partnerId'] ?? '',
      name: data['name'] ?? '',
      serviceName: data['serviceName'] ?? '',
      originalPrice: data['originalPrice'] ?? '0',
      workingImageUrl: data['workingImageUrl'] ?? '',
      quantity: data['quantity'] ?? 1,
      bookingDate:
      (data['bookingDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
      bookingStatus: data['booking_status'] ?? 'Order Placed',
      paymentId: data['paymentId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      profileImage: data['profileImage'] ?? '',
      discountPrice: data['discountPrice'] ?? '0',
    );
  }
}
