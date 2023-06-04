class ChangePowerStatusModel {
  int? status;
  String? message;
  String? errorNum;

  ChangePowerStatusModel({this.status, this.message, this.errorNum});

  ChangePowerStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorNum = json['errorNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['errorNum'] = errorNum;
    return data;
  }
}
