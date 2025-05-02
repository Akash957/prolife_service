import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prolife_service/models/address_model.dart';
import 'package:prolife_service/screen/add_edit_address.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                indent: 150,
                endIndent: 150,
                color: Colors.grey,
                thickness: 6,
              ),
              ListTile(
                leading: const Text(
                  "Select address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    CupertinoIcons.multiply_circle,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Radio<String>(
                  value: "Home",
                  groupValue: selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: const Text(
                  "4517 Washington Ave.\nManchester, Kentucky 39495",
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Radio<String>(
                  value: "Work",
                  groupValue: selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      selectedAddress = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                title: const Text(
                  "Work",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: const Text(
                  "2118 Thornridge Cir. Syracuse,\nConnecticut 356224",
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  EditAddressScreen(address:AddressModel(),),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    fixedSize: const Size(250, 45),
                    backgroundColor: Colors.blue,
                  ),
                  label: const Text("Add New Address"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
