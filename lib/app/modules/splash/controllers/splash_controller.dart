import 'package:get/get.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/routes/app_pages.dart';


class SplashController extends GetxController {
  final appServices = Get.find<AppServices>();
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (appServices.isLoggedin.value == false) {
          Get.offAllNamed(Routes.login);
        } else {
          Get.offAllNamed(Routes.home);
        }
      },
    );
    super.onInit();
  }
}
