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
                onTap: () => controller.appServices.delayToChangePowerStatus[controller.deviceModelToken]!
                    ? null
                    : controller.appServices.startRead[controller.deviceModelToken] == 'true'
                        ? controller.changePowerStatus(controller.deviceModelToken!, 'false')
                        : controller.changePowerStatus(controller.deviceModelToken!, 'true'),
                child: Icon(
                  controller.appServices.startRead[controller.deviceModelToken] == 'false' ? Icons.pause : Icons.play_arrow,
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
