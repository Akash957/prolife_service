import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

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
          'Terms & Conditions',
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
                'Last update: 01/09/2023',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please read these terms of service, carefully before using our app operated by us.',
                style: TextStyle(fontSize: 16.5,color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                'Conditions of Uses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "It is a long established fact that a reader \nwill be distracted by the readable content of \na page when looking at its layout. The point \nof using Lorem Ipsum is that it has a more \n-or-less normal distribution of letters, as \nopposed to using 'Content here, content \nhere', making it look like readable English. \nMany desktop publishing packages and \nweb page editors now use Lorem Ipsum as \ntheir default model text, and a search for \n‘lorem ipsum’ will uncover many web sites \nstill in their infancy. Various versions have \nevolved over the years, sometimes by \naccident, sometimes on purpose (injected \nhumour and the like).",
                style: TextStyle(fontSize: 16.5, height: 1.6,color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
