import 'package:flutter/material.dart';
import 'onboarding_model.dart';

class Onboarding3 extends StatelessWidget {
  final OnboardingModel data;

  const Onboarding3({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.image, width: 500, height: 500),
          const SizedBox(height: 20),
          Text(
            data.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
