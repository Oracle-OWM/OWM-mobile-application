import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/data/models/login_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  void openDateDialog({bool isDeviceLeakage = false, Function? litersListInit}) {
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
                        litersListInit!.call();
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
                        litersListInit!.call();
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
}
