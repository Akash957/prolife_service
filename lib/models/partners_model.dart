class PartnersModel {
  final String partnerId;
  final String partnerName;
  final String profileImage;
  final String workType;
  final String workingImageUrl;
  final String serviceName;
  final String originalPrice;
  final String discountPrice;

  PartnersModel({
    required this.partnerId,
    required this.partnerName,
    required this.profileImage,
    required this.workType,
    required this.workingImageUrl,
    required this.serviceName,
    required this.originalPrice,
    required this.discountPrice,
  });

  factory PartnersModel.fromMap(Map<String, dynamic> map) {
    return PartnersModel(
      partnerId: map['partner_id'] ?? '',
      partnerName: map['partnerName'] ?? '',
      profileImage: map['profileImage'] ?? '',
      workType: map['workType'] ?? '',
      workingImageUrl: map['workingImageUrl'] ?? '',
      serviceName: map['serviceName'] ?? '',
      originalPrice: map['originalPrice']?.toString() ?? '0',
      discountPrice: map['discountPrice']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'partner_id': partnerId,
      'partnerName': partnerName,
      'profileImage': profileImage,
      'workType': workType,
      'workingImageUrl': workingImageUrl,
      'serviceName': serviceName,
      'originalPrice': originalPrice,
      'discountPrice': discountPrice,
    };
  }
}
