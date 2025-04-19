import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:prolife_service/home_page_view/service_details.dart';
import 'package:provider/provider.dart';
import '../getx_service/getx_screen.dart';
import '../global_widget/globle_screen.dart';
import '../provider/location_provider.dart';
import '../screens/location_screen/location_screen.dart';
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
    var widthScreen = MediaQuery.of(context).size.width * 0.7;
    final locationProvider = Provider.of<LocationProvider>(context);
    final categoryController = Get.put(GetService());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () => Get.to(() => const LocationScreen()),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.orange),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (locationProvider.currentAddress != null)
                    Text(
                      locationProvider.currentAddress!,
                      style: const TextStyle(fontSize: 14),
                    )
                  else
                    const Text(
                      overflow: TextOverflow.ellipsis,
                      "Tap to select location",
                      style: TextStyle(fontSize: 14),
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
                hintText: "Search image...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        actions: [
          InkWell(child: Icon(Icons.notifications,size: 30,),),
          SizedBox(width: 15,),
          InkWell(child: Icon(Icons.shopping_cart_outlined,size: 30),),
          SizedBox(width: 15,)
        ],

      ),
      body: Column(
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
            height: 260,
            child: Expanded(
              child: Obx(
                () => SizedBox(
                  height: 350,
                  child: GridView.builder(
                    itemCount: categoryController.categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.8,
                    ),
                    padding: const EdgeInsets.all(5),
                    itemBuilder: (context, index) {
                      final category = categoryController.categories[index];
                      return InkWell(
                        onTap: () {
                          Get.to(ClickProduct());
                          categoryController.filterProductsByWorkType(
                            category.name,
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(category.imageUrl),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2, right: 2),
                                child: Text(
                                  category.name,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              GlobalWidget.WorkNameText(context, "Best Services"),
              Spacer(),
              GlobalWidget.SeeAllCategories(() {}, context, "See All"),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 230,
            child: Expanded(
              child: Obx(() => ListView.builder(
                itemCount: categoryController.filteredProducts.length,
                itemBuilder: (context, index) {
                  final partner = categoryController.filteredProducts[index];
                  return ListTile(
                    title:
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalWidget.BestServiceImage(
                              context, partner.imageUrl),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: RatingBar.builder(
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
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
                              context, partner.name),
                          Row(
                            children: [
                              GlobalWidget.BestServicesProfile(
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
                              GlobalWidget.ServicesProvideAddButton(
                                    () {
                                  Get.to(ServiceDetailsPage(product: partner,));
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
          )
        ],
      ),
    );
  }
}
