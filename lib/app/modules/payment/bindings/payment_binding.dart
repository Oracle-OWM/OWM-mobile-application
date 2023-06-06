import 'package:get/get.dart';
import 'package:osm_v2/app/modules/payment/controller/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}
