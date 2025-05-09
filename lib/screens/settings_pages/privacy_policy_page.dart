import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last update: 02/05/2025',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please read these privacy policy, carefully before using our app operated by us.',
                style: TextStyle(fontSize: 16.5),
              ),
              SizedBox(height: 20),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "There are many variations of passages of Lorem Ipsum available, but the majority \nhave suffered alteration in some form, by \ninjected humour, or randomised words \nwhich don’t look even slightly believable."
                "If you are going to use a passage of Lorem Ipsum, you need to be sure there isn’t \nanything embarrassing hidden in the middle \nof text.\n"
                "   All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks \nas necessary, making this the first true \ngenerator on the Internet. It uses a \ndictionary of over 200 Latin words, \ncombined with a handful of model sentence \nstructures, to generate Lorem Ipsum which \nlooks reasonable.\n"
                "The generated Lorem Ipsum is therefore always free from repetition, injected \nhumour, or non-characteristic words etc.",
                style: TextStyle(fontSize: 16.5, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
