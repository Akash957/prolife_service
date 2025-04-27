import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import '../screen/singup_screen.dart';
import 'onboarding_model.dart';

class Onboarding1 extends StatelessWidget {
  final OnboardingModel data;

  const Onboarding1({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 200,
            ),
            child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: const Text("Skip",
                    style: TextStyle(color: Colors.grey, fontSize: 20))),
          ),
          Image.asset(data.image, width: 500, height: 450),
          const SizedBox(height: 20),
          Text(
            data.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
