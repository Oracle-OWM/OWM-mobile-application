import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Liters Consumed',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Flow Rate',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  controller.appServices
                              .startRead[controller.deviceModel.name] ==
                          1
                      ? controller.changePowerStatus(
                          controller.deviceModel.token!, 0)
                      : controller.changePowerStatus(
                          controller.deviceModel.token!, 1);
                },
                child: Icon(
                  controller.appServices
                              .startRead[controller.deviceModel.name] ==
                          0
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 30,
                ),
              ),
              Icon(
                controller.appServices
                            .flowStatus[controller.deviceModel.name] ==
                        'normal'
                    ? Icons.device_hub
                    : Icons.error_outline,
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
                      child: Stack(
                        children: <Widget>[
                          AspectRatio(
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
                                child: LineChart(
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
                      child: Stack(
                        children: <Widget>[
                          AspectRatio(
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
                                child: LineChart(
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
