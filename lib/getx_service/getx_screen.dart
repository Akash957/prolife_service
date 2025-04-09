
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetService extends GetxController {
  RxString searchText = ''.obs;
  allCategories() async {
    var collection = FirebaseFirestore.instance.collection('all_categories');
    List<Map<String, String>> imageList = [
      {
        'name': 'Carpenter',
        'url': 'https://img.freepik.com/premium-vector/electric-drill-machine-realistic-vector-illustration_1253202-31287.jpg',
        'service':"20 Service"
      },
      {
        'name': 'Cleaner',
        'url': 'https://images.squarespace-cdn.com/content/v1/6765a96d0c92193b949e230c/0b643606-2088-41b6-a761-aea54679da7c/Image+Templates+(15).png?format=500w',
        'service':"20 Service"
      },
      {
        'name': 'Painter',
        'url': 'https://cdn-icons-png.flaticon.com/512/1024/1024257.png',
        'service':"20 Service"
      },
      {
        'name': 'Ac Repair',
        'url':
        'https://5.imimg.com/data5/SELLER/Default/2023/4/298004435/MC/XG/KM/12959184/dura-edge-plus-split-ac-500x500.jpg',
        'service':"20 Service"
      },
      {
        'name': 'Plumber',
        'url':
        'https://4.imimg.com/data4/IA/PL/MY-3006526/plumer-electrician-500x500.jpg',
        'service':"20 Service"
      },
      {
        'name': "Men's Salon",
        'url':
        'https://media.istockphoto.com/id/1220134013/vector/s-h.jpg?s=612x612&w=0&k=20&c=FkvOnhQmfTV-4JJxkVUpYIaswj3iplKQ3J1lGM5vsTA=',
        'service':"20 Service"
      },
      {
        'name': "Washing Machine",
        'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxzueQOs1JLFz405w-CwGbsadG-lwgvpFSUplE-mW8t0-VoG-ur89g5Pc3mSMJDOD8HKE&usqp=CAU',
        'service':"20 Service"
      },
      {
        'name': "Electrician",
        'url': 'https://st4.depositphotos.com/1077687/26205/v/450/depositphotos_262057754-stock-illustration-construction-tools-isolated-icon.jpg',
        'service':"20 Service"
      },
    ];
    for (var image in imageList) {
      var snapshot =
      await collection.where('name', isEqualTo: image['name']).get();

      if (snapshot.docs.isEmpty) {
        await collection.add({
          'name': image['name']!,
          'url': image['url']!,
          'service': image['service']!,
          'name_lowercase': image['name']!.toLowerCase(),
        });
        print('Added: ${image['name']}');
      } else {
        print('Already exists: ${image['name']}');
      }
    }
  }

  void updateSearch(String value) {
    searchText.value = value.toLowerCase();
  }
  Stream<QuerySnapshot> get filteredImages {
    if (searchText.value.isEmpty) {
      return FirebaseFirestore.instance.collection('all_categories').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('all_categories')
          .where('name_lowercase', isGreaterThanOrEqualTo: searchText.value)
          .where('name_lowercase', isLessThanOrEqualTo: '${searchText.value}\uf8ff')
          .snapshots();
    }
  }


}
