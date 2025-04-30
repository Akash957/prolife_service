import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProvider with ChangeNotifier {
  late Razorpay _razorpay;

  PaymentProvider() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void disposeRazorpay() {
    _razorpay.clear();
  }

  VoidCallback? _onSuccess;

  void openCheckout({
    required String partnerId,
    required String name,
    required String serviceName,
    required String originalPrice,
    required String workingImageUrl,
    required int quantity,
  }) {
    int totalAmount = int.parse(originalPrice) * quantity * 100;

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
      debugPrint('Error: $e');
    }

    _onSuccess = () async {
      await _storeBooking(
        partnerId: partnerId,
        name: name,
        serviceName: serviceName,
        originalPrice: (int.parse(originalPrice) * quantity).toString(),
        workingImageUrl: workingImageUrl,
        quantity: quantity,
      );
    };
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Success: ${response.paymentId}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    _onSuccess?.call();
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
    debugPrint("External Wallet: ${response.walletName}");
  }

  Future<void> _storeBooking({
    required String partnerId,
    required String name,
    required String serviceName,
    required String originalPrice,
    required String workingImageUrl,
    required int quantity,
  }) async {
    await FirebaseFirestore.instance.collection('user_bookings').add({
      'partnerId': partnerId,
      'name': name,
      'serviceName': serviceName,
      'originalPrice': originalPrice,
      'workingImageUrl': workingImageUrl,
      'quantity': quantity,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
