class PartnersModel {
  final String serviceName;
  final String originalPrice;
  final String discountPrice;
  final String? workingImageUrl;
  final String? profileImage;
  final String name;
  final String workType;

  PartnersModel({
    required this.serviceName,
    required this.originalPrice,
    required this.discountPrice,
    this.workingImageUrl,
    this.profileImage,
    required this.name,
    required this.workType,
  });

  factory PartnersModel.fromMap(Map<String, dynamic> data) {
    return PartnersModel(
      serviceName: data['serviceName'] ?? '',
      originalPrice: data['originalPrice'] ?? '0',
      discountPrice: data['discountPrice'] ?? '0',
      workingImageUrl: data['workingImageUrl'] ?? '',
      profileImage: data['profileImage'] ?? '',
      name: data['name'] ?? '',
      workType: data['workType'] ?? '',
    );
  }
}
