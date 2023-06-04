import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

import '../../../data/models/login_model.dart';
import '../../../data/services/app_services.dart';
import '../../../data/services/dio_helper.dart';
import '../../../data/services/end_points.dart';

class LoginController extends GetxController {
  // final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  RxBool check = true.obs;
  bool load = false;
  var email = TextEditingController();
  var pass = TextEditingController();
  var ip = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? mail;
  String? passwd;
  String? serverIP;
  LoginModel? loginModel;

  void login({String? username, String? password}) {
    DioHelper.postData(
      url: EndPoints.login,
      data: {'identifier': username, 'password': password},
    ).then((value) async {
      loginModel = LoginModel.fromJson(value.data);
      // UiTheme.successGetBar(loginModel.message);
      if (loginModel!.status == 200) {
        appServices.accessToken.value = loginModel!.user!.tokenData!.accessToken!;
        Get.offAllNamed(Routes.home, arguments: {'data': loginModel});
      } else {
        Get.dialog(Dialog(
          backgroundColor: (appServices.isDark.value) ? Colors.grey.shade700 : Colors.white,
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "invalid".tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: appServices.isDark.value ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }
}
