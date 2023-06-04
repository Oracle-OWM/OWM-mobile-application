// To parse this JSON data, do
//
//     final userUpdateModel = userUpdateModelFromJson(jsonString);

import 'dart:convert';

UserUpdateModel userUpdateModelFromJson(String str) => UserUpdateModel.fromJson(json.decode(str));

String userUpdateModelToJson(UserUpdateModel data) => json.encode(data.toJson());

class UserUpdateModel {
  UserUpdateModel({
    this.id,
    this.name,
    this.password,
    this.confirmPassword,
  });

  int? id;
  String? name;
  String? password;
  String? confirmPassword;

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) => UserUpdateModel(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "confirmPassword": confirmPassword,
      };
}
