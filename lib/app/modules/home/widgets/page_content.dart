import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

import '../../about_us/about_us.dart';
import '../../contact.dart';
import '../../question.dart';
import '../../setting_page.dart';
import 'card.dart';

class PageContent extends GetView<HomeController> {
  const PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
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
          PageCard(
            img: "assets/pay.jpg",
            tit: "Consumption".tr,
            onTapp: () {
              Get.toNamed(
                Routes.deviceView,
                arguments: {
                  'device': controller.allDevicesModel!.ioTDevices![0],
                },
              );
            },
          ),
          PageCard(
            img: "assets/leakk.jpg",
            tit: "Device and Leakage Detection".tr,
            onTapp: () {
              controller.appServices.changeisLoggedin(false);
              Get.toNamed(Routes.deviceAndLeakageDetection);
            },
          ),
          PageCard(
            img: "assets/faq.jpg",
            tit: "FAQ".tr,
            onTapp: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contest) => Questions(),
                ),
              );
            },
          ),
          PageCard(
            img: "assets/contact.jpg",
            tit: "Contact".tr,
            onTapp: () {
              controller.appServices.changeisLoggedin(false);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contest) => Contact(),
                ),
              );
            },
          ),
          PageCard(
            img: "assets/about.jpg",
            tit: "About us".tr,
            onTapp: () {
              controller.appServices.changeisLoggedin(false);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contest) => About(),
                ),
              );
            },
          ),
          PageCard(
            img: 'assets/setting.jpg',
            tit: "Settings".tr,
            onTapp: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contest) => const SettingPageUI(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListTile(
                  onTap: () {
                    Get.offAllNamed(Routes.login);
                  },
                  leading: const Icon(Icons.logout_outlined, color: Color.fromRGBO(0, 154, 202, 1)),
                  title: Text("Logout".tr,
                      style: TextStyle(
                        color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                      )),
                  trailing: const Icon(Icons.keyboard_arrow_right_outlined, color: Color.fromRGBO(0, 154, 202, 1)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
