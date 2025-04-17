import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/categories_model.dart';
import '../models/partner.dart';

class GetService extends GetxController {
  RxList categories = <CategoryModel>[].obs;
  RxList partnerList = <PartnerModel>[].obs;
  RxList filteredProducts = <PartnerModel>[].obs;
  RxList filteredProductsByType = <PartnerModel>[].obs;
  RxString selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final categorySnapshot =
          await FirebaseFirestore.instance.collection('category_item').get();
      categories.value = categorySnapshot.docs.map(
        (doc) {
          final data = doc.data();
          return CategoryModel(
              name: data["name"],
              imageUrl: data["imageUrl"],
              service: data["service"]);
        },
      ).toList();

      final productSnapshot = await FirebaseFirestore.instance.collection('partners').get();
      partnerList.value = productSnapshot.docs.map(
        (doc) {
          final data = doc.data();
          return PartnerModel(
            name: data["name"],
            imageUrl: data["imageUrl"],
            workType: data["workType"],
            workingImageUrl: data["workingImageUrl"],
          );
        },
      ).toList();

      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first.name;
        filterProductsByWorkType(selectedCategory.value);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filterProductsByWorkType(String workType) {
    selectedCategory.value = workType;
    filteredProducts.value = partnerList.where((product) => product.workType == workType).toList();
    filteredProductsByType.clear();
  }
}

