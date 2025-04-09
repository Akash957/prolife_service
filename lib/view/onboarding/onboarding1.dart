import 'package:flutter/material.dart';
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
              left: 290,
            ),
            child: TextButton(
                onPressed: () {},
                child: const Text("Skip",
                    style: TextStyle(color: Colors.grey, fontSize: 20))),
          ),
          Image.asset(data.image, width: 500, height: 500),
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
