// To parse this JSON data, do
//
//     final userDataResponseModel = userDataResponseModelFromJson(jsonString);

import 'dart:convert';

UserDataResponseModel userDataResponseModelFromJson(String str) => UserDataResponseModel.fromJson(json.decode(str));

String userDataResponseModelToJson(UserDataResponseModel data) => json.encode(data.toJson());

class UserDataResponseModel {
  UserDataResponseModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.state,
    this.phone,
    this.address,
  });

  int id;
  String name;
  String email;
  String password;
  String state;
  String phone;
  String address;

  factory UserDataResponseModel.fromJson(Map<String, dynamic> json) => UserDataResponseModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        state: json["state"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "state": state,
        "phone": phone,
        "address": address,
      };
}
