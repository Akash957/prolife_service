// class PartnersModel {
//   final String partner_id;
//   final String serviceName;
//   final String originalPrice;
//   final String discountPrice;
//   final String? workingImageUrl;
//   final String? profileImage;
//   final String name;
//   final String workType;
//
//   PartnersModel({
//     required this.partner_id,
//     required this.serviceName,
//     required this.originalPrice,
//     required this.discountPrice,
//     this.workingImageUrl,
//     this.profileImage,
//     required this.name,
//     required this.workType,
//   });
//
//   factory PartnersModel.fromMap(Map<String, dynamic> data) {
//     return PartnersModel(
//       partner_id: data['partner_id'] ?? "",
//       serviceName: data['serviceName'] ?? '',
//       originalPrice: data['originalPrice'] ?? '0',
//       discountPrice: data['discountPrice'] ?? '0',
//       workingImageUrl: data['workingImageUrl'] ?? '',
//       profileImage: data['profileImage'] ?? '',
//       name: data['name'] ?? '',
//       workType: data['workType'] ?? '',
//     );
//   }
// }
class PartnersModel {
  final String partnerId;
  final String name;
  final String profileImage;
  final String workType;
  final String workingImageUrl;
  final String serviceName;
  final String originalPrice;
  final String discountPrice;

  PartnersModel({
    required this.partnerId,
    required this.name,
    required this.profileImage,
    required this.workType,
    required this.workingImageUrl,
    required this.serviceName,
    required this.originalPrice,
    required this.discountPrice,
  });

  // Map se object banane ke liye (from Firebase ya JSON)
  factory PartnersModel.fromMap(Map<String, dynamic> map) {
    return PartnersModel(
      partnerId: map['partner_id'] ?? '',
      name: map['name'] ?? '',
      profileImage: map['profileImage'] ?? '',
      workType: map['workType'] ?? '',
      workingImageUrl: map['workingImageUrl'] ?? '',
      serviceName: map['serviceName'] ?? '',
      originalPrice: map['originalPrice']?.toString() ?? '0',
      discountPrice: map['discountPrice']?.toString() ?? '0',
    );
  }

  // Object ko Map me convert karne ke liye (Firebase ya API me save karne ke liye)
  Map<String, dynamic> toMap() {
    return {
      'partner_id': partnerId,
      'name': name,
      'profileImage': profileImage,
      'workType': workType,
      'workingImageUrl': workingImageUrl,
      'serviceName': serviceName,
      'originalPrice': originalPrice,
      'discountPrice': discountPrice,
    };
  }
}