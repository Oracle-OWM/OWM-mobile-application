import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/data/models/all_devices_model.dart';
import 'package:osm_v2/app/data/models/change_power_status_model.dart';
import 'package:osm_v2/app/data/models/device_model.dart';
import 'package:osm_v2/app/data/services/dio_helper.dart';
import 'package:osm_v2/app/data/services/end_points.dart';
import 'package:osm_v2/app/data/services/theme.dart';
import 'package:osm_v2/app/modules/home/widgets/card.dart';

import '../../../data/services/app_services.dart';

class HomeController extends GetxController {
  final appServices = Get.find<AppServices>();
  // final mqttService = Get.find<MQTTService>();
  final double coverHeight = 280;
  final double profileHeight = 144;
  DeviceModel? deviceModel;
  ChangePowerStatusModel? changePowerStatusModel;
  AllDevicesModel? allDevicesModel;
  RxBool loading = false.obs;
  RxBool dataReturned = false.obs;
  List<PageCard> cards = [];

  // final wsUrl = Uri.parse('ws://192.168.1.17:6001/app/livepost_key?protocol=7&client=js&version=7.5.0&flash=false');
  // String deviceChannel = '{"event":"pusher:subscribe", "data":{"auth":"","channel":"dashboard-IoTDevice-details-channel"}}';
  // WebSocketChannel? channel;

  @override
  void onInit() {
    // todo add mqtt calls for subscribed topics with the backend
    // mqttService.mqttSubscribeAndListen(MqttChannels.flowStatusMQTTChannel);
    // mqttService.mqttSubscribeAndListen(MqttChannels.readingsMQTTChannel);
    // mqttService.mqttSubscribeAndListen(MqttChannels.valveStatusMQTTChannel);

    getAllDevices();
    super.onInit();
  }

  void postDevice(String deviceID) {
    Get.log('entered device id');
    try {
      DioHelper.postData(
        url: EndPoints.postAssociateUser,
        data: {
          'meterId': deviceID,
          // 'user_id': appServices.loginData!.user!.id,
        },
        token: appServices.loginData!.user!.tokenData!.accessToken,
      ).then((value) {
        deviceModel = DeviceModel.fromJson(value.data);
        if (value.statusCode == 200) {
          getAllDevices();
          // Get.back();
          UiTheme.successGetBar(deviceModel!.message!);
        } else {
          UiTheme.errorGetBar(deviceModel!.message!);
        }
      });
    } catch (error) {
      UiTheme.errorGetBar(error.toString());
    }
  }

  Future<void> getAllDevices() async {
    loading.value = true;
    dataReturned.value = false;
    try {
      await DioHelper.getData(
        // url: '${EndPoints.getAssociateUser}/${appServices.loginData!.user!.id!}',
        url: EndPoints.getAllDevices,
        token: appServices.loginData!.user!.tokenData!.accessToken,
      ).then((value) {
        allDevicesModel = AllDevicesModel.fromJson(value.data);
        // print(allDevicesModel!.ioTDevices![0].token!);
        if (allDevicesModel!.status == '200') {
          appServices.allDevicesModel = allDevicesModel;
          for (int i = 0; i < allDevicesModel!.ioTDevices!.length; i++) {
            appServices.startRead[allDevicesModel!.ioTDevices![i].token!] = allDevicesModel!.ioTDevices![i].startRead!.toLowerCase();
            appServices.flowStatus[allDevicesModel!.ioTDevices![i].token!] = allDevicesModel!.ioTDevices![i].flowStatus;
            appServices.delayToChangePowerStatus[allDevicesModel!.ioTDevices![i].token!] = false;
          }
          UiTheme.successGetBar(allDevicesModel!.message!);
          dataReturned.value = true;
        } else {
          UiTheme.errorGetBar(allDevicesModel!.message!);
        }
      });
    } on DioException catch (e) {
      if (e.response != null) {
        // print(e.response!.data);
        // // print(e.response!.headers);
        // print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.requestOptions);
        // print(e.message);
      }
    }
    loading.value = false;
  }

  // delay var and timer set to 5min to activate the switch again

  void changePowerStatus(int index, String deviceID, String state) {
    // UiTheme.loadingDialog();
    // todo implement new logic
    // mqttService.mqttPublishMsg(MqttChannels.valveStatusMQTTChannel, {
    //   'token': deviceID,
    //   MqttChannels.valveStatusMQTTChannel: state,
    // });

    Get.log('Change power');
    // print(state);
    // print(appServices.startRead[allDevicesModel!.ioTDevices![index].name!]);
    DioHelper.postData(
      url: EndPoints.changePowerStatus,
      token: appServices.loginData!.user!.tokenData!.accessToken,
      data: {
        'meterId': deviceID
        // 'user_id': appServices.loginData!.user!.id,
      },
    ).then((value) {
      changePowerStatusModel = ChangePowerStatusModel.fromJson(value.data);
      if (changePowerStatusModel!.status == '200') {
        getAllDevices();
        // Get.back();
        appServices.startRead[allDevicesModel!.ioTDevices![index].token!] = state;
        UiTheme.successGetBar('Valve Status Changed');
        appServices.delayToChangePowerStatus[allDevicesModel!.ioTDevices![index].token!] = true;
        appServices.reactivateSwitch(allDevicesModel!.ioTDevices![index].token!);
        UiTheme.warningGetBar(StringsManager.valveDelayWarningText);
      } else {
        UiTheme.errorGetBar(changePowerStatusModel!.message!);
      }
    }).catchError((onError) {
      UiTheme.errorGetBar(onError.toString());
    });
  }
}
