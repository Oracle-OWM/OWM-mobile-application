import 'package:get/get.dart';
import 'package:osm_v2/app/modules/about_us/controller/about_us_controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController(), fenix: true);
  }
}
