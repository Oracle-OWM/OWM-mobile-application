import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';

import '../home/widgets/top_part.dart';

class DeviceAndLeakageDetection extends GetView<HomeController> {
  const DeviceAndLeakageDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
            title: Text("Device And Leakage Detection".tr,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          body: Column(
            children: [
              const TopPart(),
              const SizedBox(
                height: 10,
              ),
              Text(
                controller.appServices.loginData!.user!.firstName!,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                ),
              ),
              InkWell(
                onTap: () async {
                  // controller.readNewMessage();
                  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('red', 'cancel', false, ScanMode.QR);
                  if (barcodeScanRes != '-1') {
                    controller.postDevice(barcodeScanRes);
                  }
                },
                child: const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.qr_code),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              controller.loading.value && controller.allDevicesModel == null
                  ? const CircularProgressIndicator.adaptive()
                  : controller.allDevicesModel!.ioTDevices!.isEmpty
                      ? const Text('Couldn\'t find any device connected to your account please make sure to scan the QR code first')
                      : SizedBox(
                          width: Get.width,
                          height: Get.height / 4,
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(30),
                            crossAxisSpacing: 1,
                            childAspectRatio: 0.6,
                            mainAxisSpacing: 20,
                            crossAxisCount: 4,
                            children: [
                              for (int i = 0; i < controller.allDevicesModel!.ioTDevices!.length; i++)
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Get.toNamed(
                                        //   Routes.deviceView,
                                        //   arguments: {
                                        //     'device': controller
                                        //         .allDevicesModel.ioTDevices[i],
                                        //   },
                                        // );
                                      },
                                      child: SizedBox(
                                        height: Get.height * 0.1,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.4,
                                              height: Get.height * 0.07,
                                              child: Stack(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 55,
                                                    child: Image.asset(
                                                      'assets/tap.png',
                                                      width: 45,
                                                    ),
                                                  ),
                                                  if (controller.appServices.flowStatus[controller.allDevicesModel!.ioTDevices![i].name] != 'normal')
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                      child: Image.asset(
                                                        'assets/danger.png',
                                                        width: 25,
                                                      ),
                                                    ),
                                                  CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        controller.appServices.startRead[controller.allDevicesModel!.ioTDevices![i].name] == 1
                                                            ? Colors.green
                                                            : Colors.red,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(controller.allDevicesModel!.ioTDevices![i].name!),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: controller.appServices.startRead[controller.allDevicesModel!.ioTDevices![i].name] == 1 ? true : false,
                                      onChanged: (val) {
                                        controller.appServices.startRead[controller.allDevicesModel!.ioTDevices![i].name] == 1
                                            ? controller.changePowerStatus(i, controller.allDevicesModel!.ioTDevices![i].token!, 0)
                                            : controller.changePowerStatus(i, controller.allDevicesModel!.ioTDevices![i].token!, 1);
                                      },
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
            ],
          ),
        ));
  }
}
