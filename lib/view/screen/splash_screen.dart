import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolife_service/home_page_view/home_screen.dart';
import 'package:prolife_service/view/onboarding/onboarding_screen.dart';
import 'dart:async';

import '../../bottonNavigation/botton_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), _checkAuthState);
  }

  void _checkAuthState() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => BottomNavScreen());
    } else {
      Get.offAll(() => OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'PROLIFE SERVICE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
