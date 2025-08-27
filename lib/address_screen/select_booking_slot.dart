import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_range/time_range.dart';
import '../models/partners_model.dart';
import '../provider/payment_provider.dart';
import '../provider/cart_provider.dart';

class SelectBookingSlot extends StatefulWidget {
  final PartnersModel partner;
  String payablePrice;

  SelectBookingSlot({super.key, required this.partner,required this.payablePrice});

  @override
  State<SelectBookingSlot> createState() => _SelectBookingSlotState();
}

class _SelectBookingSlotState extends State<SelectBookingSlot> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;


  @override
  Widget build(BuildContext context) {
    final paymentProvider =
    Provider.of<PaymentProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Select Booking Slot'),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Select Date',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                DatePicker(
                  height: 100,
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.blue,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 25),
                const Text('Select Time',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TimeRange(
                  fromTitle: const Text('From',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  toTitle: const Text('To',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  titlePadding: 20,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  borderColor: Colors.blue,
                  activeBorderColor: Colors.blue,
                  backgroundColor: Colors.grey.shade300,
                  activeBackgroundColor: Colors.blue,
                  firstTime: TimeOfDay(hour: 10, minute: 0),
                  lastTime: TimeOfDay(hour: 18, minute: 0),
                  timeStep: 60,
                  timeBlock: 60,
                  onRangeCompleted: (range) {
                    setState(() {
                      _startTime = range?.start;
                      _endTime = range?.end;
                    });
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_startTime == null || _endTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Please select a time range",
                                style: TextStyle(color: Colors.white),
                              )),
                        );
                        return;
                      }

                      paymentProvider.openCheckout(
                          context: context,
                          partnerId: widget.partner.partnerId,
                          name: widget.partner.name,
                          serviceName: widget.partner.serviceName,
                          originalPrice: widget.partner.originalPrice,
                          workingImageUrl: widget.partner.workingImageUrl,
                          quantity: cartProvider.quantity,
                          selectedDate: _selectedDate,
                          startTime: _startTime!,
                          endTime: _endTime!,
                          payablePrice: widget.payablePrice
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Proceed to Payment',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}