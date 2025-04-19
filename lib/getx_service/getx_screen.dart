import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/categories_model.dart';
import '../models/partners_model.dart';

class GetService extends GetxController {
  RxList categories = <CategoryModel>[].obs;
  RxList partners = <PartnersModel>[].obs;
  RxList filteredPartners = <PartnersModel>[].obs;
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
            service: data["service"],
          );
        },
      ).toList();

      final partnerSnapshot =
          await FirebaseFirestore.instance.collection('partners').get();
      partners.value = partnerSnapshot.docs.map(
        (doc) {
          final data = doc.data();
          return PartnersModel(
            partner_id: data["partner_id"]?.toString() ?? "",
            price1: data["price1"]?.toString() ?? "",
            price2: data["price2"]?.toString() ?? "",
            service_name: data["service_name"]?.toString() ?? "",
            name: data["name"]?.toString() ?? "",
            imageUrl: data["imageUrl"]?.toString() ?? "",
            workType: data["workType"]?.toString() ?? "",
            workingImageUrl: data["workingImageUrl"]?.toString() ?? "",
          );
        },
      ).toList();

      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first.name;
        filterPartnersByCategory(selectedCategory.value);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void filterPartnersByCategory(String categoryName) {
    selectedCategory.value = categoryName;
    filteredPartners.value =
        partners.where((partner) => partner.workType == categoryName).toList();
  }
}
