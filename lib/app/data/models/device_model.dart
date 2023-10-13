class DeviceModel {
  int? status;
  String? errorNum;
  String? message;
  IoTDevice? ioTDevice;

  DeviceModel({this.status, this.errorNum, this.message, this.ioTDevice});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNum = json['errorNum'];
    message = json['message'];
    ioTDevice = json['IoTDevice'] != null ? IoTDevice.fromJson(json['IoTDevice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errorNum'] = errorNum;
    data['message'] = message;
    if (ioTDevice != null) {
      data['IoTDevice'] = ioTDevice!.toJson();
    }
    return data;
  }
}

class IoTDevice {
  int? id;
  String? name;
  String? token;
  int? startRead;
  String? connectionStatus;
  String? flowStatus;
  List<Readings>? readings;

  IoTDevice({this.id, this.name, this.token, this.startRead, this.connectionStatus, this.flowStatus, this.readings});

  IoTDevice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    token = json['token'];
    startRead = json['start_read'];
    connectionStatus = json['connection_status'];
    flowStatus = json['flow_status'];
    if (json['readings'] != null) {
      readings = <Readings>[];
      json['readings'].forEach((v) {
        readings!.add(Readings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['token'] = token;
    data['start_read'] = startRead;
    data['connection_status'] = connectionStatus;
    data['flow_status'] = flowStatus;
    if (readings != null) {
      data['readings'] = readings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Readings {
  int? id;
  int? deviceId;
  double? litersConsumed;
  double? flowRate;
  String? createdAt;
  String? updatedAt;

  Readings({this.id, this.deviceId, this.litersConsumed, this.flowRate, this.createdAt, this.updatedAt});

  Readings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    litersConsumed = json['liters_consumed'];
    flowRate = json['flow_rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['device_id'] = deviceId;
    data['liters_consumed'] = litersConsumed;
    data['flow_rate'] = flowRate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
