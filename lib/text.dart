import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/categories_model.dart';
import '../models/partners_model.dart';

class GetService extends GetxController {
  RxList categories = <CategoryModel>[].obs;
  RxList partnerList = <PartnersModel>[].obs;
  RxList filteredProducts = <PartnersModel>[].obs;
  RxList filteredProductsByType = <PartnersModel>[].obs;
  RxString selectedCategory = ''.obs;

  RxList<PartnersModel> cartItems = <PartnersModel>[].obs;

  final _dbRef = FirebaseDatabase.instance.ref();

  @override
  void onInit() {
    super.onInit();
    fetchData();
    loadCart(); // Realtime se cart load karo
  }

  Future<void> fetchData() async {
    try {
      final categorySnapshot = await FirebaseFirestore.instance.collection('category_item').get();
      categories.value = categorySnapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryModel(
            name: data["name"],
            imageUrl: data["imageUrl"],
            service: data["service"]);
      }).toList();

      final productSnapshot = await FirebaseFirestore.instance.collection('partners').get();
      partnerList.value = productSnapshot.docs.map((doc) {
        final data = doc.data();
        return PartnersModel(
          name: "${data["name"]}",
          profileImage: "${data["profileImage"]}",
          workType:"${ data["workType"]}",
          workingImageUrl: "${data["workingImageUrl"]}",
          serviceName: "${data["serviceName"]}",
          originalPrice: "${data["originalPrice"]}",
          discountPrice: '${data["discountPrice"]}',
        );
      }).toList();

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
    filteredProducts.value = partnerList.where((product) => product.workType == workTypes).toList();
    filteredProductsByType.clear();
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      fetchData();
    } else {
      final filtered = categories.where((category) =>
          category.name.toLowerCase().contains(query.toLowerCase())).toList();

      if (filtered.isNotEmpty) {
        selectedCategory.value = filtered.first.name;
        categories.value = filtered;
      } else {
        categories.clear();
      }
    }
  }

  // 🛒 Realtime Database me add to cart
  void addToCart(PartnersModel partner) async {
    if (!cartItems.contains(partner)) {
      cartItems.add(partner);
      final newCartRef = _dbRef.child("cartItems").push(); // Auto ID
      await newCartRef.set({
        "name": partner.name,
        "profileImage": partner.profileImage,
        "workType": partner.workType,
        "workingImageUrl": partner.workingImageUrl,
        "serviceName": partner.serviceName,
        "originalPrice": partner.originalPrice,
        "discountPrice": partner.discountPrice,
      });
    }
  }

  // 🛒 Realtime se cart load karo
  void loadCart() async {
    final snapshot = await _dbRef.child("cartItems").once();
    final data = snapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      final loadedCart = data.values.map((item) {
        return PartnersModel(
          name: item["name"],
          profileImage: item["profileImage"],
          workType: item["workType"],
          workingImageUrl: item["workingImageUrl"],
          serviceName: item["serviceName"],
          originalPrice: item["originalPrice"],
          discountPrice: item["discountPrice"],
        );
      }).toList();
      cartItems.assignAll(loadedCart);
    }
  }
}
