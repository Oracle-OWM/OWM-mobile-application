import 'package:get/get.dart';
import 'package:osm_v2/app/modules/contacts/controller/contact_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactsController>(() => ContactsController(), fenix: true);
  }
}
