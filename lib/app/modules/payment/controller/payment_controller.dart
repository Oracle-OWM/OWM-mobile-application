import 'package:get/get.dart';
import 'package:osm_v2/app/data/models/previous_model.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/data/services/translation_service.dart';

class PaymentController extends GetxController {
  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();
  List<PreviousModel> previousModel = [];

  DateTime? startTime;
  String? start;
  bool loading = false;
}
