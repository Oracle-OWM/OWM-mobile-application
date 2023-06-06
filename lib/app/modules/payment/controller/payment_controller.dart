import 'package:get/get.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/data/services/translation_service.dart';

class PaymentController extends GetxController {
  // var responsebody;
  
  // Future getData() async {
  //   var url = "https://rooot.azurewebsites.net/generate/Bill?userId=${SharedHelper.getId()}";
  //   var response = await http.get(Uri.parse(url));
  //   var responsebody = jsonDecode(response.body);
  //   return responsebody;
  // }

  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();
  
}
