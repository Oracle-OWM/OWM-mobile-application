import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
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
            title: Text(controller.deviceModel.name!),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Liters Consumed',
                    style: TextStyle(
                      color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Flow Rate',
                    style: TextStyle(
                      color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  controller.appServices.startRead[controller.deviceModel.name] == 1
                      ? controller.changePowerStatus(controller.deviceModel.token!, 0)
                      : controller.changePowerStatus(controller.deviceModel.token!, 1);
                },
                child: Icon(
                  controller.appServices.startRead[controller.deviceModel.name] == 0 ? Icons.pause : Icons.play_arrow,
                  size: 30,
                ),
              ),
              Icon(
                controller.appServices.flowStatus[controller.deviceModel.name] == 'normal' ? Icons.device_hub : Icons.error_outline,
                size: 30,
              ),
            ],
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: Get.width,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              'Choose Date'.title(),
                              InkWell(
                                onTap: () => controller.openDateDialog(),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Row(
                                    children: [
                                      controller.startDate.value.subtitle(),
                                      ' to '.subtitle(),
                                      controller.endDate.value.subtitle(),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.openDateDialog(),
                                child: 'date'.icon(),
                              ),
                            ],
                          ),
                          80.height,
                          controller.emptyConsumption.value == StringsManager.emptyConsumptionErrorText
                              ? controller.emptyConsumption.value.title()
                              : AspectRatio(
                                  aspectRatio: 1.50,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(18),
                                      ),
                                      color: Color(0xff232d37),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 18,
                                        left: 12,
                                        top: 24,
                                        bottom: 32,
                                      ),
                                      child: controller.isCustom.value
                                          ? controller.loadLitersBars()
                                          : LineChart(
                                              controller.loadDataLiters(),
                                            ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: Get.width,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              'Choose Date'.title(),
                              InkWell(
                                onTap: () => controller.openDateDialog(),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Row(
                                    children: [
                                      controller.startDate.value.subtitle(),
                                      ' to '.subtitle(),
                                      controller.endDate.value.subtitle(),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.openDateDialog(),
                                child: 'date'.icon(),
                              ),
                            ],
                          ),
                          80.height,
                          controller.emptyConsumption.value == StringsManager.emptyConsumptionErrorText
                              ? controller.emptyConsumption.value.title()
                              : AspectRatio(
                                  aspectRatio: 1.50,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(18),
                                      ),
                                      color: Color(0xff232d37),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 18,
                                        left: 12,
                                        top: 24,
                                        bottom: 32,
                                      ),
                                      child: controller.isCustom.value
                                          ? controller.loadFlowRateBars()
                                          : LineChart(
                                              controller.loadDataFlow(),
                                            ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
