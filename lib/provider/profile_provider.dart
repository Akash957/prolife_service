import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileProvider extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  Future<void> getUserData() async {
    try{
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (userDoc.exists) {
        _userData = userDoc.data();
        nameController.text =userData?['name'] ?? '';
        emailController.text = userData!['email'] ?? '';
       phoneController.text = userData!['phone'] ?? '';
        notifyListeners();
      }
    } catch(e){
      print("Error fetching user data: $e");
    }
  }

  Future<void> updateProfile() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
      });

      _userData = {
        ...?_userData,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
      };
      Fluttertoast.showToast(msg: "Profile updated Successfully");
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error updating profile");
      debugPrint("Update error: $e");
    }
  }
  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }
}
