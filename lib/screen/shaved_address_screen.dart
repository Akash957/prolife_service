import 'package:flutter/material.dart';

class ShavedAddressScreen extends StatefulWidget {
  const ShavedAddressScreen({super.key});

  @override
  State<ShavedAddressScreen> createState() => _ShavedAddressScreenState();
}

class _ShavedAddressScreenState extends State<ShavedAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("My Addresses",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
