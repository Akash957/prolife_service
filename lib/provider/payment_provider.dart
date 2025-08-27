import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prolife_service/home_page_view/home_screen.dart';
import 'package:prolife_service/notification/device_token_services.dart';
import 'package:prolife_service/provider/address_provider.dart';
import 'package:prolife_service/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../bottonNavigation/botton_nav.dart';
import '../notification/send_notification_ToPartners.dart';
import 'package:http/http.dart'as http;
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/functions/randomValues.dart';
class PaymentProvider with ChangeNotifier {
  late Razorpay razorpay;
  BuildContext? context;
  DateTime selectedDate = DateTime.now();
  String payableAmount = "0.0";

  registerRazorPay() {
    razorpay = Razorpay();
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
      print("success ${response.paymentId}");
      _handlePaymentSuccess(response);
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void disposeRazorpay() {
    razorpay.clear();
  }

  String? partnerId, name, serviceName, originalPrice, workingImageUrl;
  int? quantity;

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
    required payablePrice
  }) async {
    this.context = context;
    this.partnerId = partnerId;
    this.name = name;
    this.serviceName = serviceName;
    this.originalPrice = originalPrice;
    this.workingImageUrl = workingImageUrl;
    this.quantity = quantity;
    this.selectedDate = selectedDate;
    this.startTime = startTime;
    this.endTime = endTime;


    var price = int.parse(payablePrice);
    payableAmount = "${price / 100}";

    var orderId = await generateOrder(price);
    var options = {
      'key': 'rzp_test_R7xQYpa54gC33c',
      'amount': "$price",
      'name': "$serviceName",
      'order_id': orderId,
      'description': "$name",
      'image': "$workingImageUrl",
      'prefill': {
        'contact': '8292448021',
        'email': 'sudishkumar.edugaon@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error opening Razorpay: $e');
      disposeRazorpay();
    }
  }

  Future<String> generateOrder(int price) async {
    var receipt = "order_${generateRandomString(10)}";
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('${'rzp_test_R7xQYpa54gC33c'}:${'eylAZfD3TFA7wwoHYWYw7nQg'}'));
    var order = jsonEncode({
      "amount": "$price",
      "currency": "INR",
      "receipt": receipt,
      "notes": {
        "notes_key_1": "Service Booking",
        "notes_key_2": ""
      }
    });
    var response = await http.post(
        Uri.parse("https://api.razorpay.com/v1/orders"), body: order,
        headers: {"authorization": basicAuth});
    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);

      return "${jsonRes['id']}";
    } else {
      return "";
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(response);
    Fluttertoast.showToast(
      msg: "Payment Success: ${response.paymentId}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    _storeBooking(paymentId: response.paymentId ?? "", status: "request",);
    _storePayment(paymentId: response.paymentId ?? "");
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
    // if (partnerId == null ||
    //     name == null ||
    //     serviceName == null ||
    //     originalPrice == null ||
    //     workingImageUrl == null ||
    //     quantity == null ||
    //     startTime == null ||
    //     endTime == null ||
    //     context == null) {
    //   debugPrint("Missing booking data or context. Cannot save booking.");
    //   return;
    // }

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


    print("Saving booking for userId: $userId");
    // var bookingDate =Timestamp.fromDate(selectedDate);
    var userProvider = Provider.of<ProfileProvider>(context!, listen: false);
    var addressProvider = Provider.of<AddressProvider>(context!, listen: false);
    var userName = "${userProvider.userData?['name']}";
    var userEmail = "${userProvider.userData?['email']}";
    var userPhone = "${userProvider.userData?['phone']}";
    var selectedAddress = addressProvider.selectedAddress;
    var pinCode ="${ selectedAddress?.pincode}";
    var areaName ="${ selectedAddress?.areaName}";
    var buildingName ="${ selectedAddress?.buildingName}";
    var bookingStartTime = _simpleFormatTimeOfDay(
        startTime ?? TimeOfDay(hour: 10, minute: 1), true);
    var bookingEndTime = _simpleFormatTimeOfDay(
        endTime ?? TimeOfDay(hour: 11, minute: 1), false);
    var currentTime = DateTime.now();
    print("Date time converted");
    DocumentReference docRef = FirebaseFirestore.instance.collection(
        'user_bookings').doc();
    var bookingDetails = {
      'bookingId': "${docRef.id}",
      'userId': "$userId",
      'partnerId': "$partnerId",
      'name': "$name",
      'serviceName': "$serviceName",
      'originalPrice': payableAmount,
      'workingImageUrl': "$workingImageUrl",
      'quantity': quantity,
      'bookingDate': selectedDate,
      'startTime': bookingStartTime,
      'endTime': bookingEndTime,
      'booking_status': status,
      'paymentId': paymentId,
      'timestamp': currentTime,
      'userName' : userName,
      'userPhone': userPhone,
      'userEmail': userEmail,
      'pincode': pinCode,
      'areaName': areaName,
      'buildingName':buildingName
    };
    razorpay.clear();
    print("object stored");

    await docRef.set(bookingDetails);

    DeviceTokenServices.getDeviceToken("$partnerId").then(
          (value) {
        if (value != null) {
          print("Notification sending");
          SendNotificationToPartners().sendNotificationToPartners(
              token: value,
              message: "You have new booking from $name",
              otherUid: "$partnerId",
              title: "Booking Request");
        }
      },
    );
    debugPrint("Booking saved with ID: ${docRef.id} for userId: $userId");

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
      Navigator.push(context!,
          MaterialPageRoute(builder: (context) => const HomeScreen(),));
    } catch (e) {
      debugPrint("Error saving payment: $e");
    }
  }

  String _simpleFormatTimeOfDay(TimeOfDay time, bool is12Hour) {
    try {
      String hour = time.hour.toString().padLeft(2, '0');
      String minute = time.minute.toString().padLeft(2, '0');

      if (is12Hour) {
        int hour12 = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
        String period = time.period == DayPeriod.am ? "AM" : "PM";
        return "${hour12.toString().padLeft(2, '0')}:$minute $period";
      } else {
        return "$hour:$minute";
      }
    } catch (error) {
      debugPrint("Error in _simpleFormatTimeOfDay: $error");
      return "";
    }
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
