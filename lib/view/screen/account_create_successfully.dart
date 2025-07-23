import 'package:flutter/material.dart';
import '../../bottonNavigation/botton_nav.dart';

class AccountCreateSuccessfully extends StatefulWidget {
  const AccountCreateSuccessfully({super.key});

  @override
  State<AccountCreateSuccessfully> createState() =>
      _AccountCreateSuccessfullyState();
}

class _AccountCreateSuccessfullyState
    extends State<AccountCreateSuccessfully> {
  @override
  Widget build(BuildContext context) {
    // Screen width and height
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/successful.png',
                height: height * 0.35,
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * 0.02),
              const Icon(
                Icons.verified,
                color: Colors.green,
                size: 80,
              ),
              SizedBox(height: height * 0.015),
              const Text(
                'Account Create\nSuccessfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'Your Account Created Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: height * 0.06),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Go to Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
