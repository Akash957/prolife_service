import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/address_model.dart';
import 'add_address_screen.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String? selectedAddressId;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  List<AddressModel> addresses = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Select Address",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(CupertinoIcons.xmark_circle_fill,
                      color: Colors.red, size: 28),
                ),
              ],
            ),
            const Divider(thickness: 1, height: 30),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('address')
                    .where('userId', isEqualTo: user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No address found.'));
                  }

                  addresses = snapshot.data!.docs.map((doc) =>
                      AddressModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

                  return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      final title = address.addressType ?? "Address";
                      final subtitle =
                          "${address.name ?? ''}, ${address.buildingName ?? ''}, ${address.areaName ?? ''}\n"
                          "${address.city ?? ''} - ${address.pincode ?? ''}, ${address.state ?? ''}";

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: addressTile(title, subtitle, address.addressId ?? ''),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddAddressScreen()),
                  );
                },
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                label: const Text("Add New Address", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (selectedAddressId != null) {
                    final selectedAddress = addresses.firstWhere(
                          (address) => address.addressId == selectedAddressId,
                    );
                    Navigator.pop(context, selectedAddress);
                  }
                },
                icon: const Icon(Icons.done, color: Colors.white, size: 24),
                label: const Text(
                  "Confirm Address",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  minimumSize: const Size(250, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget addressTile(String title, String subtitle, String addressId) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedAddressId == addressId
              ? Colors.green
              : Colors.grey.shade300,
          width: selectedAddressId == addressId ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedAddressId = addressId;
          });
        },
        leading: Radio<String>(
          value: addressId,
          groupValue: selectedAddressId,
          onChanged: (value) {
            setState(() {
              selectedAddressId = value;
            });
          },
          activeColor: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(height: 1.5),
        ),
      ),
    );
  }
}
