class AllDevicesModel {
  String? status;
  String? message;
  List<IoTDevices>? ioTDevices;

  AllDevicesModel({this.status, this.message, this.ioTDevices});

  AllDevicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['IoTDevices'] != null) {
      ioTDevices = <IoTDevices>[];
      json['IoTDevices'].forEach((v) {
        ioTDevices!.add(IoTDevices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (ioTDevices != null) {
      data['IoTDevices'] = ioTDevices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IoTDevices {
  String? id;
  String? name;
  String? token;
  String? startRead;
  String? connectionStatus;
  String? flowStatus;
  List<Readings>? readings;

  IoTDevices({this.id, this.name, this.token, this.startRead, this.connectionStatus, this.flowStatus, this.readings});

  IoTDevices.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? deviceId;
  dynamic litersConsumed;
  dynamic flowRate;
  String? createdAt;

  Readings({this.id, this.deviceId, this.litersConsumed, this.flowRate, this.createdAt});

  Readings.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    deviceId = json['device_id'];
    litersConsumed = json['liters_consumed'];
    flowRate = json['flow_rate'];
    createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['device_id'] = deviceId;
    data['liters_consumed'] = litersConsumed;
    data['flow_rate'] = flowRate;
    data['created_at'] = createdAt;
    return data;
  }
}
