import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/address_model.dart';
import 'address_screen.dart';
import 'package:provider/provider.dart';
import '../provider/address_provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Addresses", style: TextStyle(fontSize: 25)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('address').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No addresses found"));
          }

          final addresses = snapshot.data!.docs
              .map((doc) => AddressModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.add_location_alt_outlined, color: Colors.blue),
                    title: const Text("Add New Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    onTap: () {
                      Get.to(const AddressScreen());
                    },
                  ),
                );
              }

              final address = addresses[index - 1];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(address.name ?? ""),
                  subtitle: Text(
                    "${address.buildingName ?? ""}, ${address.areaName ?? ""}\n"
                        "${address.city ?? ""} - ${address.pincode ?? ""}, ${address.state ?? ""}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      confirmDelete(context, address.addressId ?? '');
                    },
                  ),
                  onTap: () {
                    // Handle address tap if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
