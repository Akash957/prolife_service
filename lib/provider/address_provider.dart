import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/address_model.dart';

class AddressProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController personalNumberController = TextEditingController();
  final TextEditingController alternateNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController roadNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController stateNameController = TextEditingController();

  Future<void> saveAddressToFirestore() async {
    try {
      final address = AddressModel(
        addressId: FirebaseFirestore.instance.collection('address').doc().id,
        name: nameController.text.trim(),
        phoneNumber: personalNumberController.text.trim(),
        alternateNumber: alternateNumberController.text.trim(),
        pincode: pinCodeController.text.trim(),
        city: cityNameController.text.trim(),
        state: stateNameController.text.trim(),
        buildingName: houseNameController.text.trim(),
        areaName: roadNameController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('address')
          .doc(address.addressId)
          .set(address.toJson());

      debugPrint("✅ Address saved: ${address.toJson()}");

      nameController.clear();
      personalNumberController.clear();
      alternateNumberController.clear();
      pinCodeController.clear();
      cityNameController.clear();
      stateNameController.clear();
      houseNameController.clear();
      roadNameController.clear();

      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error saving address: $e");
    }
  }
}
