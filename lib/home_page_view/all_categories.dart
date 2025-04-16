import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx_service/getx_screen.dart';
import 'click_on_categories.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final getController = Get.put(GetService());
  bool showSearch = false;


  @override
  Widget build(BuildContext context) {
    final  categoryController = Get.put(GetService());
    var widthScreen = MediaQuery.of(context).size.width * 2;
    var heightScreen = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
        actions: [
          IconButton(
            icon: Icon(showSearch ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                showSearch = !showSearch; // 👈 toggle value
              });
            },
          ),
        ],
        bottom: showSearch
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      // getController.updateSearch(value);
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
              )
            : null,
      ),
      body: Obx(() => ListView.builder(
        itemCount: categoryController.categories.length,
        itemBuilder: (context, index) {
          final category = categoryController.categories[index];
          return ListTile(
            title: InkWell(
              onTap: () {
                Get.to(ClickProduct());
                categoryController.filterProductsByCategory(category.name,);
              },
              child: Card(
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        category.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${category.name}"),
                        Text("${category.service}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
