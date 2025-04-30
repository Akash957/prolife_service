import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:prolife_service/screen/select_address.dart';
import 'package:time_range/time_range.dart';

class SelectBookingSlot extends StatefulWidget {
  const SelectBookingSlot({super.key});

  @override
  State<SelectBookingSlot> createState() => _SelectBookingSlotState();
}

class _SelectBookingSlotState extends State<SelectBookingSlot> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.639,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            indent: 120,
            endIndent: 120,
            color: Colors.grey,
            thickness: 4,
          ),
          Text('Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          DatePicker(
            DateTime.now(),
            height: 90,
            initialSelectedDate: _selectedDate,
            selectionColor: Colors.blue,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          SizedBox(height: 13),
          Text('Select Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          TimeRange(
            fromTitle: Text('From', style: TextStyle(fontSize: 16)),
            toTitle: Text('To', style: TextStyle(fontSize: 16)),
            titlePadding: 20,
            textStyle: TextStyle(fontSize: 14, color: Colors.black),
            activeTextStyle: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            borderColor: Colors.blue,
            activeBorderColor: Colors.blue,
            backgroundColor: Colors.grey.shade300,
            activeBackgroundColor: Colors.blue,
            firstTime: const TimeOfDay(hour: 9, minute: 0),
            lastTime: const TimeOfDay(hour: 18, minute: 0),
            timeStep: 30,
            timeBlock: 60,
            onRangeCompleted: (range) {
              setState(() {
                _startTime = range?.start;
                _endTime = range?.end;
              });
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_startTime != null && _endTime != null) {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    builder: (context) => SelectAddress(),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a time range.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Proceed to Checkout',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
