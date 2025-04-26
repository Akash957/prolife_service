//
// class PartnersModel {
//   final String partner_id;
//   final String name;
//   final String profileImage;
//   final String workType;
//   final String workingImageUrl;
//   final String serviceName;
//   final String originalPrice;
//   final String discountPrice;
//
//   PartnersModel( {
//     required this.partner_id,
//     required this.profileImage,
//     required this.serviceName,
//     required this.discountPrice,
//     required this.name,
//     required this.workType,
//     required this.workingImageUrl,
//     required this.originalPrice,
//   });
//
//   factory PartnersModel.fromJson(Map<String, dynamic> json) {
//     return PartnersModel(
//       partner_id: json['partner_id'],
//       name: json['name'],
//       workType: json['workType'],
//       workingImageUrl: json['workingImageUrl'],
//       originalPrice: json['originalPrice'].toDouble(),
//       profileImage: json['profileImage'],
//       serviceName: json['serviceName'],
//       discountPrice: json['discountPrice'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'partner_id': partner_id,
//       'name': name,
//       'workType': workType,
//       'workingImageUrl': workingImageUrl,
//       'originalPrice': originalPrice,
//       'profileImage': profileImage,
//       'serviceName': serviceName,
//       'discountPrice': discountPrice,
//     };
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
