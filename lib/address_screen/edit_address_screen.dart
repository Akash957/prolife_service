import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prolife_service/address_screen/shaved_address_screen.dart';
import 'package:prolife_service/models/address_model.dart';
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
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Update Address",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressTextFieldWidget(
                controller: addressProvider.nameController,
                label: "Full Name *",
                hintText: "Enter your name",
                isRequired: true,
              ),
              const SizedBox(height: 15),
              addressTextFieldWidget(
                controller: addressProvider.personalNumberController,
                label: "Phone Number *",
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
                      label: "Pincode *",
                      hintText: "Enter Pincode",
                      inputType: TextInputType.number,
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: addressTextFieldWidget(
                      controller: addressProvider.cityNameController,
                      label: "City *",
                      hintText: "Enter city name",
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
                      label: "State *",
                      hintText: "Enter state name",
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.my_location, size: 20),
                      label: const Text("Add Location",
                          style: TextStyle(fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              addressTextFieldWidget(
                controller: addressProvider.houseNameController,
                label: "House No., Building Name *",
                hintText: "Enter house/building details",
                isRequired: true,
              ),
              const SizedBox(height: 15),
              addressTextFieldWidget(
                controller: addressProvider.roadNameController,
                label: "Road Name, Area, Colony *",
                hintText: "Enter area details",
                isRequired: true,
              ),
              const SizedBox(height: 20),
              const Text(
                "Address Type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Home'),
                    selected: addressProvider.selectedAddressType == 'Home',
                    onSelected: (_) => addressProvider.setAddressType('Home'),
                    selectedColor: Colors.blue.shade100,
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Work'),
                    selected: addressProvider.selectedAddressType == 'Work',
                    onSelected: (_) => addressProvider.setAddressType('Work'),
                    selectedColor: Colors.blue.shade100,
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Other'),
                    selected: addressProvider.selectedAddressType == 'Other',
                    onSelected: (_) => addressProvider.setAddressType('Other'),
                    selectedColor: Colors.blue.shade100,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await addressProvider.updateAddressInFirestore(widget.address.addressId!);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const ShavedAddressScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Update Address",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
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
