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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Delete Address",
            style: TextStyle(fontWeight: FontWeight.bold)),
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
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          "Saved Addresses",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('address')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<AddressModel> addresses = snapshot.hasData
              ? snapshot.data!.docs
                  .map((doc) =>
                      AddressModel.fromJson(doc.data() as Map<String, dynamic>))
                  .toList()
              : [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addresses.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.add_location_alt_outlined,
                        color: Colors.white),
                    title: const Text(
                      "Add New Address",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddAddressScreen()),
                      );
                    },
                  ),
                );
              }

              final address = addresses[index - 1];

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            address.name ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              address.addressType ?? "",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${address.phoneNumber ?? ""}",
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${address.buildingName ?? ""}, ${address.areaName ?? ""}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "${address.city ?? ""} - ${address.pincode ?? ""}, ${address.state ?? ""}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditAddressScreen(address: address),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              confirmDelete(context, address.addressId ?? '');
                            },
                          ),
                        ],
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
