import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import 'service_details.dart';

class ClickProduct extends StatelessWidget {
  final categoryController = Get.put(GetService());

  ClickProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Click on Categories')),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() => ListView.builder(
        itemCount: categoryController.filteredProducts.length,
        itemBuilder: (context, index) {
          final partner = categoryController.filteredProducts[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalWidget.ReferImage(context, partner.workingImageUrl),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: RatingBar.builder(
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                GlobalWidget.WorkNameText(context, partner.serviceName),
                GlobalWidget.TextSpanTextOriginal(
                    context, partner.originalPrice, partner.discountPrice),
                Row(
                  children: [
                    GlobalWidget.BestServicesCircleAvatar(
                        context, partner.profileImage),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalWidget.workername(context, partner.name),
                        GlobalWidget.serviceType(context, partner.workType),
                      ],
                    ),
                    const Spacer(),
                    GlobalWidget.ServicesProvideAddButton(() {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Border radius 5
                          ),
                          context: context,
                          builder: (context) {
                            return Container(
                              height:heightScreen*0.1,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 55,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          categoryController.addToCart(partner,context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('AddToCart Success',style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
                                          );
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5), // Border radius 5
                                            ),
                                            backgroundColor: Colors.yellow),
                                        child: const Text('Add to Cart',style: TextStyle(fontSize: 20,color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      height: 55,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(ServiceDetailsPage(product: partner));
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5), // Border radius 5
                                        ),),
                                        child: Text("Book Now",style: TextStyle(fontSize: 20,color: Colors.white),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }, context, "Book"),
                  ],
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
