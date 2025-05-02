import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/address_model.dart';
import 'add_address_screen.dart';
import 'package:provider/provider.dart';
import '../provider/address_provider.dart';
import 'edit_address_screen.dart';

class ShavedAddressScreen extends StatelessWidget {
  const ShavedAddressScreen({super.key});

  void confirmDelete(BuildContext context, String addressId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Address"),
        content: const Text("Are you sure you want to delete this address?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<AddressProvider>(context, listen: false)
                  .deleteAddress(addressId);
              Navigator.of(ctx).pop();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Saved Addresses", style: TextStyle(fontSize: 25)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('address').where('userId', isEqualTo: user?.uid).snapshots(),
        builder: (context, snapshot) {
          final List<AddressModel> addresses = snapshot.hasData
              ? snapshot.data!.docs
              .map((doc) => AddressModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList()
              : [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length + 1, // Always +1 for 'Add New Address'
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.add_location_alt_outlined, color: Colors.blue),
                    title: const Text(
                      "Add New Address",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressScreen(),));
                    },
                  ),
                );
              }

              final address = addresses[index - 1];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(address.name ?? ""),
                      const Spacer(),
                      Card(
                        color: Colors.white,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              address.addressType ?? "",
                              style: const TextStyle(color: Colors.black87),
                        )
                        )
                      )
                    ],
                  ),
                  subtitle: Text(
                    "${address.phoneNumber ?? ""}\n"
                    "${address.buildingName ?? ""}, ${address.areaName ?? ""}\n"
                        "${address.city ?? ""} - ${address.pincode ?? ""}, ${address.state ?? ""}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(address: address),));
                        },
                      ),
                      // Delete Button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          confirmDelete(context, address.addressId ?? '');
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
