import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prolife_service/home_page_view/service_details.dart';
import 'package:provider/provider.dart';
import '../address_screen/select_address.dart';
import '../address_screen/select_booking_slot.dart';
import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import '../models/address_model.dart';
import '../models/partners_model.dart';
import '../provider/cart_provider.dart';
import '../provider/payment_provider.dart';

class BookingSummaryScreen extends StatefulWidget {
  final PartnersModel product;

  const BookingSummaryScreen({
    super.key,
    required this.product,
  });

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final categoryController = Get.put(GetService());
  AddressModel? selectedAddress;
  late PaymentProvider paymentProvider;

  @override
  void initState() {
    super.initState();
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    paymentProvider.registerRazorPay();
  }

  @override
  void dispose() {
    // paymentProvider.disposeRazorpay();
    super.dispose();
  }

  int getOriginalTotal(int quantity) =>
      int.parse(widget.product.originalPrice) * quantity;

  int getDiscountTotal(int quantity) =>
      int.parse(widget.product.discountPrice) * quantity;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white, title: const Text("Booking Summary")),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.quantity == 0) {
            return const Center(
              child: Text(
                "No item in cart",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            );
          }

          final int originalTotal = getOriginalTotal(cart.quantity);
          final int discountTotal = getDiscountTotal(cart.quantity);
          final int discount = originalTotal - discountTotal;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 5,
                      child: GlobalWidget.BookingImage(
                          context, widget.product.workingImageUrl),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Flexible(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          GlobalWidget.WorkNameText(
                              context, widget.product.serviceName),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: 4.5,
                                itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                                itemCount: 5,
                                itemSize: screenWidth * 0.05,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text('4.5',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.black.withOpacity(0.7))),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            children: [
                              Text("₹${widget.product.originalPrice}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.05)),
                              const Spacer(),
                              quantityControl(context, cart),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 350,
                      //   child: Obx(() => ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount:
                      //     categoryController.filteredProducts.length,
                      //     itemBuilder: (context, index) {
                      //       final partner =
                      //       categoryController.filteredProducts[index];
                      //       return SizedBox(
                      //         width: 250,
                      //         child: Card(
                      //           color: Colors.white,
                      //           child: Column(
                      //             crossAxisAlignment:
                      //             CrossAxisAlignment.start,
                      //             children: [
                      //               const SizedBox(height: 20),
                      //               GlobalWidget.BestServicesImage1(context,
                      //                   widget.product.workingImageUrl),
                      //               Row(
                      //                 children: [
                      //                   RatingBarIndicator(
                      //                     rating: 4.0,
                      //                     itemBuilder: (context, _) =>
                      //                     const Icon(Icons.star,
                      //                         color: Colors.amber),
                      //                     itemCount: 5,
                      //                     itemSize: 25,
                      //                   ),
                      //                   const SizedBox(width: 6),
                      //                   Text(
                      //                     '4.0',
                      //                     style: TextStyle(
                      //                       fontWeight: FontWeight.w600,
                      //                       fontSize: 13,
                      //                       color: Colors.black
                      //                           .withOpacity(0.7),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               GlobalWidget.WorkNameText(
                      //                   context, partner.serviceName),
                      //               GlobalWidget.TextSpanTextOriginal(
                      //                   context,
                      //                   partner.originalPrice,
                      //                   partner.discountPrice),
                      //               const SizedBox(width: 50),
                      //               Row(
                      //                 children: [
                      //                   GlobalWidget
                      //                       .BestServicesCircleAvatar2(
                      //                       context,
                      //                       partner.profileImage),
                      //                   Column(
                      //                     crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                     children: [
                      //                       GlobalWidget.workername(
                      //                           context, partner.name),
                      //                       GlobalWidget.serviceType(
                      //                           context, partner.workType),
                      //                     ],
                      //                   ),
                      //                   const Spacer(),
                      //                   GlobalWidget
                      //                       .ServicesProvideAddButton(() {
                      //                     Get.to(ServiceDetailsPage(
                      //                         product: partner));
                      //                   }, context, "Add"),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   )),
                      // ),
                      const Divider(
                          indent: 10, endIndent: 10, height: 30, thickness: 2),
                      priceRow("Item Total", originalTotal),
                      priceRow("Discount", discountTotal),
                      priceRow("Service Fee", 0, free: true),
                      const Divider(
                          indent: 10, endIndent: 10, height: 30, thickness: 2),
                      priceRow("Grand Total", discount),
                      const Divider(
                          indent: 10, endIndent: 10, height: 30, thickness: 2),
                      addressRow(),
                      const Divider(
                          indent: 10, endIndent: 10, height: 30, thickness: 2),
                      bottomRow(discount, paymentProvider),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget quantityControl(BuildContext context, CartProvider cart) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        buildIconButton(
            Icons.remove, () => cart.decreaseQuantity(), screenWidth),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Text(
            cart.quantity.toString(),
            style: TextStyle(fontSize: screenWidth * 0.045),
          ),
        ),
        buildIconButton(Icons.add, () => cart.increaseQuantity(), screenWidth),
      ],
    );
  }

  Widget buildIconButton(IconData icon, VoidCallback onTap, double width) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: width * 0.1,
        width: width * 0.1,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(5)),
        child: Icon(icon, color: Colors.white, size: width * 0.06),
      ),
    );
  }

  Widget priceRow(String label, int amount, {bool free = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 20, color: free ? Colors.blue : Colors.black)),
          const Spacer(),
          Text(
            free ? "Free" : "₹$amount",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: free ? Colors.blue : Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget addressRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              size: 30,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedAddress != null
                      ? (selectedAddress?.addressType ?? "Address")
                      : "No address selected",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedAddress != null
                      ? "${selectedAddress?.name ?? ''}, ${selectedAddress?.buildingName ?? ''}, ${selectedAddress?.areaName ?? ''}, ${selectedAddress?.city ?? ''} - ${selectedAddress?.pincode ?? ''}, ${selectedAddress?.state ?? ''}"
                      : "Tap to select your address",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              final result = await showModalBottomSheet<AddressModel>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(50))),
                builder: (context) => const SelectAddress(),
              );

              if (result != null) {
                setState(() {
                  selectedAddress = result;
                });
              }
            },
            child: const Text(
              "Change",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomRow(int discount, PaymentProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalWidget.WorkNameText(context, "Price"),
              const SizedBox(height: 5),
              Text("₹$discount",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23)),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedAddress != null
                  ? Colors.orange
                  : Colors.grey, // Color based on address
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            onPressed: selectedAddress != null
                ? () {
              var payablePrice = discount *100;
              Get.to(SelectBookingSlot(partner: widget.product, payablePrice: "$payablePrice" ,));
            }
                : null,
            child: const Text(
              "Book",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}