
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
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
      height: MediaQuery.of(context).size.height*0.5,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Container(width: 40, height: 5, color: Colors.grey[300])),
           SizedBox(height: 15),
           Text('Select Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
           SizedBox(height: 25),
           Text('Select Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
           SizedBox(height: 10),
          TimeRange(
            fromTitle:  Text('From', style: TextStyle(fontSize: 16)),
            toTitle:  Text('To', style: TextStyle(fontSize: 16)),
            titlePadding: 20,
            textStyle:  TextStyle(fontSize: 14, color: Colors.black),
            activeTextStyle: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_startTime != null && _endTime != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Booking Confirmed on ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} '
                            'from ${_startTime!.format(context)} to ${_endTime!.format(context)}',
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a time range.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:prolife_service/screen/select_address.dart';
// import 'select_booking_slot_widget.dart';
//
// class SelectBookingSlot extends StatefulWidget {
//   const SelectBookingSlot({super.key});
//
//   @override
//   State<SelectBookingSlot> createState() => _SelectBookingSlotState();
// }
//
// class _SelectBookingSlotState extends State<SelectBookingSlot> {
//   String selectedTime = "";
//   String selectedDate = "";
//   final List<String> availableTimes = [
//     "10:00 AM",
//     "11:00 AM",
//     "12:30 PM",
//     "01:30 PM",
//     "02:30 PM"
//   ];
//   final List<Map<String, String>>dates = [
//     {"day": "tue", "date": "29"},
//     {"day": "wed", "date": "30"},
//     {"day": "thu", "date": "31"},
//     {"day": "fri", "date": "01"},
//     {"day": "sat", "date": "02"},
//     {"day": "sun", "date": "03"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery
//           .of(context)
//           .size
//           .height * 0.5,
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Divider(
//             indent: 120,
//             endIndent: 120,
//             color: Colors.grey,
//             thickness: 4,
//           ),
//           Text(
//             "Select Date",
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: dates.map((d) {
//                 final displayDate = "${d['day']}${d['date']}";
//                 return dateBox(
//                     d['day']!, d['date']!, selectedDate == displayDate, () {
//                   setState(() {
//                     if (selectedDate == displayDate) {
//                       selectedDate = "";
//                     } else {
//                       selectedDate = displayDate;
//                     }
//                     // selectedDate=displayDate;
//                   });
//                 });
//               }).toList(),
//               // [
//               //   SizedBox(width: 10),
//               //   dateBox("Tue", "29"),
//               //   dateBox("Wed", "30"),
//               //   dateBox("Thu", "31"),
//               //   dateBox("Fri", "01"),
//               //   dateBox("Sat", "02"),
//               //   dateBox("Sun", "03"),
//               // ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Select Time",
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Wrap(
//             runSpacing: 10,
//             children: availableTimes.map((time) {
//               return timeBox(time, selectedTime == time, () {
//                 setState(() {
//                   if (selectedTime == time) {
//                     selectedTime = "";
//                   }
//                   else {
//                     selectedTime = time;
//                   }
//                 });
//               });
//             }).toList(),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: ElevatedButton(
//                 onPressed: (selectedDate.isNotEmpty && selectedTime.isNotEmpty)
//                     ? () {
//                   showModalBottomSheet(context: context,
//                     isScrollControlled: true,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(30))),
//                     builder: (context) => SelectAddress(),);
//                 }:null,                // onPressed: () {
//                 //   showModalBottomSheet(
//                 //     context: context,
//                 //     isScrollControlled: true,
//                 //     shape: RoundedRectangleBorder(
//                 //         borderRadius:
//                 //             BorderRadius.vertical(top: Radius.circular(30))),
//                 //     builder: (context) => SelectAddress(),
//                 //   );
//                 // },
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//                     backgroundColor: (selectedDate.isNotEmpty&&selectedTime.isNotEmpty)? Colors.blue:Colors.grey,
//                     fixedSize: Size(250, 45)),
//                 child: Text(
//                   "Proceed to checkout",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }
