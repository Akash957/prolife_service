class UserModel {
  final String id;
  final String userName;
  final String email;
  final String? imageUrl;
  final String? phone;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    this.imageUrl,
    this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }
}
