class UserModel {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;
  final String? phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }
}
