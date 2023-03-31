import 'package:get/get.dart';
import 'package:osm_v2/app/modules/device/controllers/device_controller.dart';

class DeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeviceController>(() => DeviceController());
  }
}
