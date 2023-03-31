// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.id,
    this.meterId,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.state,
    this.phone,
    this.address,
  });

  int id;
  int meterId;
  String name;
  String email;
  String password;
  dynamic confirmPassword;
  String state;
  String phone;
  String address;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        meterId: json["meterId"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        state: json["state"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meterId": meterId,
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "state": state,
        "phone": phone,
        "address": address,
      };
}
