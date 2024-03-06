import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/data/models/all_devices_model.dart';
import 'package:osm_v2/app/data/models/login_model.dart';
import 'package:osm_v2/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'shared_prefs.dart';

class AppServices extends GetxService {
  /*--------------------------------------------------------------------------*/
  /*------------------------------  Variables  -------------------------------*/
  /*--------------------------------------------------------------------------*/
  RxBool isDark = false.obs;
  RxBool isLoggedin = false.obs;
  RxString profileImage = "".obs;
  RxList<double> litersSeries = <double>[].obs;
  RxList<String> litersDays = <String>[].obs;
  RxString accessToken = ''.obs;
  RxMap<String, dynamic> startRead = <String, dynamic>{}.obs;
  RxMap<String, dynamic> flowStatus = <String, dynamic>{}.obs;
  RxMap<String, bool> delayToChangePowerStatus = <String, bool>{}.obs;
  LoginModel? loginData;
  AllDevicesModel? allDevicesModel;
  RxInt deviceIndex = (-1).obs;
  RxList<double> flowSeries = <double>[].obs;
  RxList<String> flowDays = <String>[].obs;

  // @override
  // onInit() {
  //   super.onInit();
  //   // getisLoggedinFromPrefs();
  //   // getThemeFromPrefs();
  //   // getprofileImage();
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
  /*--------------------  Consumption Clear  Function  -----------------------*/
  /*--------------------------------------------------------------------------*/

  void clearConsumptionLists() {
    litersSeries.value = [];
    litersDays.value = [];
    flowDays.value = [];
    flowSeries.value = [];
  }

  double barWidth = 10;
  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: barWidth,
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
    );
    Widget text;

    List date = [];

    for (int i = 0; i < litersDays.length; i++) {
      date.add(litersDays[i].split('T').first);
    }
    if (value < date.length) {
      text = Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text(
          '${date[value.toInt()]}',
          style: style,
        ),
      );
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: (75 * pi / 180),
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;

    text = '$value';
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  RxBool isCustom = false.obs;
  //* function to open the Dialog to choose Date Range
  void openDateDialog({bool isDeviceLeakage = false, Function? listsInitFunction}) {
    startDate.value = '';
    endDate.value = '';
    Get.dialog(
      Dialog(
        elevation: 10,
        backgroundColor: (isDark.value) ? Get.theme.cardColor : Colors.white,
        insetAnimationCurve: Curves.bounceInOut,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      isCustom.value = true;
                      if (isDeviceLeakage) {
                        listsInitFunction!.call();
                      }
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey,
                      ),
                      child: 'Done'.title(),
                    ),
                  ),
                  20.width,
                  InkWell(
                    onTap: () {
                      isCustom.value = false;
                      if (isDeviceLeakage) {
                        listsInitFunction!.call();
                      }
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey,
                      ),
                      child: 'Clear Filter'.title(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      transitionCurve: Curves.easeInOutBack,
    );
  }

  RxString startDate = ''.obs;
  RxString endDate = ''.obs;

  //* function to get the start & end Date
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    startDate.value = args.value.startDate.toString().split(' ').first;
    endDate.value = args.value.endDate.toString().split(' ').first;
  }

  void openDeviceChoiceDialog() {
    Get.dialog(
      Dialog(
        elevation: 10,
        backgroundColor: (isDark.value) ? Get.theme.cardColor : Colors.white,
        insetAnimationCurve: Curves.bounceInOut,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: SizedBox(
            height: Get.height * 0.3,
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              children: [
                for (int deviceIndex = 0; deviceIndex < allDevicesModel!.ioTDevices!.length; deviceIndex++)
                  SizedBox(
                    width: Get.width * 0.2,
                    height: Get.height * 0.07,
                    child: InkWell(
                      onTap: () => Get.toNamed(
                        Routes.deviceView,
                        arguments: {
                          'device': allDevicesModel!.ioTDevices![deviceIndex],
                        },
                      ),
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width * 0.2,
                              height: Get.height * 0.07,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    child: Image.asset(
                                      'assets/tap.png',
                                      width: 45,
                                    ),
                                  ),
                                  if (flowStatus[allDevicesModel!.ioTDevices![deviceIndex].token] != 'normal')
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        'assets/danger.png',
                                        width: 25,
                                      ),
                                    ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: startRead[allDevicesModel!.ioTDevices![deviceIndex].name] == 1 ? Colors.green : Colors.red,
                                  )
                                ],
                              ),
                            ),
                            allDevicesModel!.ioTDevices![deviceIndex].name!.caption(),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      transitionCurve: Curves.easeInOutBack,
    );
  }

  void reactivateSwitch(String deviceName) => Timer(const Duration(seconds: 20), () => delayToChangePowerStatus[deviceName] = false);
}
