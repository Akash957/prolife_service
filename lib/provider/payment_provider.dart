import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';
import '../bottonNavigation/botton_nav.dart';

class PaymentProvider with ChangeNotifier {
  late Razorpay razorpay;
  BuildContext? context;

  PaymentProvider() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void disposeRazorpay() {
    razorpay.clear();
  }

  String? partnerId, name, serviceName, originalPrice, workingImageUrl;
  int? quantity;
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void openCheckout({
    required BuildContext context,
    required String partnerId,
    required String name,
    required String serviceName,
    required String originalPrice,
    required String workingImageUrl,
    required int quantity,
    required DateTime selectedDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) {
    this.context = context;

    int totalAmount = int.parse(originalPrice) * quantity * 100;

    this.partnerId = partnerId;
    this.name = name;
    this.serviceName = serviceName;
    this.originalPrice = originalPrice;
    this.workingImageUrl = workingImageUrl;
    this.quantity = quantity;
    this.selectedDate = selectedDate;
    this.startTime = startTime;
    this.endTime = endTime;

    var options = {
      'key': 'rzp_test_bToB0wfbBdrPfq',
      'amount': totalAmount,
      'name': serviceName,
      'description': name,
      'image': workingImageUrl,
      'prefill': {
        'contact': '8888888888',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Success: ${response.paymentId}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _storeBooking(paymentId: response.paymentId!, status: "Order Placed");
    _storePayment(paymentId: response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Error: ${response.message}");
    Fluttertoast.showToast(
      msg: "Payment Failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet selected: ${response.walletName}");
    Fluttertoast.showToast(
      msg: "External Wallet selected: ${response.walletName}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<void> _storeBooking({
    required String paymentId,
    required String status,
  }) async {
    if (partnerId == null ||
        name == null ||
        serviceName == null ||
        originalPrice == null ||
        workingImageUrl == null ||
        quantity == null ||
        selectedDate == null ||
        startTime == null ||
        endTime == null ||
        context == null) {
      debugPrint("Missing booking data or context. Cannot save booking.");
      return;
    }

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null || userId.isEmpty) {
        debugPrint("User not logged in or invalid UID.");
        Fluttertoast.showToast(
          msg: "User not logged in",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      debugPrint("Saving booking for userId: $userId");

      var booking_Id = Uuid().v4();
      DocumentReference bookingRef =
          await FirebaseFirestore.instance.collection('user_bookings').add({
        "bookingId": booking_Id,
        'userId': userId,
        'partnerId': partnerId,
        'name': name,
        'serviceName': serviceName,
        'originalPrice': (int.parse(originalPrice!) * quantity!).toString(),
        'workingImageUrl': workingImageUrl,
        'quantity': quantity,
        'bookingDate': Timestamp.fromDate(selectedDate!),
        'startTime': _simpleFormatTimeOfDay(startTime!),
        'endTime': _simpleFormatTimeOfDay(endTime!),
        'booking_status': status,
        'paymentId': paymentId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      debugPrint("Booking saved with ID: ${bookingRef.id} for userId: $userId");

      Fluttertoast.showToast(
        msg: "Booking confirmed!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );

      Navigator.pushAndRemoveUntil(
        context!,
        MaterialPageRoute(builder: (context) => BottomNavScreen()),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Error saving booking: $e");
      Fluttertoast.showToast(
        msg: "Failed to save booking: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _storePayment({required String paymentId}) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        debugPrint("User not logged in for payment storing.");
        return;
      }

      await FirebaseFirestore.instance.collection('user_payments').add({
        'userId': userId,
        'partnerId': partnerId,
        'name': name,
        'serviceName': serviceName,
        'amountPaid': (int.parse(originalPrice!) * quantity!).toString(),
        'quantity': quantity,
        'paymentId': paymentId,
        'paymentMethod': 'Razorpay',
        'paymentStatus': 'success',
        'timestamp': FieldValue.serverTimestamp(),
      });

      debugPrint("Payment saved successfully!");
    } catch (e) {
      debugPrint("Error saving payment: $e");
    }
  }

  String _simpleFormatTimeOfDay(TimeOfDay tod) {
    final hour = tod.hour.toString().padLeft(2, '0');
    final minute = tod.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_bookings')
          .doc(bookingId)
          .update({
        'booking_status': newStatus,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint("Booking status updated to: $newStatus");
    } catch (e) {
      debugPrint("Error updating booking status: $e");
    }
  }
}
