import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/address_model.dart';

class AddressProvider with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController personalNumberController = TextEditingController();
  final TextEditingController alternateNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController roadNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController stateNameController = TextEditingController();
  AddressModel? selectedAddress;
  List<AddressModel> _address = [];
  bool _isLoading = false;

  List<AddressModel> get address => _address;
  bool get isLoading => _isLoading;

  String _selectedAddressType = 'Home';
  String get selectedAddressType => _selectedAddressType;

  void setAddressType(String type){
    _selectedAddressType = type;
    notifyListeners();
  }

  void setControllerWithData(AddressModel address){
    nameController.text = address.name!;
    personalNumberController.text = address.phoneNumber!;
    alternateNumberController.text = address.alternateNumber!;
    pinCodeController.text = address.pincode!;
    cityNameController.text = address.city!;
    stateNameController.text = address.state!;
    houseNameController.text = address.buildingName!;
    roadNameController.text = address.areaName!;
  }


  Future<void> saveAddressToFirestore() async {
    try {
      final address = AddressModel(
        addressId: firestore.collection('address').doc().id,
        name: nameController.text.trim(),
        phoneNumber: personalNumberController.text.trim(),
        alternateNumber: alternateNumberController.text.trim(),
        pincode: pinCodeController.text.trim(),
        city: cityNameController.text.trim(),
        state: stateNameController.text.trim(),
        buildingName: houseNameController.text.trim(),
        areaName: roadNameController.text.trim(),
        addressType: _selectedAddressType,
        userId: currentUser?.uid,
      );

      await firestore
          .collection('address')
          .doc(address.addressId)
          .set(address.toJson());

      debugPrint("Address saved: ${address.toJson()}");

      clearControllers();

      notifyListeners();
    } catch (e) {
      debugPrint("Error saving address: $e");
    }
  }

  Future<void> fetchAddress()async{
    _isLoading = true;
    notifyListeners();

    try{
      final snapshots = await firestore.collection('address').where('userId',isEqualTo: currentUser?.uid).get();
      _address = snapshots.docs.map((e) => AddressModel.fromJson(e.data()),).toList();
    } catch(e){
      print('Error fetching Addresses: $e');
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> updateAddressInFirestore(String addressId) async {
    try {
      final updatedAddress = AddressModel(
        addressId: addressId,
        name: nameController.text.trim(),
        phoneNumber: personalNumberController.text.trim(),
        alternateNumber: alternateNumberController.text.trim(),
        pincode: pinCodeController.text.trim(),
        city: cityNameController.text.trim(),
        state: stateNameController.text.trim(),
        buildingName: houseNameController.text.trim(),
        areaName: roadNameController.text.trim(),
        addressType: _selectedAddressType,
        userId: currentUser?.uid,
      );

      await firestore
          .collection('address')
          .doc(addressId)
          .update(updatedAddress.toJson());

      clearControllers();

      Fluttertoast.showToast(msg: 'Address updated successfully!');
      debugPrint("Address updated: ${updatedAddress.toJson()}");
      await fetchAddress();
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Address update failed');
      debugPrint('Error updating address: $e');
    }
  }

  Future<void> deleteAddress(String addressId)async{
    try{
      await firestore.collection('address').doc(addressId).delete();
      Fluttertoast.showToast(msg: 'Address deleted $addressId');
      await fetchAddress();
      notifyListeners();
    } catch(e){
      print('Error deleting address: $addressId');
    }
  }

  void clearControllers() {
    nameController.clear();
    personalNumberController.clear();
    alternateNumberController.clear();
    pinCodeController.clear();
    cityNameController.clear();
    stateNameController.clear();
    houseNameController.clear();
    roadNameController.clear();
    _selectedAddressType = 'Home';
    notifyListeners();
  }

}
