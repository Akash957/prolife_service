import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import '../models/partners_model.dart';
import '../provider/cart_provider.dart';
import 'service_details.dart';

class BookingSummaryScreen extends StatefulWidget {
  final PartnersModel product;

  const BookingSummaryScreen({super.key, required this.product});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final categoryController = Get.put(GetService());

  @override
  Widget build(BuildContext context) {
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

          int originalTotal =
              int.parse(widget.product.originalPrice) * cart.quantity;
          int discountTotal =
              int.parse(widget.product.discountPrice) * cart.quantity;

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalWidget.BookingImage(
                      context, widget.product.workingImageUrl),
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
                          const SizedBox(width: 80),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .decreaseQuantity();
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
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 350,
                        child: Obx(() => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  categoryController.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final partner =
                                    categoryController.filteredProducts[index];
                                return Container(
                                  width: 250,
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        GlobalWidget.BestServicesImage1(context,
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
                                                    partner.profileImage),
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
                        indent: 10,
                        endIndent: 10,
                        height: 30,
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {},
                            child: const Image(
                              image: AssetImage("assets/image/discount.png"),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          GlobalWidget.WorkNameText(context, "Apply Coupon"),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: const Icon(Icons.keyboard_arrow_right,
                                color: Colors.grey, size: 35),
                          ),
                          const SizedBox(width: 20)
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Text("Item Total",
                              style: TextStyle(fontSize: 20)),
                          const Spacer(),
                          Text("₹$originalTotal",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21)),
                          const SizedBox(width: 20)
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Text("Discount",
                              style: TextStyle(fontSize: 20)),
                          const Spacer(),
                          Text("₹$discountTotal",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 21)),
                          const SizedBox(width: 20)
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Text("Service Fee",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue)),
                          const Spacer(),
                          const Text("Free",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.blue)),
                          const SizedBox(width: 20)
                        ],
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        height: 30,
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          GlobalWidget.WorkNameText(context, "Grand Total"),
                          const Spacer(),
                          Text("₹$originalTotal",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23)),
                          const SizedBox(width: 20)
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.location_on_outlined,
                              size: 25,
                            ),
                          ),
                          const Text("Address"),
                          const Spacer(),
                          const Text("Change",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: Colors.grey)),
                          const SizedBox(width: 20)
                        ],
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        height: 30,
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              GlobalWidget.WorkNameText(context, "Price"),
                              GlobalWidget.TextSpanTextOriginal(
                                  context, widget.product.originalPrice, ''),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                // your booking logic
                              },
                              child: const Text("Booking Now",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ),
                          ),
                          const SizedBox(width: 20)
                        ],
                      ),
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
}
