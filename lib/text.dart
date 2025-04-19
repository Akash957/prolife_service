// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../getx_service/getx_screen.dart';
// import '../global_widget/globle_screen.dart';
// import '../models/partners_model.dart';
//
// class BookingSummaryScreen extends StatefulWidget {
//   final PartnersModel product;
//
//   const BookingSummaryScreen({super.key, required this.product});
//
//   @override
//   State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
// }
//
// class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
//   final categoryController = Get.put(GetService());
//
//   @override
//   Widget build(BuildContext context) {
//     var heightScreen = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(title: Text("Booking Summary")),
//       body: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GlobalWidget.BookingImage(
//                   context, widget.product.workingImageUrl),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   GlobalWidget.WorkNameText(context, widget.product.name),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 5),
//                     child: RatingBar.builder(
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemSize: 30,
//                       itemBuilder: (context, _) =>
//                           Icon(Icons.star, color: Colors.blue),
//                       onRatingUpdate: (rating) {},
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         "₹${widget.product.price2}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 21),
//                       ),
//                       SizedBox(width: 80),
//                       Row(
//                         children: [
//                           InkWell(
//                             onTap: () {},
//                             child: Container(
//                               height: 35,
//                               width: 35,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue,
//                                 borderRadius: BorderRadius.circular(
//                                   5,
//                                 ), // Border radius yahan set hota hai
//                               ),
//                               child: Divider(
//                                 color: Colors.white,
//                                 endIndent: 8,
//                                 thickness: 3,
//                                 indent: 8,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Text(
//                               "1",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                           GlobalWidget.IncreaseDecreaseButton(
//                                 () {},
//                             context,
//                             Icons.add,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Obx(
//                 () => GridView.builder(
//               itemCount: categoryController.filteredProducts.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 mainAxisSpacing: 1,
//                 crossAxisSpacing: 1,
//                 childAspectRatio: 0.8,
//               ),
//               itemBuilder: (context, index) {
//
//                 return
//                 SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Divider(indent: 10,endIndent: 10,height: 5,thickness: 2,),
//                       GlobalWidget.WorkNameText(context, "Frequently added together"),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               height:310,
//                               child: Card(
//                                 color: Colors.white70,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     GlobalWidget.BestServicesImage1(
//                                       context,
//                                       widget.product.workingImageUrl
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 8),
//                                       child: RatingBar.builder(
//                                         allowHalfRating: true,
//                                         itemCount: 5,
//                                         itemSize: 30,
//                                         itemBuilder:
//                                             (context, _) => Icon(
//                                           Icons.star,
//                                           color: Colors.blue,
//                                         ),
//                                         onRatingUpdate: (rating) {
//                                           print('User selected rating: $rating');
//                                         },
//                                       ),
//                                     ),
//                                     GlobalWidget.WorkNameText(
//                                       context,
//                                       "Complete Kitchen Clinaning",
//                                     ),
//                                     GlobalWidget.TextSpanTextOriginal(
//                                       context,
//                                       "150",
//                                       "50",
//                                     ),
//                                     Row(
//                                       children: [
//                                         GlobalWidget.BestServicesCircleAvatar2(context,widget.product.profile_image),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             GlobalWidget.workername(
//                                                 context, widget.product.name),
//                                             GlobalWidget.serviceType(
//                                                 context, widget.product.workType),
//                                           ],
//                                         ),
//                                         SizedBox(width: 80),
//                                         GlobalWidget.ServicesProvideAddButton(
//                                               () {},
//                                           context,
//                                           "Add",
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//
//                             // SizedBox(
//                             //   height: heightScreen * 0.4,
//                             //   child: Card(
//                             //     child: Column(
//                             //       crossAxisAlignment: CrossAxisAlignment.start,
//                             //       mainAxisAlignment: MainAxisAlignment.start,
//                             //       children: [
//                             //         GlobalWidget.BestServicesImage1(
//                             //           context,
//                             //           "https://www.housewashingexperts.com.au/wp-content/uploads/2022/05/s2-17-1080x675.jpg",
//                             //         ),
//                             //         Padding(
//                             //           padding: const EdgeInsets.only(left: 8),
//                             //           child: RatingBar.builder(
//                             //             // minRating: 0,
//                             //             // direction: Axis.horizontal,
//                             //             allowHalfRating: true,
//                             //             itemCount: 5,
//                             //             itemSize: 30,
//                             //             itemBuilder:
//                             //                 (context, _) => Icon(
//                             //               Icons.star,
//                             //               color: Colors.blue,
//                             //             ),
//                             //             onRatingUpdate: (rating) {
//                             //               print('User selected rating: $rating');
//                             //             },
//                             //           ),
//                             //         ),
//                             //         GlobalWidget.WorkNameText(
//                             //           context,
//                             //           "Complete Kitchen Clinaning",
//                             //         ),
//                             //         Row(
//                             //           children: [
//                             //             GlobalWidget.TextSpanTextOriginal(
//                             //               context,
//                             //               "150",
//                             //               "50",
//                             //             ),
//                             //             SizedBox(width: 80),
//                             //             GlobalWidget.ServicesProvideAddButton(
//                             //                   () {
//                             //               },
//                             //               context,
//                             //               "Add",
//                             //             ),
//                             //           ],
//                             //         ),
//                             //       ],
//                             //     ),
//                             //   ),
//                             // ),
//                             // SizedBox(
//                             //   height: heightScreen * 0.4,
//                             //   child: Card(
//                             //     child: Column(
//                             //       crossAxisAlignment: CrossAxisAlignment.start,
//                             //       mainAxisAlignment: MainAxisAlignment.start,
//                             //       children: [
//                             //         GlobalWidget.BestServicesImage1(
//                             //           context,
//                             //           "https://www.housewashingexperts.com.au/wp-content/uploads/2022/05/s2-17-1080x675.jpg",
//                             //         ),
//                             //         Padding(
//                             //           padding: const EdgeInsets.only(left: 8),
//                             //           child: RatingBar.builder(
//                             //             // minRating: 0,
//                             //             // direction: Axis.horizontal,
//                             //             allowHalfRating: true,
//                             //             itemCount: 5,
//                             //             itemSize: 30,
//                             //             itemBuilder:
//                             //                 (context, _) => Icon(
//                             //               Icons.star,
//                             //               color: Colors.blue,
//                             //             ),
//                             //             onRatingUpdate: (rating) {
//                             //               print('User selected rating: $rating');
//                             //             },
//                             //           ),
//                             //         ),
//                             //         GlobalWidget.WorkNameText(
//                             //           context,
//                             //           "Complete Kitchen Clinaning",
//                             //         ),
//                             //         Row(
//                             //           children: [
//                             //             GlobalWidget.TextSpanTextOriginal(
//                             //               context,
//                             //               "150",
//                             //               "50",
//                             //             ),
//                             //             SizedBox(width: 80),
//                             //             GlobalWidget.ServicesProvideAddButton(
//                             //                   () {
//                             //                 // Navigator.push(
//                             //                 //   context,
//                             //                 //   MaterialPageRoute(
//                             //                 //     builder:
//                             //                 //         (context) =>
//                             //                 //         ServiceDetailsPage(),
//                             //                 //   ),
//                             //                 // );
//                             //               },
//                             //               context,
//                             //               "Add",
//                             //             ),
//                             //           ],
//                             //         ),
//                             //       ],
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                       // Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
//                       // Row(
//                       //   children: [
//                       //     InkWell(onTap: () {},child:Image(image: AssetImage("assets/image/discount.png",),width: 50,height: 50,)),
//                       //     GlobalWidget.WorkNameText(context, "Apply Coupon"),
//                       //     Spacer(),
//                       //     InkWell(onTap: () {},child: Icon(Icons.keyboard_arrow_right,size: 35,),),
//                       //     SizedBox(width: 20,)
//                       //   ],
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     SizedBox(width: 20,),
//                       //     Text( "Item Total",style: TextStyle(fontSize: 20),),
//                       //     Spacer(),
//                       //     Text("₹200",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
//                       //     SizedBox(width: 20,)
//                       //   ],
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     SizedBox(width: 20,),
//                       //     Text( "Discount",style: TextStyle(fontSize: 20),),
//                       //     Spacer(),
//                       //     Text("₹20",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
//                       //     SizedBox(width: 20,)
//                       //   ],
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     SizedBox(width: 20,),
//                       //     Text( "Service Fee",style: TextStyle(fontSize: 20,color: Colors.blue),),
//                       //     Spacer(),
//                       //     Text("Free",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.blue),),
//                       //     SizedBox(width: 20,)
//                       //   ],
//                       // ),
//                       // Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
//                       // Row(
//                       //   children: [
//                       //     SizedBox(width: 20,),
//                       //     GlobalWidget.WorkNameText(context, "Grand Total"),
//                       //     Spacer(),
//                       //     Text("₹180",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),),
//                       //     SizedBox(width: 20,)
//                       //   ],
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     SizedBox(width: 20,),
//                       //     Container(
//                       //       height: 60,
//                       //       width: 60,
//                       //       decoration: BoxDecoration(
//                       //         color: Colors.blueGrey.shade200,
//                       //         borderRadius: BorderRadius.circular(
//                       //           5,
//                       //         ), // Border radius yahan set hota hai
//                       //       ),
//                       //       child: Icon(Icons.location_on_outlined,size: 25,),
//                       //     ),
//                       //     Text("Address"),
//                       //     Spacer(),
//                       //     Text("Change",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.grey.shade500),),
//                       //     SizedBox(width: 20,)
//                       //   ],
//                       // ),
//                       // Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
//                       // Row(
//                       //   children: [
//                       //     SizedBox(width: 20,),
//                       //     Column(children: [
//                       //       GlobalWidget.WorkNameText(context, "Price"),
//                       //       Text("₹180",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),),
//                       //     ],),
//                       //     Spacer(),
//                       //     Padding(
//                       //       padding: const EdgeInsets.all(8.0),
//                       //       child: SizedBox(
//                       //         width: 160,
//                       //         height: 45,
//                       //         child: ElevatedButton(
//                       //           style: ElevatedButton.styleFrom(
//                       //             backgroundColor: Colors.blue,
//                       //             shape: RoundedRectangleBorder(
//                       //               borderRadius: BorderRadius.circular(
//                       //                 5,
//                       //               ), // Border radius 5
//                       //             ),
//                       //           ),
//                       //           onPressed: () {
//                       //             // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSummaryScreen(),));
//                       //           },
//                       //           child: Text(
//                       //             "Booking Now",
//                       //             style: TextStyle(color: Colors.white, fontSize: 18),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     SizedBox(width: 20,)
//                       //   ],
//                       // ),
//
//
//                     ],
//                   ),
//                 ),
//               },
//             ),
//           )
//           // SingleChildScrollView(
//           //   scrollDirection: Axis.vertical,
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     children: [
//           //       Divider(indent: 10,endIndent: 10,height: 5,thickness: 2,),
//           //       GlobalWidget.WorkNameText(context, "Frequently added together"),
//           //       SingleChildScrollView(
//           //         scrollDirection: Axis.horizontal,
//           //         child: Row(
//           //           children: [
//           //             SizedBox(
//           //               height:310,
//           //               child: Card(
//           //                 color: Colors.white70,
//           //                 child: Column(
//           //                   crossAxisAlignment: CrossAxisAlignment.start,
//           //                   mainAxisAlignment: MainAxisAlignment.start,
//           //                   children: [
//           //                     GlobalWidget.BestServicesImage1(
//           //                       context,
//           //                       widget.product.workingImageUrl
//           //                     ),
//           //                     Padding(
//           //                       padding: const EdgeInsets.only(left: 8),
//           //                       child: RatingBar.builder(
//           //                         allowHalfRating: true,
//           //                         itemCount: 5,
//           //                         itemSize: 30,
//           //                         itemBuilder:
//           //                             (context, _) => Icon(
//           //                           Icons.star,
//           //                           color: Colors.blue,
//           //                         ),
//           //                         onRatingUpdate: (rating) {
//           //                           print('User selected rating: $rating');
//           //                         },
//           //                       ),
//           //                     ),
//           //                     GlobalWidget.WorkNameText(
//           //                       context,
//           //                       "Complete Kitchen Clinaning",
//           //                     ),
//           //                     GlobalWidget.TextSpanTextOriginal(
//           //                       context,
//           //                       "150",
//           //                       "50",
//           //                     ),
//           //                     Row(
//           //                       children: [
//           //                         GlobalWidget.BestServicesCircleAvatar2(context,widget.product.profile_image),
//           //                         Column(
//           //                           crossAxisAlignment: CrossAxisAlignment.start,
//           //                           children: [
//           //                             GlobalWidget.workername(
//           //                                 context, widget.product.name),
//           //                             GlobalWidget.serviceType(
//           //                                 context, widget.product.workType),
//           //                           ],
//           //                         ),
//           //                         SizedBox(width: 80),
//           //                         GlobalWidget.ServicesProvideAddButton(
//           //                               () {},
//           //                           context,
//           //                           "Add",
//           //                         ),
//           //                       ],
//           //                     ),
//           //                   ],
//           //                 ),
//           //               ),
//           //             ),
//           //
//           //             // SizedBox(
//           //             //   height: heightScreen * 0.4,
//           //             //   child: Card(
//           //             //     child: Column(
//           //             //       crossAxisAlignment: CrossAxisAlignment.start,
//           //             //       mainAxisAlignment: MainAxisAlignment.start,
//           //             //       children: [
//           //             //         GlobalWidget.BestServicesImage1(
//           //             //           context,
//           //             //           "https://www.housewashingexperts.com.au/wp-content/uploads/2022/05/s2-17-1080x675.jpg",
//           //             //         ),
//           //             //         Padding(
//           //             //           padding: const EdgeInsets.only(left: 8),
//           //             //           child: RatingBar.builder(
//           //             //             // minRating: 0,
//           //             //             // direction: Axis.horizontal,
//           //             //             allowHalfRating: true,
//           //             //             itemCount: 5,
//           //             //             itemSize: 30,
//           //             //             itemBuilder:
//           //             //                 (context, _) => Icon(
//           //             //               Icons.star,
//           //             //               color: Colors.blue,
//           //             //             ),
//           //             //             onRatingUpdate: (rating) {
//           //             //               print('User selected rating: $rating');
//           //             //             },
//           //             //           ),
//           //             //         ),
//           //             //         GlobalWidget.WorkNameText(
//           //             //           context,
//           //             //           "Complete Kitchen Clinaning",
//           //             //         ),
//           //             //         Row(
//           //             //           children: [
//           //             //             GlobalWidget.TextSpanTextOriginal(
//           //             //               context,
//           //             //               "150",
//           //             //               "50",
//           //             //             ),
//           //             //             SizedBox(width: 80),
//           //             //             GlobalWidget.ServicesProvideAddButton(
//           //             //                   () {
//           //             //               },
//           //             //               context,
//           //             //               "Add",
//           //             //             ),
//           //             //           ],
//           //             //         ),
//           //             //       ],
//           //             //     ),
//           //             //   ),
//           //             // ),
//           //             // SizedBox(
//           //             //   height: heightScreen * 0.4,
//           //             //   child: Card(
//           //             //     child: Column(
//           //             //       crossAxisAlignment: CrossAxisAlignment.start,
//           //             //       mainAxisAlignment: MainAxisAlignment.start,
//           //             //       children: [
//           //             //         GlobalWidget.BestServicesImage1(
//           //             //           context,
//           //             //           "https://www.housewashingexperts.com.au/wp-content/uploads/2022/05/s2-17-1080x675.jpg",
//           //             //         ),
//           //             //         Padding(
//           //             //           padding: const EdgeInsets.only(left: 8),
//           //             //           child: RatingBar.builder(
//           //             //             // minRating: 0,
//           //             //             // direction: Axis.horizontal,
//           //             //             allowHalfRating: true,
//           //             //             itemCount: 5,
//           //             //             itemSize: 30,
//           //             //             itemBuilder:
//           //             //                 (context, _) => Icon(
//           //             //               Icons.star,
//           //             //               color: Colors.blue,
//           //             //             ),
//           //             //             onRatingUpdate: (rating) {
//           //             //               print('User selected rating: $rating');
//           //             //             },
//           //             //           ),
//           //             //         ),
//           //             //         GlobalWidget.WorkNameText(
//           //             //           context,
//           //             //           "Complete Kitchen Clinaning",
//           //             //         ),
//           //             //         Row(
//           //             //           children: [
//           //             //             GlobalWidget.TextSpanTextOriginal(
//           //             //               context,
//           //             //               "150",
//           //             //               "50",
//           //             //             ),
//           //             //             SizedBox(width: 80),
//           //             //             GlobalWidget.ServicesProvideAddButton(
//           //             //                   () {
//           //             //                 // Navigator.push(
//           //             //                 //   context,
//           //             //                 //   MaterialPageRoute(
//           //             //                 //     builder:
//           //             //                 //         (context) =>
//           //             //                 //         ServiceDetailsPage(),
//           //             //                 //   ),
//           //             //                 // );
//           //             //               },
//           //             //               context,
//           //             //               "Add",
//           //             //             ),
//           //             //           ],
//           //             //         ),
//           //             //       ],
//           //             //     ),
//           //             //   ),
//           //             // ),
//           //           ],
//           //         ),
//           //       ),
//           //       Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
//           //       Row(
//           //         children: [
//           //           InkWell(onTap: () {},child:Image(image: AssetImage("assets/image/discount.png",),width: 50,height: 50,)),
//           //           GlobalWidget.WorkNameText(context, "Apply Coupon"),
//           //           Spacer(),
//           //           InkWell(onTap: () {},child: Icon(Icons.keyboard_arrow_right,size: 35,),),
//           //           SizedBox(width: 20,)
//           //         ],
//           //       ),
//           //       Row(
//           //         children: [
//           //           SizedBox(width: 20,),
//           //           Text( "Item Total",style: TextStyle(fontSize: 20),),
//           //           Spacer(),
//           //           Text("₹200",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
//           //           SizedBox(width: 20,)
//           //         ],
//           //       ),
//           //       Row(
//           //         children: [
//           //           SizedBox(width: 20,),
//           //           Text( "Discount",style: TextStyle(fontSize: 20),),
//           //           Spacer(),
//           //           Text("₹20",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),
//           //           SizedBox(width: 20,)
//           //         ],
//           //       ),
//           //       Row(
//           //         children: [
//           //           SizedBox(width: 20,),
//           //           Text( "Service Fee",style: TextStyle(fontSize: 20,color: Colors.blue),),
//           //           Spacer(),
//           //           Text("Free",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.blue),),
//           //           SizedBox(width: 20,)
//           //         ],
//           //       ),
//           //       Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
//           //       Row(
//           //         children: [
//           //           SizedBox(width: 20,),
//           //           GlobalWidget.WorkNameText(context, "Grand Total"),
//           //           Spacer(),
//           //           Text("₹180",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),),
//           //           SizedBox(width: 20,)
//           //         ],
//           //       ),
//           //       Row(
//           //         children: [
//           //           SizedBox(width: 20,),
//           //           Container(
//           //             height: 60,
//           //             width: 60,
//           //             decoration: BoxDecoration(
//           //               color: Colors.blueGrey.shade200,
//           //               borderRadius: BorderRadius.circular(
//           //                 5,
//           //               ), // Border radius yahan set hota hai
//           //             ),
//           //             child: Icon(Icons.location_on_outlined,size: 25,),
//           //           ),
//           //           Text("Address"),
//           //           Spacer(),
//           //           Text("Change",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.grey.shade500),),
//           //           SizedBox(width: 20,)
//           //         ],
//           //       ),
//           //       Divider(indent: 10,endIndent: 10,height: 30,thickness: 2,),
//           //       Row(
//           //         children: [
//           //           SizedBox(width: 20,),
//           //           Column(children: [
//           //             GlobalWidget.WorkNameText(context, "Price"),
//           //             Text("₹180",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),),
//           //           ],),
//           //           Spacer(),
//           //           Padding(
//           //             padding: const EdgeInsets.all(8.0),
//           //             child: SizedBox(
//           //               width: 160,
//           //               height: 45,
//           //               child: ElevatedButton(
//           //                 style: ElevatedButton.styleFrom(
//           //                   backgroundColor: Colors.blue,
//           //                   shape: RoundedRectangleBorder(
//           //                     borderRadius: BorderRadius.circular(
//           //                       5,
//           //                     ), // Border radius 5
//           //                   ),
//           //                 ),
//           //                 onPressed: () {
//           //                   // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSummaryScreen(),));
//           //                 },
//           //                 child: Text(
//           //                   "Booking Now",
//           //                   style: TextStyle(color: Colors.white, fontSize: 18),
//           //                 ),
//           //               ),
//           //             ),
//           //           ),
//           //           SizedBox(width: 20,)
//           //         ],
//           //       ),
//           //
//           //
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
