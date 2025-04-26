import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/categories_model.dart';
import '../models/partners_model.dart';

class GetService extends GetxController {
  RxList categories = <CategoryModel>[].obs;
  RxList partnerList = <PartnersModel>[].obs;
  RxList filteredProducts = <PartnersModel>[].obs;
  RxList filteredProductsByType = <PartnersModel>[].obs;
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

      final productSnapshot =
          await FirebaseFirestore.instance.collection('partners').get();
      partnerList.value = productSnapshot.docs.map(
        (doc) {
          final data = doc.data();
          return PartnersModel(
            partner_id: "${data["partner_id"]}",
            name: "${data["name"]}",
            profileImage: "${data["profileImage"]}",
            workType: "${data["workType"]}",
            workingImageUrl: "${data["workingImageUrl"]}",
            serviceName: "${data["serviceName"]}",
            originalPrice: "${data["originalPrice"]}",
            discountPrice: "${data["discountPrice"]}",
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

  void filterProductsByWorkType(String workTypes) {
    selectedCategory.value = workTypes;
    filteredProducts.value =
        partnerList.where((product) => product.workType == workTypes).toList();
    filteredProductsByType.clear();
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      fetchData();
    } else {
      final filtered = categories
          .where((category) =>
              category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (filtered.isNotEmpty) {
        selectedCategory.value = filtered.first.name;
        categories.value = filtered;
      } else {
        categories.clear();
      }
    }
  }
}
