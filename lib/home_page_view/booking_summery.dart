import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prolife_service/home_page_view/service_details.dart';
import 'package:provider/provider.dart';
import '../address_screen/select_address.dart';
import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import '../models/partners_model.dart';
import '../provider/cart_provider.dart';
import '../provider/payment_provider.dart';

class BookingSummaryScreen extends StatefulWidget {
  final PartnersModel product;
  final PartnersModel partner;

  const BookingSummaryScreen({
    super.key,
    required this.product,
    required this.partner,
  });

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final categoryController = Get.put(GetService());

  @override
  void dispose() {
    Provider.of<PaymentProvider>(context, listen: false).disposeRazorpay();
    super.dispose();
  }

  int getOriginalTotal(int quantity) => int.parse(widget.product.originalPrice) * quantity;
  int getDiscountTotal(int quantity) => int.parse(widget.product.discountPrice) * quantity;

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    final paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Booking Summary")),
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
          final int discount =originalTotal - discountTotal;

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalWidget.BookingImage(context, widget.product.workingImageUrl),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      GlobalWidget.WorkNameText(
                          context, widget.product.serviceName),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: RatingBar.builder(
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.blue),
                          onRatingUpdate: (rating) {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          Text(
                            "₹${widget.product.originalPrice}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                           SizedBox(width:widthScreen*0.15),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<CartProvider>(context, listen: false).decreaseQuantity();
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(Icons.remove,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  cart.quantity.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .increaseQuantity();
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(Icons.add,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 350,
                        child: Obx(() => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  categoryController.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final partner = categoryController.filteredProducts[index];
                                return SizedBox(
                                  width: 250,
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        GlobalWidget.BestServicesImage1(
                                           () {

                                           }
                                            ,context,
                                            widget.product.workingImageUrl),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: RatingBar.builder(
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 30,
                                            itemBuilder: (context, _) =>
                                                const Icon(Icons.star,
                                                    color: Colors.blue),
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ),
                                        GlobalWidget.WorkNameText(
                                            context, partner.serviceName),
                                        GlobalWidget.TextSpanTextOriginal(
                                            context,
                                            partner.originalPrice,
                                            partner.discountPrice),
                                        const SizedBox(width: 50),
                                        Row(
                                          children: [
                                            GlobalWidget
                                                .BestServicesCircleAvatar2(
                                                    context,
                                                    partner.profileImage,() {
                                              Get.to(GlobalWidget.fullScreenImage(context, partner.profileImage));
                                                    },),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GlobalWidget.workername(
                                                    context, partner.name),
                                                GlobalWidget.serviceType(
                                                    context, partner.workType),
                                              ],
                                            ),
                                            const Spacer(),
                                            GlobalWidget
                                                .ServicesProvideAddButton(() {
                                              Get.to(ServiceDetailsPage(
                                                  product: partner));
                                            }, context, "Add"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No address selected",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Tap to select your address",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50))),
                  builder: (context) => SelectAddress());
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

  Widget bottomRow(int total, PaymentProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalWidget.WorkNameText(context, "Price"),
              const SizedBox(height: 5),
              Text("₹$total",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23)),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            onPressed: () {
              provider.openCheckout(
                partnerId: widget.partner.partnerId,
                name: widget.partner.name,
                serviceName: widget.partner.serviceName,
                originalPrice: widget.partner.originalPrice,
                discountPrice: widget.partner.discountPrice,
                workingImageUrl: widget.partner.workingImageUrl,
                profileImage: widget.partner.profileImage,
                quantity:
                    Provider.of<CartProvider>(context, listen: false).quantity,
              );
            },
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
