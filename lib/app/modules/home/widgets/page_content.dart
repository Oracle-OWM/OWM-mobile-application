import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

import 'card.dart';

class PageContent extends GetView<HomeController> {
  const PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          10.height,
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
              // controller.postDevice('123156781adcdef123456777');
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
          16.height,
          const Divider(),
          PageCard(
            img: StringsManager.consumption,
            tit: "Consumption".tr,
            onTapp: () => controller.appServices.openDeviceChoiceDialog(),
          ),
          PageCard(
            img: StringsManager.leak,
            tit: "Device and Leakage Detection".tr,
            onTapp: () {
              controller.appServices.changeisLoggedin(false);
              Get.toNamed(Routes.deviceAndLeakageDetection);
            },
          ),
          PageCard(
            img: StringsManager.pay,
            tit: "Payment Process".tr,
            onTapp: () => Get.toNamed(Routes.billTabs),
          ),
          PageCard(
            img: StringsManager.faq,
            tit: "FAQ".tr,
            onTapp: () => Get.toNamed(Routes.questions),
          ),
          PageCard(
            img: StringsManager.contact,
            tit: "Contact".tr,
            onTapp: () {
              controller.appServices.changeisLoggedin(false);
              Get.toNamed(Routes.contacts);
            },
          ),
          PageCard(
            img: StringsManager.about,
            tit: "About us".tr,
            onTapp: () {
              controller.appServices.changeisLoggedin(false);
              Get.toNamed(Routes.aboutUs);
            },
          ),
          PageCard(
            img: StringsManager.settings,
            tit: "Settings".tr,
            onTapp: () => Get.toNamed(Routes.settings),
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
                  onTap: () => Get.offAllNamed(Routes.login),
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Color.fromRGBO(0, 154, 202, 1),
                  ),
                  title: Text(
                    "Logout".tr,
                    style: TextStyle(
                      color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                    ),
                  ),
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
