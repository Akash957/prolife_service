import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx_service/getx_screen.dart';

class CartScreen extends StatelessWidget {
  final categoryController = Get.put(GetService());

  CartScreen({super.key}) {
    categoryController.loadCartFirebase(); // Important: Load on init
  }
  double get total => categoryController.cartItems.fold(
      0.0, (sum, item) => sum + double.parse(item.originalPrice.toString()));

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('No Item in Cart'),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), backgroundColor: Colors.blue),
      body: Obx(() {
        if (categoryController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined, size: 60, color: Colors.grey),
                const SizedBox(height: 10),
                const Text('No Item in Cart', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Go To Home'),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: categoryController.cartItems.length,
            itemBuilder: (context, index) {
              final item = categoryController.cartItems[index];
              return Dismissible(
                key: Key(item.partnerId),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) =>
                    categoryController.removeFromCart(index),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(item.workingImageUrl),
                    title: Text(item.workType),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ₹${item.originalPrice}'),
                        Text('Service: ${item.name}'),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () => categoryController.removeFromCart(index),
                      child: const Text('Remove'),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        double total = categoryController.cartItems.fold(
            0.0, (sum, item) => sum + double.parse(item.originalPrice.toString()));
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total: ₹$total',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 50,
                width: 130,
                child: ElevatedButton(
                  onPressed: total == 0
                      ? () => showAlertDialog(context)
                      : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Proceeding to Payment')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  ),
                  child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
