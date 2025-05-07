import 'dart:ui';

class Booking {
  final String category;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String title;
  final String dateTime;
  final String amount;
  final bool showButton;

  Booking({
    required this.category,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    required this.title,
    required this.dateTime,
    required this.amount,
    this.showButton = true,
  });
}
