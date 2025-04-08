import 'package:flutter/material.dart';
import 'package:prolife_service/screens/home_page.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

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
            Image.asset(
              'assets/images/feedback_image.png',
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
              'Thanks for giving \nyour feedback',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'You feedback means a lot for the rating \nand improvement for our services',
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
                padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
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
