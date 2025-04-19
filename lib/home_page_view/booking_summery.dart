import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import '../models/partners_model.dart';

class BookingSummaryScreen extends StatefulWidget {
  final PartnersModel product;

  const BookingSummaryScreen({super.key, required this.product});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final categoryController = Get.put(GetService());
  int addData = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking Summary")),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlobalWidget.BookingImage(
                  context, widget.product.workingImageUrl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  GlobalWidget.WorkNameText(context, widget.product.name),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: RatingBar.builder(
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 25,
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.blue),
                      onRatingUpdate: (rating) {},
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "₹${widget.product.originalPrice}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      SizedBox(width: 80),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ), // Border radius yahan set hota hai
                              ),
                              child: Divider(
                                color: Colors.white,
                                endIndent: 8,
                                thickness: 3,
                                indent: 8,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "1",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          GlobalWidget.IncreaseDecreaseButton(
                            () {
                              setState(() {
                                addData++;
                              });
                            },
                            context,
                            Icons.add,
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
                    child: Expanded(
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
                                        SizedBox(
                                          height: 20,
                                        ),
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
                                                const Icon(
                                              Icons.star,
                                              color: Colors.blue,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print('Rating: $rating');
                                            },
                                          ),
                                        ),
                                        GlobalWidget.WorkNameText(
                                            context, partner.serviceName),
                                        GlobalWidget.TextSpanTextOriginal(
                                            context,
                                            partner.originalPrice,
                                            partner.discountPrice),
                                        SizedBox(
                                          width: 50,
                                        ),
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
                                                .ServicesProvideAddButton(
                                              () {
                                                // Get.to(ServiceDetailsPage(product: partner));
                                              },
                                              context,
                                              "Add",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ))),
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    height: 30,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Image(
                            image: AssetImage(
                              "assets/image/discount.png",
                            ),
                            width: 50,
                            height: 50,
                          )),
                      GlobalWidget.WorkNameText(context, "Apply Coupon"),
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Item Total",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        widget.product.originalPrice,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Discount",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        "₹20",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Service Fee",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                      Spacer(),
                      Text(
                        "Free",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.blue),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    height: 30,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      GlobalWidget.WorkNameText(context, "Grand Total"),
                      Spacer(),
                      Text(
                        widget.product.originalPrice,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade200,
                          borderRadius: BorderRadius.circular(
                            5,
                          ), // Border radius yahan set hota hai
                        ),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 25,
                        ),
                      ),
                      Text("Address"),
                      Spacer(),
                      Text(
                        "Change",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.grey.shade500),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    height: 30,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          GlobalWidget.WorkNameText(context, "Price"),
                          GlobalWidget.WorkNameText(context, "Price"),
                          // GlobalWidget.TextSpanTextOriginal(context, widget.product.price1,''),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                5,
                              ), // Border radius 5
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSummaryScreen(),));
                          },
                          child: Text(
                            "Booking Now",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
