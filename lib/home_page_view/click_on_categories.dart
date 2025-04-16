import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prolife_service/home_page_view/service_details.dart';
import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';

class ClickProduct extends StatelessWidget {
  ClickProduct({super.key});

  final categoryController = Get.put(GetService());

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Click on Categories')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: categoryController.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = categoryController.filteredProducts[index];
                    return SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GlobalWidget.ReferImage(
                                        context, product.imageUrl),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: RatingBar.builder(
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(
                                              'User selected rating: $rating');
                                        },
                                      ),
                                    ),
                                    GlobalWidget.WorkNameText(
                                        context, product.name),
                                    GlobalWidget.TextSpanTextOriginal(context, product.price, product.price2),
                                    Row(
                                      children: [
                                        GlobalWidget.BestServicesCircleAvatar(context, "http://static.vecteezy.com/system/resources/thumbnails/036/442/721/small_2x/ai-generated-portrait-of-a-young-man-no-facial-expression-facing-the-camera-isolated-white-background-ai-generative-photo.jpg"),
                                        Column(
                                          children: [
                                            GlobalWidget.workername(context, "worker name"),
                                            GlobalWidget.serviceType(context, "serviceType"),
                                          ],
                                        ),

                                        Spacer(),
                                        GlobalWidget.ServicesProvideAddButton(
                                                () {
                                              Get.to(ServiceDetailsPage(product: product,));
                                            }, context, "Add")
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
                  },
                )),
          ),
        ],
      ),
    );
  }
}
