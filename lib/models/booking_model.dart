import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String useName;
  final String serviceName;
  final String status;
  final String originalPrice;
  final String discountPrice;
  final Timestamp? timestamp;
  final String imageUrl;
  final String profileImage;

  BookingModel({
    required this.useName,
    required this.serviceName,
    required this.status,
    required this.originalPrice,
    required this.discountPrice,
    this.timestamp,
    required this.imageUrl,
    required this.profileImage,
  });

  factory BookingModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return BookingModel(
      useName: data['name'] ?? '',
      profileImage: data['profileImage'] ?? '',
      serviceName: data['serviceName'] ?? '',
      status: data['status'] ?? 'unknown',
      originalPrice: data['originalPrice']?.toString() ?? '0',
      discountPrice: data['discountPrice']?.toString() ?? '0',
      // originalPrice: (data['originalPrice'] != null)
      //     ? double.tryParse(data['originalPrice'].toString()) : null,
      timestamp: data['timestamp'],
      imageUrl: data['workingImageUrl'] ?? '',
    );
  }
}
