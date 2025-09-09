// import 'package:flutter/material.dart';
//
//
//
// class PhoneVerificationPage extends StatefulWidget {
//   const PhoneVerificationPage({super.key});
//
//   @override
//   _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
// }
//
// class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
//   final TextEditingController phoneController = TextEditingController();
//   String selectedCountryCode = "+91"; // default India
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 40),
//               const Text(
//                 "Enter Phone number for verification",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "This number will be used for all ride-related communication. "
//                     "You will receive an SMS with code for verification",
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//               const SizedBox(height: 30),
//
//               // Phone Input Row
//               Row(
//                 children: [
//                   // Country Code Dropdown
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(color: Colors.grey.shade400),
//                       ),
//                     ),
//                     child: DropdownButton<String>(
//                       value: selectedCountryCode,
//                       underline: const SizedBox(),
//                       items: ["+91", "+1", "+44", "+61"].map((code) {
//                         return DropdownMenuItem(
//                           value: code,
//                           child: Text(code),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedCountryCode = value!;
//                         });
//                       },
//                     ),
//                   ),
//
//                   const SizedBox(width: 10),
//
//                   // Phone Number Input
//                   Expanded(
//                     child: TextField(
//                       controller: phoneController,
//                       maxLength: 10,
//                       keyboardType: TextInputType.phone,
//                       decoration: const InputDecoration(
//                         counterText: "",
//                         hintText: "Phone Number",
//                         border: UnderlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 40),
//
//               // Continue Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.indigo.shade900,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   onPressed: () {
//                     // Phone number verification logic
//                     print("Phone: $selectedCountryCode ${phoneController.text}");
//                   },
//                   child: const Text("Continue",
//                       style: TextStyle(color: Colors.white, fontSize: 16)),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Row(
//                 children: const [
//                   Expanded(child: Divider()),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Text("or"),
//                   ),
//                   Expanded(child: Divider()),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               // Google Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     side: const BorderSide(color: Colors.grey),
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   onPressed: () {
//                     // Google login logic
//                     print("Continue with Google");
//                   },
//                   icon: Image.network(
//                     "https://cdn-icons-png.flaticon.com/512/300/300221.png",
//                     height: 20,
//                   ),
//                   label: const Text(
//                     "Continue with Google",
//                     style: TextStyle(color: Colors.black, fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx_service/getx_screen.dart';

class CartScreen extends StatelessWidget {
  final categoryController = Get.put(GetService());

  CartScreen({super.key}) {
    categoryController.loadCartFirebase(); // Load cart on init
  }

  double get total => categoryController.cartItems
      .fold(0.0, (sum, item) => sum + double.parse(item.originalPrice.toString()));

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('No Item Selected'),
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
    var widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
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

              return
                GestureDetector(
                onLongPress: () {
                  if (categoryController.selectedItems.contains(index)) {
                    categoryController.selectedItems.remove(index);
                  } else {
                    categoryController.selectedItems.add(index);
                  }
                },
                child: Obx(() {
                  bool isSelected = categoryController.selectedItems.contains(index);

                  return Card(
                    elevation: 2,
                    color: isSelected ? Colors.blue.shade50 : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: isSelected
                          ? const BorderSide(color: Colors.blue, width: 2)
                          : BorderSide.none,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.workingImageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Center(
                                      child: CircularProgressIndicator(strokeWidth: 2)),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.partnerName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.workType,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  "₹${item.originalPrice}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => categoryController.removeFromCart(index),
                            child: const Icon(Icons.delete, size: 26, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        double total = categoryController.cartItems.fold(
          0.0,
              (sum, item) => sum + double.parse(item.originalPrice.toString()),
        );

        double selectedTotal = categoryController.selectedItems.fold(0.0, (sum, index) {
          return sum + double.parse(categoryController.cartItems[index].originalPrice.toString());
        });

        return Container(
          color: Colors.blue.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: ₹$total',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Selected: ₹$selectedTotal',
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                height: 55,
                child: ElevatedButton(
                  onPressed: categoryController.selectedItems.isEmpty
                      ? () => showAlertDialog(context)
                      : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Booking Selected Items - Total: ₹$selectedTotal'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text('Book Selected',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
