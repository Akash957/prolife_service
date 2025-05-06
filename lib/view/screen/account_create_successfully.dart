import 'package:flutter/material.dart';
import '../../bottonNavigation/botton_nav.dart';
import '../../home_page_view/home_screen.dart';

class AccountCreateSuccessfully extends StatefulWidget {
  const AccountCreateSuccessfully({super.key});

  @override
  State<AccountCreateSuccessfully> createState() =>
      _AccountCreateSuccessfullyState();
}

class _AccountCreateSuccessfullyState extends State<AccountCreateSuccessfully> {
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
              'assets/successful.png',
              height: 350,
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.verified,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 15),
            const Text(
              'Account Create\nSuccessfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'You Account Created Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavScreen(),
                    ));
              },
              child: const Text(
                'Go to Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
