import 'package:get/get.dart';
import 'package:osm_v2/app/modules/questions/controller/questions_controller.dart';

class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsController>(() => QuestionsController());
  }
}
