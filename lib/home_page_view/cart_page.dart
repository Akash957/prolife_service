import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../getx_service/getx_screen.dart';
import '../models/partners_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final categoryController = Get.put(GetService());

  void removeItem(int index) {
    categoryController.cartItems.removeAt(index); // Use cartItems here
  }

  void insertItem(int index, PartnersModel item) {
    categoryController.cartItems.insert(index, item); // And here
  }

  void clearCart() {
    categoryController.cartItems.clear(); // And here
  }

  double get total => categoryController.cartItems.fold(
      0.0, (sum, item) => sum + double.parse(item.originalPrice.toString()));

  void showAlertDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(

        title: const Text('Alert'),
        content: const Text('No Item in Cart'),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Cart')),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() => categoryController.cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined,
                size: 60, color: Colors.grey),
            const SizedBox(height: 10),
            const Text('No Item in Cart', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
              }, // Example: Disable if cart is empty
              child: const Text('Go To Home'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: categoryController.cartItems.length, // Use cartItems here
        itemBuilder: (context, index) {
          final item = categoryController.cartItems[index]; // And here
          return Dismissible(
            key: Key(item.name),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => removeItem(index),
            child: Card(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.network(item.workingImageUrl),
                title: Text(item.workType),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: ₹${item.originalPrice}'),
                    Text('Size: ${item.name}'),
                  ],
                ),
                trailing: TextButton(
                  onPressed: () => removeItem(index),
                  child: const Text('Remove'),
                ),
              ),
            ),
          );
        },
      )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Total: ₹$total',
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
              width: 130,
              child: ElevatedButton(
                onPressed: total == 0
                    ? showAlertDialog
                    : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proceeding to Payment')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}