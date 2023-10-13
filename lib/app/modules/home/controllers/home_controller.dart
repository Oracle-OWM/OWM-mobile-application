import 'dart:async';

import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/mqtt_channels.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/data/models/all_devices_model.dart';
import 'package:osm_v2/app/data/models/device_model.dart';
import 'package:osm_v2/app/data/services/dio_helper.dart';
import 'package:osm_v2/app/data/services/end_points.dart';
import 'package:osm_v2/app/data/services/mqtt_service.dart';
import 'package:osm_v2/app/data/services/theme.dart';

import '../../../data/services/app_services.dart';

class HomeController extends GetxController {
  // final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  final mqttService = Get.find<MQTTService>();
  final double coverHeight = 280;
  final double profileHeight = 144;
  DeviceModel? deviceModel;
  AllDevicesModel? allDevicesModel;
  RxBool loading = false.obs;
  RxBool dataReturned = false.obs;

  // final wsUrl = Uri.parse('ws://192.168.1.17:6001/app/livepost_key?protocol=7&client=js&version=7.5.0&flash=false');
  // String deviceChannel = '{"event":"pusher:subscribe", "data":{"auth":"","channel":"dashboard-IoTDevice-details-channel"}}';
  // WebSocketChannel? channel;

  @override
  void onInit() {
    // todo add mqtt calls for subscribed topics with the backend
    mqttService.mqttSubscribeAndListen(MqttChannels.flowStatusMQTTChannel);
    mqttService.mqttSubscribeAndListen(MqttChannels.readingsMQTTChannel);
    mqttService.mqttSubscribeAndListen(MqttChannels.valveStatusMQTTChannel);

    getAllDevices();
    super.onInit();
  }

  void postDevice(String deviceID) {
    Get.log('entered device id');
    DioHelper.postData(url: EndPoints.postAssociateUser, data: {
      'token': deviceID,
      'user_id': appServices.loginData!.user!.id,
    }).then((value) {
      deviceModel = DeviceModel.fromJson(value.data);
      if (deviceModel!.status == 200) {
        getAllDevices();
        Get.back();
        UiTheme.successGetBar(deviceModel!.message!);
      } else {
        UiTheme.errorGetBar(deviceModel!.message!);
      }
    }).catchError((onError) {
      UiTheme.errorGetBar(onError);
    });
  }

  Future<void> getAllDevices() async {
    loading.value = true;
    dataReturned.value = false;
    await DioHelper.getData(
      url: '${EndPoints.getAssociateUser}/${appServices.loginData!.user!.id!}',
      token: appServices.loginData!.user!.tokenData!.accessToken,
    ).then((value) {
      allDevicesModel = AllDevicesModel.fromJson(value.data);
      if (allDevicesModel!.status == 200) {
        appServices.allDevicesModel = allDevicesModel;
        for (int i = 0; i < allDevicesModel!.ioTDevices!.length; i++) {
          appServices.startRead[allDevicesModel!.ioTDevices![i].name!] = allDevicesModel!.ioTDevices![i].startRead;
          appServices.flowStatus[allDevicesModel!.ioTDevices![i].token!] = allDevicesModel!.ioTDevices![i].flowStatus;
          appServices.delayToChangePowerStatus[allDevicesModel!.ioTDevices![i].name!] = false;
        }
        UiTheme.successGetBar(allDevicesModel!.message!);
        dataReturned.value = true;
      } else {
        UiTheme.errorGetBar(allDevicesModel!.message!);
      }
    }).catchError((error) {
      UiTheme.errorGetBar(error);
    });
    loading.value = false;
  }

  // delay var and timer set to 5min to activate the switch again

  void changePowerStatus(int index, String deviceID, int state) {
    // UiTheme.loadingDialog();
    mqttService.mqttPublishMsg(MqttChannels.valveStatusMQTTChannel, {
      'token': deviceID,
      MqttChannels.valveStatusMQTTChannel: state,
    });
    appServices.startRead[allDevicesModel!.ioTDevices![index].name!] = state;
    UiTheme.successGetBar('Valve Status Changed');
    appServices.delayToChangePowerStatus[allDevicesModel!.ioTDevices![index].name!] = true;
    appServices.reactivateSwitch(allDevicesModel!.ioTDevices![index].name!);
    UiTheme.warningGetBar(StringsManager.valveDelayWarningText);
  }

}
