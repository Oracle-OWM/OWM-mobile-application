import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/services/app_services.dart';
import '../../../data/services/shared_prefs.dart';
import '../../setting_page.dart';

class EditPasswordController extends GetxController {
  final appServices = Get.find<AppServices>();
  bool load = false;
  bool isObsecurePassword = true;
  var omail = TextEditingController();
  var opass = TextEditingController();
  var npass = TextEditingController();
  var nnpass = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void postData() async {
    load = true;
    try {
      // var response = await Dio().post(
      //   'https://rooot.azurewebsites.net/user/create',
      //   data: UserDataModel().toJson(),
      // );
      Get.offAll(const SettingPageUI());
      load = false;
    } catch (e) {
      load = false;
    }
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    appServices.profileImage.value = pickedFile!.path;
    SharedPrefsHelper.storePic(pickedFile.path);
  }
}
