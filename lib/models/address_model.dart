import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  String? addressId;
  String? name;
  String? phoneNumber;
  String? alternateNumber;
  String? pincode;
  String? city;
  String? state;
  String? buildingName;
  String? areaName;
  String? addressType;

  AddressModel({
    this.addressId,
    this.name,
    this.phoneNumber,
    this.alternateNumber,
    this.pincode,
    this.city,
    this.state,
    this.buildingName,
    this.areaName,
    this.addressType
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    addressId: json["addressId"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    alternateNumber: json["AlternateNumber"],
    pincode: json["pincode"],
    city: json["city"],
    state: json["state"],
    buildingName: json["buildingName"],
    areaName: json["areaName"],
    addressType: json['addressType']
  );

  Map<String, dynamic> toJson() => {
    "addressId": addressId,
    "name": name,
    "phoneNumber": phoneNumber,
    "AlternateNumber": alternateNumber,
    "pincode": pincode,
    "city": city,
    "state": state,
    "buildingName": buildingName,
    "areaName": areaName,
    "addressType":addressType
  };
}
