import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prolife_service/screen/shaved_address_screen.dart';
import 'package:provider/provider.dart';
import '../global_widget/address_textfield_widget.dart';
import '../provider/address_provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.arrow_left),
        title: const Text("Add Delivery Address", style: TextStyle(fontSize: 25)),
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
                    width: 160,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // location logic
                      },
                      icon: const Icon(Icons.location_on, size: 20),
                      label: const Text("Add location", style: TextStyle(fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
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
              SizedBox(
                width: 260,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await addressProvider.saveAddressToFirestore();
                      Get.to(const ShavedAddressScreen());
                      Fluttertoast.showToast(msg: "Address saved successfully!");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: const Text(
                    "Save Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
