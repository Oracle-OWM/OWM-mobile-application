import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/modules/device/controllers/device_controller.dart';

class DeviceView extends GetView<DeviceController> {
  const DeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(controller.deviceModelName!),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Liters Consumed',
                    style: TextStyle(color: controller.appServices.isDark.value ? Colors.white : Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Flow Rate',
                    style: TextStyle(color: controller.appServices.isDark.value ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () => controller.appServices.delayToChangePowerStatus[controller.deviceModelName]!
                    ? null
                    : controller.appServices.startRead[controller.deviceModelName] == 1
                        ? controller.changePowerStatus(controller.deviceModelToken!, 0)
                        : controller.changePowerStatus(controller.deviceModelToken!, 1),
                child: Icon(
                  controller.appServices.startRead[controller.deviceModelName] == 0 ? Icons.pause : Icons.play_arrow,
                  size: 30,
                ),
              ),
              Icon(controller.appServices.flowStatus[controller.deviceModelToken] == StringsManager.normalReading ? Icons.device_hub : Icons.error_outline, size: 30),
            ],
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: controller.tabs,
          ),
        ),
      ),
    );
  }
}
