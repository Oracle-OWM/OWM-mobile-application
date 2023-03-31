import 'dart:convert';

List<ConsumModel> consumModelFromJson(String str) => List<ConsumModel>.from(json.decode(str).map((x) => ConsumModel.fromJson(x)));

String consumModelToJson(List<ConsumModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsumModel {
  ConsumModel({
    this.date,
    this.energy,
    this.amount,
  });

  String date;
  double energy;
  double amount;

  factory ConsumModel.fromJson(Map<String, dynamic> json) => ConsumModel(
        date: json["date"],
        energy: json["energy"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "energy": energy,
        "amount": amount,
      };
}
