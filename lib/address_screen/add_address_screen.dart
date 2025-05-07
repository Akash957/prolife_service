import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prolife_service/address_screen/shaved_address_screen.dart';
import 'package:provider/provider.dart';
import '../global_widget/address_textfield_widget.dart';
import '../provider/address_provider.dart';
import '../provider/location_provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<AddressProvider>(context, listen: false);
    provider.clearControllers();
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
            )),
        title: const Text("Add Delivery Address",
            style: TextStyle(fontSize: 25, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              addressTextFieldWidget(
                controller: addressProvider.nameController,
                label: "Full Name (Required)*",
                hintText: "Enter your name",
                isRequired: true,
              ),
              const SizedBox(height: 15),
              addressTextFieldWidget(
                controller: addressProvider.personalNumberController,
                label: "Phone Number (Required)*",
                hintText: "Enter your phone number",
                inputType: TextInputType.phone,
                isRequired: true,
              ),
              const SizedBox(height: 15),
              addressTextFieldWidget(
                controller: addressProvider.alternateNumberController,
                label: "Alternate Phone Number",
                hintText: "Enter alternate number",
                inputType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: addressTextFieldWidget(
                      controller: addressProvider.pinCodeController,
                      label: "Pincode (Required)*",
                      hintText: "Pincode number",
                      inputType: TextInputType.number,
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: addressTextFieldWidget(
                      controller: addressProvider.cityNameController,
                      label: "City (Required)*",
                      hintText: "City name",
                      isRequired: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: addressTextFieldWidget(
                      controller: addressProvider.stateNameController,
                      label: "State (Required)*",
                      hintText: "State name",
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final locationProvider = Provider.of<LocationProvider>(
                            context,
                            listen: false);
                        final addressProvider = Provider.of<AddressProvider>(
                            context,
                            listen: false);

                        await locationProvider.getCurrentLocation();

                        if (locationProvider.currentAddress != null) {
                          bool? confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Location'),
                              content: Text(locationProvider.currentAddress!),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Yes, Continue'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            Position pos = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high,
                            );
                            List<Placemark> placemarks =
                                await placemarkFromCoordinates(
                                    pos.latitude, pos.longitude);

                            if (placemarks.isNotEmpty) {
                              Placemark place = placemarks.first;
                              addressProvider.cityNameController.text =
                                  place.locality ?? "";
                              addressProvider.stateNameController.text =
                                  place.administrativeArea ?? "";
                              addressProvider.pinCodeController.text =
                                  place.postalCode ?? "";
                            }
                          }
                        }
                      },
                      icon: const Icon(Icons.my_location, size: 22),
                      label: const Text(
                        "Use My Location",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              addressTextFieldWidget(
                controller: addressProvider.houseNameController,
                label: "House No., Building Name (Required)*",
                hintText: "Enter house/building name",
                isRequired: true,
              ),
              const SizedBox(height: 15),
              addressTextFieldWidget(
                controller: addressProvider.roadNameController,
                label: "Road name, Area, Colony (Required)*",
                hintText: "Enter address details",
                isRequired: true,
              ),
              const SizedBox(height: 20),
              const Text("Address Type",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Home', 'Work', 'Other'].map((type) {
                  bool isSelected = addressProvider.selectedAddressType == type;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => addressProvider.setAddressType(type),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.blueAccent : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          type,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 280,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await addressProvider.saveAddressToFirestore();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShavedAddressScreen()),
                      );
                      Fluttertoast.showToast(
                          msg: "Address saved successfully!");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  child: const Text(
                    "Save Address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
