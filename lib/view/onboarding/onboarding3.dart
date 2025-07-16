import 'package:flutter/material.dart';
import 'onboarding_model.dart';

class Onboarding3 extends StatelessWidget {
  final OnboardingModel data;

  const Onboarding3({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.image, width: widthScreen*0.97, height: heightScreen*0.56),
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
