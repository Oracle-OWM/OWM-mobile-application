import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

class PageCardData {
  static List<Map<String, dynamic>> map = [
    {
      'image': StringsManager.consumption,
      'title': "Consumption".tr,
      'onTapp': (AppServices appServices) => appServices.openDeviceChoiceDialog(),
    },
    {
      'image': StringsManager.leak,
      'title': "Device and Leakage Detection".tr,
      'onTapp': (appServices) {
        appServices.changeisLoggedin(false);
        Get.toNamed(Routes.deviceAndLeakageDetection);
      },
    },
    {
      'image': StringsManager.pay,
      'title': "Payment Process".tr,
      'onTapp': (appServices) => Get.toNamed(Routes.billTabs),
    },
    {
      'image': StringsManager.faq,
      'title': "FAQ".tr,
      'onTapp': (appServices) => Get.toNamed(Routes.questions),
    },
    {
      'image': StringsManager.contact,
      'title': "Contact".tr,
      'onTapp': (appServices) {
        appServices.changeisLoggedin(false);
        Get.toNamed(Routes.contacts);
      },
    },
    {
      'image': StringsManager.about,
      'title': "About us".tr,
      'onTapp': (appServices) {
        appServices.changeisLoggedin(false);
        Get.toNamed(Routes.aboutUs);
      },
    },
    {
      'image': StringsManager.settings,
      'title': "Settings".tr,
      'onTapp': (appServices) => Get.toNamed(Routes.settings),
    },
  ];
}
