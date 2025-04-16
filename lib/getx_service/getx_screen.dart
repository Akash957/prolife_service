import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/categories_model.dart';
import '../models/product_model.dart';

class GetService extends GetxController {
  RxList categories = <CategoryModel>[].obs;
  RxList products = <ProductModel>[].obs;
  RxList filteredProducts = <ProductModel>[].obs;
  RxList filteredProductsByType = <ProductModel>[].obs;
  RxString selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final categorySnapshot = await FirebaseFirestore.instance.collection('category_item').get();
      categories.value = categorySnapshot.docs.map(
        (doc) {
          final data = doc.data();
          return CategoryModel(
              name: data["name"],
              imageUrl: data["imageUrl"],
              service: data["service"]);
        },).toList();

      final productSnapshort =
          await FirebaseFirestore.instance.collection('product_item').get();
          products.value = productSnapshort.docs.map((doc) {
          final data = doc.data();
          return ProductModel(
              name: data["name"],
              imageUrl: data["imageUrl"],
              price: data["price"],
              price2: data["price2"],
              categories: data["categories"],
              service: data["service"],
          );
        },).toList();

      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first.name;
        filterProductsByCategory(selectedCategory.value);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filterProductsByCategory(String categoryName) {
    selectedCategory.value = categoryName;

    filteredProducts.value =
        products.where((product) => product.categories == categoryName)
        .toList();
    filteredProductsByType.clear();
  }

}
