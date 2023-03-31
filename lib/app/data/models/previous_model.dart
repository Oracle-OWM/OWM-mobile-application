// To parse this JSON data, do
//
//     final previousModel = previousModelFromJson(jsonString);

import 'dart:convert';

List<PreviousModel> previousModelFromJson(String str) => List<PreviousModel>.from(json.decode(str).map((x) => PreviousModel.fromJson(x)));

String previousModelToJson(List<PreviousModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreviousModel {
  PreviousModel({
    this.paymentDate,
    this.resetNo,
    this.amount,
  });

  DateTime paymentDate;
  int resetNo;
  double amount;

  factory PreviousModel.fromJson(Map<String, dynamic> json) => PreviousModel(
        paymentDate: DateTime.parse(json["paymentDate"]),
        resetNo: json["resetNo"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "paymentDate": "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "resetNo": resetNo,
        "amount": amount,
      };
}
