import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final categoryController = Get.put(GetService());
  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Booking Summary")),
      body: Column(

        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: categoryController.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = categoryController.filteredProducts[index];
                return   SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalWidget.BookingImage(
                            context,product.imageUrl),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              GlobalWidget.WorkNameText(context, product.name),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: RatingBar.builder(
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemBuilder:
                                      (context, _) => Icon(Icons.star, color: Colors.blue),
                                  onRatingUpdate: (rating) {
                                  },
                                ),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(width: 5,),
                                  Text("₹${product.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                                  SizedBox(width: 80),
                                  Row(
                                    children: [
                                      Container(
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
                                      SizedBox(width: 20),
                                      GlobalWidget.IncreaseDecreaseButton(
                                            () {},
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
                      Divider(indent: 10,endIndent: 10,height: 50,thickness: 2,),
                      GlobalWidget.WorkNameText(context, "Frequently added together"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              height: heightScreen * 0.4,
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GlobalWidget.BestServicesImage1(
                                      context,
                                      "https://media.istockphoto.com/id/1350701180/photo/woman-cleaning-floor-with-mop.jpg?s=612x612&w=0&k=20&c=xZBxsNd-qIFKOcyMywRGIV2u9bp-HuWZSAk_OaWwzKc=",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: RatingBar.builder(
                                        // minRating: 0,
                                        // direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemBuilder:
                                            (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print('User selected rating: $rating');
                                        },
                                      ),
                                    ),
                                    GlobalWidget.WorkNameText(
                                      context,
                                      "Complete Kitchen Clinaning",
                                    ),
                                    Row(
                                      children: [
                                        GlobalWidget.TextSpanTextOriginal(
                                          context,
                                          "150",
                                          "50",
                                        ),
                                        SizedBox(width: 80),
                                        GlobalWidget.ServicesProvideAddButton(
                                              () {},
                                          context,
                                          "Add",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: heightScreen * 0.4,
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GlobalWidget.BestServicesImage1(
                                      context,
                                      "https://www.housewashingexperts.com.au/wp-content/uploads/2022/05/s2-17-1080x675.jpg",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: RatingBar.builder(
                                        // minRating: 0,
                                        // direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemBuilder:
                                            (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print('User selected rating: $rating');
                                        },
                                      ),
                                    ),
                                    GlobalWidget.WorkNameText(
                                      context,
                                      "Complete Kitchen Clinaning",
                                    ),
                                    Row(
                                      children: [
                                        GlobalWidget.TextSpanTextOriginal(
                                          context,
                                          "150",
                                          "50",
                                        ),
                                        SizedBox(width: 80),
                                        GlobalWidget.ServicesProvideAddButton(
                                              () {
                                          },
                                          context,
                                          "Add",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: heightScreen * 0.4,
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GlobalWidget.BestServicesImage1(
                                      context,
                                      "https://www.housewashingexperts.com.au/wp-content/uploads/2022/05/s2-17-1080x675.jpg",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: RatingBar.builder(
                                        // minRating: 0,
                                        // direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemBuilder:
                                            (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print('User selected rating: $rating');
                                        },
                                      ),
                                    ),
                                    GlobalWidget.WorkNameText(
                                      context,
                                      "Complete Kitchen Clinaning",
                                    ),
                                    Row(
                                      children: [
                                        GlobalWidget.TextSpanTextOriginal(
                                          context,
                                          "150",
                                          "50",
                                        ),
                                        SizedBox(width: 80),
                                        GlobalWidget.ServicesProvideAddButton(
                                              () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder:
                                            //         (context) =>
                                            //         ServiceDetailsPage(),
                                            //   ),
                                            // );
                                          },
                                          context,
                                          "Add",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
                      Row(
                        children: [
                          InkWell(onTap: () {},child:Image(image: AssetImage("assets/image/discount.png",),width: 50,height: 50,)),
                          GlobalWidget.WorkNameText(context, "Apply Coupon"),
                          Spacer(),
                          InkWell(onTap: () {},child: Icon(Icons.keyboard_arrow_right,size: 35,),),
                          SizedBox(width: 20,)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text( "Item Total",style: TextStyle(fontSize: 20),),
                          Spacer(),
                          Text("₹200",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                          SizedBox(width: 20,)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text( "Discount",style: TextStyle(fontSize: 20),),
                          Spacer(),
                          Text("₹20",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
                          SizedBox(width: 20,)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Text( "Service Fee",style: TextStyle(fontSize: 20,color: Colors.blue),),
                          Spacer(),
                          Text("Free",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.blue),),
                          SizedBox(width: 20,)
                        ],
                      ),
                      Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          GlobalWidget.WorkNameText(context, "Grand Total"),
                          Spacer(),
                          Text("₹180",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),),
                          SizedBox(width: 20,)
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade200,
                              borderRadius: BorderRadius.circular(
                                5,
                              ), // Border radius yahan set hota hai
                            ),
                            child: Icon(Icons.location_on_outlined,size: 25,),
                          ),
                          Text("Address"),
                          Spacer(),
                          Text("Change",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.grey.shade500),),
                          SizedBox(width: 20,)
                        ],
                      ),
                      Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          Column(children: [
                            GlobalWidget.WorkNameText(context, "Price"),
                            Text("₹180",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),),
                          ],),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 160,
                              height: 45,
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSummaryScreen(),));
                                },
                                child: Text(
                                  "Booking Now",
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,)
                        ],
                      ),


                    ],
                  ),
                );
              },
            ))

          ),
        ],
      ),
    );
  }
}
