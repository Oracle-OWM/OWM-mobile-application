import 'package:get/get.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

import '../../../data/services/app_services.dart';

class SplashController extends GetxController {
  final appServices = Get.find<AppServices>();
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.offAllNamed(Routes.login);
        // if (appServices.isLoggedin.value == false) {
        //   Get.offAllNamed(Routes.login);
        // } else {
        //   Get.offAllNamed(Routes.home);
        // }
      },
    );
    super.onInit();
  }
}
