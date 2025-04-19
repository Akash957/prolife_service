import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prolife_service/home_page_view/service_details.dart';

import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';

class ClickProduct extends StatelessWidget {
  final categoryController = Get.put(GetService());

  ClickProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Click on Categories')),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: categoryController.filteredPartners.length,
                  itemBuilder: (context, index) {
                    final partner = categoryController.filteredPartners[index];
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalWidget.ReferImage(context, partner.imageUrl),
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
                                onRatingUpdate: (rating) {
                                  print('Rating: $rating');
                                },
                              ),
                            ),
                            GlobalWidget.WorkNameText(
                                context, partner.service_name),
                            Row(
                              children: [
                                GlobalWidget.BestServicesCircleAvatar(
                                    context, partner.workingImageUrl),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlobalWidget.workername(
                                        context, partner.name),
                                    GlobalWidget.serviceType(
                                        context, partner.workType),
                                  ],
                                ),
                                const Spacer(),
                                GlobalWidget.ServicesProvideAddButton(
                                  () {
                                    Get.to(ServiceDetailsPage());
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
                )),
          ),
        ],
      ),
    );
  }
}
