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
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last update: 01/03/2025',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please read these terms of service, carefully before using our app operated by us.',
                style: TextStyle(fontSize: 16.5, color: Colors.black87),
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
                "It is a long established fact that a reader \n"
                    "will be distracted by the readable content of \n"
                    "a page when looking at its layout. The point \n"
                    "of using Lorem Ipsum is that it has a more \n"
                    "-or-less normal distribution of letters, as \n"
                    "opposed to using 'Content here, content \n"
                    "here', making it look like readable English. \n"
                    "Many desktop publishing packages and \n"
                    "web page editors now use Lorem Ipsum as \n"
                    "their default model text, and a search for \n‘"
                    "lorem ipsum’ will uncover many web sites \ns"
                    "till in their infancy. Various versions have \n"
                    "evolved over the years, sometimes by \n"
                    "accident, sometimes on purpose (injected \n"
                    "humour and the like).",
                style: TextStyle(
                    fontSize: 16.5, height: 1.6, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
