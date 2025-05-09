import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prolife_service/home_page_view/home_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../bottonNavigation/botton_nav.dart';

class PaymentProvider with ChangeNotifier {
  late Razorpay _razorpay;
  BuildContext? _context;

  PaymentProvider() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void disposeRazorpay() {
    _razorpay.clear();
  }

  String? _partnerId, _name, _serviceName, _originalPrice, _workingImageUrl;
  int? _quantity;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

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
    _context = context;

    int totalAmount = int.parse(originalPrice) * quantity * 100;

    _partnerId = partnerId;
    _name = name;
    _serviceName = serviceName;
    _originalPrice = originalPrice;
    _workingImageUrl = workingImageUrl;
    _quantity = quantity;
    _selectedDate = selectedDate;
    _startTime = startTime;
    _endTime = endTime;

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
      _razorpay.open(options);
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

    _storeBooking(paymentId: response.paymentId!, status: "paid");
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
    if (_partnerId == null ||
        _name == null ||
        _serviceName == null ||
        _originalPrice == null ||
        _workingImageUrl == null ||
        _quantity == null ||
        _selectedDate == null ||
        _startTime == null ||
        _endTime == null ||
        _context == null) {
      debugPrint("Missing booking data or context. Cannot save booking.");
      return;
    }

    try {
      DocumentReference ref =
          await FirebaseFirestore.instance.collection('user_bookings').add({
        'partnerId': _partnerId,
        'name': _name,
        'serviceName': _serviceName,
        'originalPrice': (int.parse(_originalPrice!) * _quantity!).toString(),
        'workingImageUrl': _workingImageUrl,
        'quantity': _quantity,
        'paymentId': paymentId,
        'status': status,
        'bookingDate': Timestamp.fromDate(_selectedDate!),
        'startTime': _simpleFormatTimeOfDay(_startTime!),
        'endTime': _simpleFormatTimeOfDay(_endTime!),
        'timestamp': FieldValue.serverTimestamp(),
      });

      debugPrint("Booking saved with ID: ${ref.id}");
      Fluttertoast.showToast(
        msg: "Booking confirmed!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
      Navigator.pushAndRemoveUntil(
        _context!,
        MaterialPageRoute(builder: (context) => BottomNavScreen()),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Error saving booking: $e");
      Fluttertoast.showToast(
        msg: "Failed to save booking",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  String _simpleFormatTimeOfDay(TimeOfDay tod) {
    final hour = tod.hour.toString().padLeft(2, '0');
    final minute = tod.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
