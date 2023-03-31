import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/app_services.dart';

class ForgetController extends GetxController{
    var mail = TextEditingController();
  final appServices = Get.find<AppServices>();
}