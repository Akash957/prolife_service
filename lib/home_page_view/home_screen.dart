import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  void initState() {
    super.initState();
    getController.allCategories();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

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
                      "Tap to select location",
                      style: TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              GlobalWidget.WorkNameText(context, "All Categories"),
              const Spacer(),
              GlobalWidget.SeeAllCategories(
                () => Get.to(() => const AllCategories()),
                context,
                "See All",
              ),
              const SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 250,
            child: Obx(() {
              return StreamBuilder<QuerySnapshot>(
                stream: getController.filteredImages,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  if (docs.isEmpty) {
                    return const Center(child: Text("No matching results"));
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
                        onTap: () => Get.to(() => const ClickOnCategories()),
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
                                  child: Image.network(
                                    data['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  data['name'],
                                  style: const TextStyle(fontSize: 10),
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
          Row(
            children: [
              GlobalWidget.WorkNameText(context, "Best Services"),
              const Spacer(),
              GlobalWidget.SeeAllCategories(() {}, context, "See All"),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
