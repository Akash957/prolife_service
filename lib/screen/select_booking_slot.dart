import 'package:flutter/material.dart';
import 'package:prolife_service/screen/select_address.dart';
import 'select_booking_slot_widget.dart';
import 'package:intl/intl.dart';

class SelectBookingSlot extends StatefulWidget {
  const SelectBookingSlot({super.key});

  @override
  State<SelectBookingSlot> createState() => _SelectBookingSlotState();
}

class _SelectBookingSlotState extends State<SelectBookingSlot> {
  String selectedTime = "";
  String selectedDate = "";

  final List<String> availableTimes = [
    "10:00 AM",
    "11:00 AM",
    "12:30 PM",
    "01:30 PM",
    "02:30 PM"
  ];

  List<Map<String, String>> generateNext7Days() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.add(Duration(days: index));
      return {
        "day": DateFormat('EEE').format(date), // e.g., Tue
        "date": DateFormat('dd').format(date), // e.g., 29
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dates = generateNext7Days();

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            indent: 120,
            endIndent: 120,
            color: Colors.grey,
            thickness: 4,
          ),
          Text(
            "Select Date",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: dates.map((d) {
                final displayDate = "${d['day']}${d['date']}";
                return dateBox(
                  d['day']!,
                  d['date']!,
                  selectedDate == displayDate,
                      () {
                    setState(() {
                      selectedDate = selectedDate == displayDate ? "" : displayDate;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Select Time",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: availableTimes.map((time) {
              return timeBox(
                time,
                selectedTime == time,
                    () {
                  setState(() {
                    selectedTime = selectedTime == time ? "" : time;
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: (selectedDate.isNotEmpty && selectedTime.isNotEmpty)
                  ? () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  builder: (context) => SelectAddress(),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                backgroundColor: (selectedDate.isNotEmpty && selectedTime.isNotEmpty)
                    ? Colors.blue
                    : Colors.grey,
                fixedSize: Size(250, 45),
              ),
              child: Text(
                "Proceed to checkout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
