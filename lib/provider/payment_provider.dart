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
  String? _partnerId, _name, _serviceName, _originalPrice, _workingImageUrl;
  int? _quantity;

  void openCheckout({
    required String partnerId,
    required String name,
    required String serviceName,
    required String originalPrice,
    required String workingImageUrl,
    required int quantity,
  }) {
    int totalAmount = int.parse(originalPrice) * quantity * 100;

    _partnerId = partnerId;
    _name = name;
    _serviceName = serviceName;
    _originalPrice = originalPrice;
    _workingImageUrl = workingImageUrl;
    _quantity = quantity;

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

    _storeBooking(
      paymentId: response.paymentId!,
      status: "paid",
    );
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
    required String paymentId,
    required String status,
  }) async {
    if (_partnerId == null || _name == null || _serviceName == null || _originalPrice == null || _workingImageUrl == null || _quantity == null) {
      debugPrint("Missing booking data");
      return;
    }

    await FirebaseFirestore.instance.collection('user_bookings').add({
      'partnerId': _partnerId,
      'name': _name,
      'serviceName': _serviceName,
      'originalPrice': (int.parse(_originalPrice!) * _quantity!).toString(),
      'workingImageUrl': _workingImageUrl,
      'quantity': _quantity,
      'paymentId': paymentId,
      'status': status,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
