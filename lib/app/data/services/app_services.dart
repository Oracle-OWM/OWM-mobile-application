import 'package:get/get.dart';
import 'package:osm_v2/app/data/models/login_model.dart';

import 'shared_prefs.dart';

class AppServices extends GetxService {
  /*--------------------------------------------------------------------------*/
  /*------------------------------  Variables  -------------------------------*/
  /*--------------------------------------------------------------------------*/
  RxBool isDark = false.obs;
  RxBool isLoggedin = false.obs;
  RxString profileImage = "".obs;
  RxList<int> litersSeries = <int>[].obs;
  RxList<String> litersDays = <String>[].obs;
  RxString accessToken = ''.obs;
  RxMap<String, dynamic> startRead = <String, dynamic>{}.obs;
  RxMap<String, dynamic> flowStatus = <String, dynamic>{}.obs;
  LoginModel? loginData;

  RxList<int> flowSeries = <int>[].obs;
  RxList<String> flowDays = <String>[].obs;
  // @override
  // onInit() {
  //   super.onInit();
  // getisLoggedinFromPrefs();
  // getThemeFromPrefs();
  // getprofileImage();
  // }
  /*--------------------------------------------------------------------------*/
  /*---------------------------  Save Functions  -----------------------------*/
  /*--------------------------------------------------------------------------*/

  changeTheme(bool value) {
    isDark.value = value;
    SharedPrefsHelper.saveTheme(value);
  }

  getThemeFromPrefs() async {
    bool val = await SharedPrefsHelper.checkTheme();
    if (val) {
      isDark.value = await SharedPrefsHelper.getTheme();
    } else {
      isDark.value = false;
    }
  }

  getprofileImage() async {
    String value = await SharedPrefsHelper.getPic();
    profileImage.value = value;
  }

  changeisLoggedin(bool value) {
    isLoggedin.value = value;
    SharedPrefsHelper.storeisLoggedin(value);
  }

  getisLoggedinFromPrefs() async {
    bool val = await SharedPrefsHelper.getisLoggedin();
    isLoggedin.value = val;
  }

  /*--------------------------------------------------------------------------*/
  /*--------------------------  user info  Functions  ----------------------------*/
  /*--------------------------------------------------------------------------*/
}
