import 'package:get/get.dart';
import 'package:osm_v2/app/modules/login/controller/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
