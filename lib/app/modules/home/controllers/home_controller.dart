import 'dart:convert';

import 'package:get/get.dart';
import 'package:osm_v2/app/data/models/all_devices_model.dart';
import 'package:osm_v2/app/data/models/device_model.dart';
import 'package:osm_v2/app/data/services/dio_helper.dart';
import 'package:osm_v2/app/data/services/end_points.dart';
import 'package:osm_v2/app/data/services/theme.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../data/models/change_power_status_model.dart';
import '../../../data/services/app_services.dart';
import '../../../data/services/translation_service.dart';

class HomeController extends GetxController {
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  final double coverHeight = 280;
  final double profileHeight = 144;
  DeviceModel? deviceModel;
  AllDevicesModel? allDevicesModel;
  RxBool loading = false.obs;
  RxBool dataReturned = false.obs;

  final wsUrl = Uri.parse('ws://192.168.1.17:6001/app/livepost_key?protocol=7&client=js&version=7.5.0&flash=false');
  String deviceChannel = '{"event":"pusher:subscribe", "data":{"auth":"","channel":"dashboard-IoTDevice-details-channel"}}';
  WebSocketChannel? channel;
  @override
  void onInit() {
    // openSocket();
    getAllDevices();
    // readNewMessage();
    super.onInit();
  }

  void postDevice(String deviceID) {
    DioHelper.postData(url: EndPoints.postAssociateUser, data: {
      'token': deviceID,
    }).then((value) {
      deviceModel = DeviceModel.fromJson(value.data);
      if (deviceModel!.status == 200) {
        getAllDevices();
        Get.back();
        UiTheme.successGetBar(deviceModel!.message!);
      } else {
        UiTheme.errorGetBar('Error associating Device');
      }
    }).catchError((onError) {});
  }

  Future<void> getAllDevices() async {
    loading.value = true;
    dataReturned.value = false;
    await DioHelper.getData(
      url: EndPoints.getAssociateUser,
      token: appServices.loginData!.user!.tokenData!.accessToken,
    ).then((value) {
      allDevicesModel = AllDevicesModel.fromJson(value.data);
      if (allDevicesModel!.status == 200) {
        for (int i = 0; i < allDevicesModel!.ioTDevices!.length; i++) {
          appServices.startRead[allDevicesModel!.ioTDevices![i].name!] = allDevicesModel!.ioTDevices![i].startRead;
          appServices.flowStatus[allDevicesModel!.ioTDevices![i].name!] = allDevicesModel!.ioTDevices![i].flowStatus;
        }
        UiTheme.successGetBar(allDevicesModel!.message!);
        dataReturned.value = true;
      } else {
        UiTheme.errorGetBar(allDevicesModel!.message!);
      }
    }).catchError((error) {});
    loading.value = false;
  }

  openSocket() async {
    channel = WebSocketChannel.connect(wsUrl);
    channel!.sink.add(deviceChannel);
  }

  readNewMessage() {
    channel!.stream.listen(
      (message) {
        Map s = jsonDecode(message);
        if (s.containsKey('data')) {
          Map x = jsonDecode(s['data']);
          if (x['message'] != null) {
            List reversedReading = List.from(x['message']['readings'].reversed);

            if (x['title'] == 'dashboard_ToTDevice_readings') {
              appServices.litersSeries.add(reversedReading[0]['liters_consumed']);
              appServices.litersDays.add(reversedReading[0]['created_at']);
              appServices.flowSeries.add(reversedReading[0]['flow_rate']);
              appServices.flowDays.add(reversedReading[0]['created_at']);
            }

            if (x['title'] == 'dashboard_ToTDevice_power_status') {
              appServices.startRead[x['message']['name']] = x['message']['start_read'];
            }

            if (x['title'] == 'dashboard_ToTDevice_flow_status') {
              appServices.flowStatus[x['message']['name']] = x['message']['flow_status'];
            }
            // appServices.flowStatus[x['message']['name']] = x['message']['flow_status'];

            // print(message);
          }
        }
      },
    );
  }

  ChangePowerStatusModel? changePowerStatusModel;
  void changePowerStatus(int index, String deviceID, int state) {
    DioHelper.postData(
      url: EndPoints.changePowerStatus,
      token: appServices.accessToken.value,
      data: {
        'token': deviceID,
        'start_read': state,
        '_method': 'PUT',
      },
    ).then((value) {
      changePowerStatusModel = ChangePowerStatusModel.fromJson(value.data);
      if (changePowerStatusModel!.status == 200) {
        appServices.startRead[allDevicesModel!.ioTDevices![index].name!] = state;
        UiTheme.successGetBar(changePowerStatusModel!.message!);
      } else {
        UiTheme.errorGetBar('Error changing the state of the device');
      }
    }).catchError((onError) {});
  }
}
