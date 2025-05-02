import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prolife_service/models/address_model.dart';
import 'package:prolife_service/screen/shaved_address_screen.dart';
import 'package:provider/provider.dart';

import '../global_widget/address_textfield_widget.dart';
import '../provider/address_provider.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressModel address;

  const EditAddressScreen({super.key, required this.address});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AddressProvider>(context, listen: false);
    provider.setControllerWithData(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(CupertinoIcons.arrow_left,)),
        title: const Text("Update Address", style:  TextStyle(fontSize: 25)),
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
                      onPressed: () {},
                      icon: const Icon(Icons.location_on, size: 20),
                      label: const Text("Add location", style: TextStyle(fontSize: 17)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
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
              const Text("Address Type", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio<String>(
                    value: 'Home',
                    groupValue: addressProvider.selectedAddressType,
                    onChanged: (value) => addressProvider.setAddressType(value!),
                  ),
                  const Text("Home"),
                  Radio<String>(
                    value: 'Work',
                    groupValue: addressProvider.selectedAddressType,
                    onChanged: (value) => addressProvider.setAddressType(value!),
                  ),
                  const Text("Work"),
                  Radio<String>(
                    value: 'Other',
                    groupValue: addressProvider.selectedAddressType,
                    onChanged: (value) => addressProvider.setAddressType(value!),
                  ),
                  const Text("Other"),
                ],
              ),
              SizedBox(
                width: 260,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      addressProvider.updateAddressInFirestore(widget.address.addressId!);
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShavedAddressScreen(),));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                  child: const Text("Update Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
