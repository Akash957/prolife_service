import 'package:flutter/material.dart';

import 'feedback_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://img.freepik.com/free-vector/order-confirmed-concept-illustration_114360-6599.jpg?ga=GA1.1.190891060.1697620899&semt=ais_hybrid&w=740",
              height: 350,
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.verified,
              color: Colors.green,
              size: 80,
            ),
            SizedBox(height: 15),
            const Text(
              'Booking Confirm \nSuccessfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'Congratulations 🎉\nyour booking has been confirmed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
              ),
              onPressed: () {

              },
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
