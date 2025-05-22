import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prolife_service/home_page_view/service_details.dart';
import 'package:provider/provider.dart';
import '../bottonNavigation/botton_nav.dart';
import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import '../provider/location_provider.dart';
import '../screens/location_screen/location_screen.dart';
import 'add_to_cart.dart';
import 'all_categories.dart';
import 'click_on_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final getController = Get.put(GetService());

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    final locationProvider = Provider.of<LocationProvider>(context);
    final categoryController = Get.put(GetService());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            Get.to(() => LocationScreen());
          },
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.orange),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<LocationProvider>(
                    builder: (context, locationProvider, child) {
                      return locationProvider.currentAddress != null
                          ? Text(
                              locationProvider.currentAddress!,
                              style: const TextStyle(fontSize: 14),
                            )
                          : const Text(
                              "Tap to select location",
                              style: TextStyle(fontSize: 14),
                            );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                categoryController.searchCategories(value);
              },
              decoration: InputDecoration(
                hintText: "Search for Categories...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        actions: [
          const InkWell(
            child: Icon(
              Icons.notifications,
              size: 30,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Get.to(CartScreen());
            },
            child: Icon(Icons.shopping_cart_outlined, size: 30),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                GlobalWidget.WorkNameText(context, "All Categories"),
                Spacer(),
                GlobalWidget.SeeAllCategories(() {
                  Get.to(AllCategories());
                }, context, "See All"),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            SizedBox(
              height: heightScreen * 0.3,
              child: Obx(
                () => GridView.builder(
                  itemCount: categoryController.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  padding: const EdgeInsets.all(8),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final category = categoryController.categories[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.to(() => ClickProduct(
                              categoryName: category.name,
                            ));
                        categoryController
                            .filterProductsByWorkType(category.name);
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  category.imageUrl,
                                  height: 55,
                                  width: 55,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error,
                                          color: Colors.red),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                GlobalWidget.WorkNameText(context, "Best Services"),
                Spacer(),
              ],
            ),
            SizedBox(
              height: heightScreen * 0.37,
              child: Obx(() => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryController.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final partner =
                          categoryController.filteredProducts[index];
                      return Container(
                        width: widthScreen * 0.7,
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalWidget.BestServicesImage1(
                                  context, partner.workingImageUrl),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: 4.5,
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber),
                                    itemCount: 5,
                                    itemSize: 25,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                              GlobalWidget.WorkNameText(
                                  context, partner.serviceName),
                              SizedBox(width: 50),
                              Row(
                                children: [
                                  GlobalWidget.BestServicesCircleAvatar2(
                                      context, partner.profileImage),
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
                                  GlobalWidget.ServicesProvideAddButton(
                                    () {
                                      Get.to(
                                          ServiceDetailsPage(product: partner));
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
            )
          ],
        ),
      ),
    );
  }
}
