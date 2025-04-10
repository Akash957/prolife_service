import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
