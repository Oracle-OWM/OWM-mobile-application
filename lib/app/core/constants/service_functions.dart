import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/data/services/dio_helper.dart';
import 'package:osm_v2/app/data/services/shared_helper.dart';
import 'package:osm_v2/app/data/services/translation_service.dart';

class ServicesFunctions {
  static Future<void> initServices() async {
    Get.log('starting services ...');

    await Get.putAsync<AppServices>(() async => AppServices());
    await SharedHelper.init();
    await DioHelper.init(path: StringsManager.baseUrl);
    await Get.putAsync<TranslationService>(() async => TranslationService());
    // await Get.putAsync<MQTTService>(() async => MQTTService());
    Get.log('All Services Started ...');
  }
}
