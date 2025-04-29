import 'package:flutter/material.dart';
import '../models/address_model.dart';

class AddressProvider with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController personalNumberController = TextEditingController();
  final TextEditingController alternateNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController houseNameController = TextEditingController();
  final TextEditingController roadNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController stateNameController = TextEditingController();

  List<AddressModel> _address = [];
  bool _isLoading = false;

  List<AddressModel> get address => _address;
  bool get isLoading => _isLoading;

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
      );

      await firestore
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

  Future<void> fetchAddress()async{
    _isLoading = true;
    notifyListeners();

    try{
      final snapshots = await firestore.collection('address').get();
      _address = snapshots.docs.map((e) => AddressModel.fromJson(e.data()),).toList();
    } catch(e){
      print('Error fetching Addresses: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateAddressInFirestore(AddressModel updateAddress)async{
    try{
      await firestore.collection('address').doc(updateAddress.addressId).update(updateAddress.toJson());
      Fluttertoast.showToast(msg: 'Address updated:${updateAddress.toJson()}');
      await fetchAddress();
      notifyListeners();
    } catch(e){
      Fluttertoast.showToast(msg: 'Address updated failed');
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

}
