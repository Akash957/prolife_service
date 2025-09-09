import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic>? userData;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getUserData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .get();
      userData = snapshot.data();
      if (userData != null) {
        nameController.text = userData?['userName'] ?? '';
        emailController.text = userData?['email'] ?? '';
        phoneController.text = userData?['phone'] ?? '';
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  Future<void> updateProfile({File? imageFile}) async {
    try {
      String? imageUrl = userData?['imageUrl'];

      if (imageFile != null) {
        final storageRef =
            FirebaseStorage.instance.ref().child('user_images/$_userId.jpg');
        await storageRef.putFile(imageFile);
        imageUrl = await storageRef.getDownloadURL();
      }

      final updatedData = {
        'userName': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'imageUrl': imageUrl,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .update(updatedData);
      Fluttertoast.showToast(msg: 'Profile updated successfully');
      await getUserData();
    } catch (e) {
      debugPrint('Error updating profile: $e');
    }
  }
}
