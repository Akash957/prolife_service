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
  void initState() {
    super.initState();
    getController.allCategories(); // Store data one time
    // getController.updateOldDocuments(); // 👈 Use this only if you have old data
  }
  @override
  void dispose() {
    getController.updateSearch('');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
        )
            : null,
      ),
      body: Obx(() {return StreamBuilder<QuerySnapshot>(
        stream: getController.filteredImages,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(child: Text("No matching results"));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];
              return SizedBox(
                child: InkWell(
                  onTap: () {Get.to(ClickOnCategories());},
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              data['url'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['name']),
                              Text(data['service']),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
      }),
    );
  }
}