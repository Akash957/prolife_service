import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prolife_service/screens/profile_screen.dart';
import '../globle_widget/globle_screen.dart';
 import 'package:get/get.dart';
import 'package:prolife_service/globle_widget/globle_screen.dart';

import '../getx_service/getx_screen.dart';
import 'all_categories.dart';
import 'click_on_categories.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final getController = Get.put(GetService());

  @override
  void initState() {
    super.initState();
    getController.allCategories(); // Store data one time
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
             child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 40,
                ),
                const Text(
                  "Service Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
                    },
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      size: 40,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blue.shade100),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
    GlobalWidget.WorkNameText(context, "All Category"),
                    Spacer(),
                    GlobalWidget.SeeAllCategories(() {}, context, "See All"),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GlobleWidget.AllCategory(
                          context,
                          "Carpenter",
                          "assets/image/carpernter_bc.png",
                          () {},
                        ),
                        GlobleWidget.AllCategory(
                          context,
                          "Cleaner",
                          "assets/image/cliner.png",
                          () {},
                        ),
                        GlobleWidget.AllCategory(
                          context,
                          "Painter",
                          "assets/image/painter_bc.png",
                          () {},
                        ),
                        GlobleWidget.AllCategory(
                          context,
                          "Electrician",
                          "assets/image/electric_bc.png",
                          () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GlobleWidget.AllCategory(
                          context,
                          "Ac Repair",
                          "assets/image/ac_repairing_bc.png",
                          () {},
                        ),
                        GlobleWidget.AllCategory(
                          context,
                          "Plumber",
                          "assets/image/plumber.png",
                          () {},
                        ),
                        GlobleWidget.AllCategory(
                          context,
                          "Men's Salon",
                          "assets/image/salon.jpeg",
                          () {},
                        ),
                        GlobleWidget.AllCategory(
                          context,
                          "Beauty",
                          "assets/image/beauty_bc.png",
                          () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 20),
                  child: Row(
                    children: [
                      GlobleWidget.WorkNameText(context, "Best Service"),
                      Spacer(),
                      GlobleWidget.SeeAllCategories(() {}, context, "See All")
                    ],
                  ),
                ),
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
                              GlobleWidget.BestServicesImage1(
                                context,
                                "assets/image/kitchen.jpeg",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: RatingBar.builder(
                                  // minRating: 0,
                                  // direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.blue,
             child: TextField(
              onChanged: (value) {
                getController.updateSearch(value);
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
              SizedBox(width: 20,)
            ],
          ),
          SizedBox(
            height: 250,
            child: Expanded(
              child: Obx(() {
                return StreamBuilder<QuerySnapshot>(
                  stream: getController.filteredImages,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return Center(child: Text("No matching results"));
                    }
                    return GridView.builder(
                      itemCount: docs.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        childAspectRatio: 0.8,
                      ),
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        var data = docs[index];
                        return InkWell(
                          onTap: () {
                            Get.to(ClickOnCategories());
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(data['url']),
                                   ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 2,
                                    right: 2,
                                  ),
                                   GlobleWidget.ServicesProvideAddButton(
                                      () {}, context, "Add")
                                ],
                              )
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
                              GlobleWidget.BestServicesImage1(
                                context,
                                "assets/image/kitchen.jpeg",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: RatingBar.builder(
                                  // minRating: 0,
                                  // direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                   child: Text(
                                    data['name'],
                                    style: TextStyle(fontSize: 10),
                                   ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ),
          Row(
            children: [
              GlobalWidget.WorkNameText(context, "Best Services"),
              Spacer(),
              GlobalWidget.SeeAllCategories(() {
              }, context, "See All"),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
