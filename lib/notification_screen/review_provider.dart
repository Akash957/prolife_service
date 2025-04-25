import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewProvider extends ChangeNotifier {
  int serviceRating = 5;
  int technicianRating = 5;
  bool recommended = true;
  String comment = '';
  String selectedTag = 'Service Quality';
  File? image;

  final Map<String, Color> tags = {
    'Service Quality': Colors.blue,
    'Technician Behaviour': Colors.blue,
    'On Time Service': Colors.blue,
    'Customer Support': Colors.blue,
  };

  void updateServiceRating(int val) {
    serviceRating = val;
    notifyListeners();
  }

  void updateTechnicianRating(int val) {
    technicianRating = val;
    notifyListeners();
  }

  void updateRecommended(bool val) {
    recommended = val;
    notifyListeners();
  }

  void updateComment(String val) {
    comment = val;
    notifyListeners();
  }

  void updateSelectedTag(String tag) {
    selectedTag = tag;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> submitReview() async {
    await FirebaseFirestore.instance.collection('reviews').add({
      'serviceRating': serviceRating,
      'technicianRating': technicianRating,
      'recommended': recommended,
      'comment': comment,
      'tag': selectedTag,
      'technicianName': 'John Williams',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
