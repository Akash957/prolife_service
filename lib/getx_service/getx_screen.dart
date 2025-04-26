
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
    loadCartFirebase();

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
            partnerId: "${data["partner_id"]}",
            name: "${data["name"]}",
            profileImage: "${data["profileImage"]}",
            workType:"${ data["workType"]}",
            workingImageUrl: "${data["workingImageUrl"]}",
            serviceName: "${data["serviceName"]}",
            originalPrice: "${data["originalPrice"]}",
            discountPrice: '${data["discountPrice"]}',
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
    filteredProducts.value = partnerList.where((product) => product.workType == workTypes).toList();
    filteredProductsByType.clear();
  }
  void searchCategories(String query) {
    if (query.isEmpty) {
      // Agar empty search hai toh sab categories dikhao
      fetchData();
    } else {
      // Filter karo categories based on name
      final filtered = categories.where((category) =>
          category.name.toLowerCase().contains(query.toLowerCase())).toList();

      // SelectedCategory ko first match bana do agar available ho
      if (filtered.isNotEmpty) {
        selectedCategory.value = filtered.first.name;
        categories.value = filtered;
      } else {
        categories.clear();
      }
    }
  }

  // var cartItems = <PartnersModel>[].obs; // observable list
  //
  // // Add item to cart
  //
  //
  // Future<void> addToCart(PartnersModel partner) async {
  //   try {
  //     final userCartRef = _cartRef.child(userId).child('items');
  //     final newItemRef = userCartRef.push();
  //     await newItemRef.set(partner.toMap());
  //
  //     cartItems.add(PartnersModel(
  //       partnerId:newItemRef.key ?? '',
  //       name: partner.name,
  //       profileImage: partner.profileImage,
  //       serviceName: partner.serviceName,
  //       discountPrice: partner.discountPrice,
  //       workType: partner.workType,
  //       workingImageUrl: partner.workingImageUrl,
  //       originalPrice: partner.originalPrice,
  //     ));
  //     print('Item added to cart!');
  //   } catch (e) {
  //     print('Error adding to cart: $e');
  //   }
  // }
  // // Remove item from cart by index
  //
  // Future<void> removeFromCart(int index) async {
  //   try {
  //     if (index >= 0 && index < cartItems.length) {
  //       final itemId = cartItems[index].partnerId;
  //       await _cartRef.child(userId).child('items').child(itemId).remove();
  //
  //       cartItems.removeAt(index);
  //
  //       print('Item removed from cart!');
  //     }
  //   } catch (e) {
  //     print('Error removing from cart: $e');
  //   }
  // }
  // // Clear the entire cart
  //
  // final String userId = '123'; // Example userId
  // final DatabaseReference _cartRef = FirebaseDatabase.instance.ref('carts');
  // Future<void> clearCart() async {
  //   try {
  //     await _cartRef.child(userId).child('items').remove();
  //     cartItems.clear();
  //
  //     print('Cart cleared!');
  //   } catch (e) {
  //     print('Error clearing cart: $e');
  //   }
  // }
  //
  // // Load cart in real-time
  // void loadCartRealtime() {
  //   _cartRef.child(userId).child('items').onValue.listen((event) {
  //     final data = event.snapshot.value as Map<dynamic, dynamic>?;
  //     if (data != null) {
  //       final List<PartnersModel> temp = [];
  //       data.forEach((key, value) {
  //         final partner = PartnersModel.fromMap(Map<String, dynamic>.from(value));
  //         temp.add(PartnersModel(
  //           partnerId: partner.partnerId,
  //           name: partner.name,
  //           profileImage: partner.profileImage,
  //           serviceName: partner.serviceName,
  //           discountPrice: partner.discountPrice,
  //           workType: partner.workType,
  //           workingImageUrl: partner.workingImageUrl,
  //           originalPrice: partner.originalPrice,
  //
  //         ));
  //       });
  //       cartItems.value = temp;
  //     } else {
  //       cartItems.clear();
  //     }
  //     print('Cart updated from Firebase Realtime Database!');
  //   }, onError: (error) {
  //     print('Error loading cart in real-time: $error');
  //   });
  //
  //   print('Listening for real-time cart updates...');
  // }
  var cartItems = <PartnersModel>[].obs;

  final String userId = '1'; // Example userId
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addToCart(PartnersModel partner,BuildContext context) async {
    try {
      final userCartRef = _firestore.collection('carts').doc(userId).collection('items');
      final newItemRef = await userCartRef.add(partner.toMap());
      cartItems.add(PartnersModel(
        partnerId: newItemRef.id,
        name: partner.name,
        profileImage: partner.profileImage,
        serviceName: partner.serviceName,
        discountPrice: partner.discountPrice,
        workType: partner.workType,
        workingImageUrl: partner.workingImageUrl,
        originalPrice: partner.originalPrice,
      ));


      print('Item added to cart in Firestore!');
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(int index) async {
    try {
      if (index >= 0 && index < cartItems.length) {
        final itemId = cartItems[index].partnerId;
        await _firestore.collection('carts').doc(userId).collection('items').doc(itemId).delete();
        cartItems.removeAt(index);
        print('Item removed from cart in Firestore!');
      }
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      final cartCollection = _firestore.collection('carts').doc(userId).collection('items');
      final cartSnapshot = await cartCollection.get();

      for (var doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }

      cartItems.clear();

      print('Cart cleared in Firestore!');
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  void loadCartFirebase() {
    _firestore.collection('carts').doc(userId).collection('items').snapshots().listen((snapshot) {
      final List<PartnersModel> temp = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final partner = PartnersModel.fromMap(data);
        temp.add(PartnersModel(
          partnerId: doc.id,
          name: partner.name,
          profileImage: partner.profileImage,
          serviceName: partner.serviceName,
          discountPrice: partner.discountPrice,
          workType: partner.workType,
          workingImageUrl: partner.workingImageUrl,
          originalPrice: partner.originalPrice,
        ));
      }
      cartItems.value = temp;

      print('Cart updated from Firestore!');
    }, onError: (error) {
      print('Error loading cart in real-time: $error');
    });

    print('Listening for real-time cart updates from Firestore...');
  }


}


