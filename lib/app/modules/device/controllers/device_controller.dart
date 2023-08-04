import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/data/models/all_devices_model.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/models/change_power_status_model.dart';
import '../../../data/models/chart_model.dart';
import '../../../data/services/dio_helper.dart';
import '../../../data/services/end_points.dart';
import '../../../data/services/theme.dart';

class DeviceController extends GetxController {
  static final List<ChartModel> litersConsumed = [];
  static List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final AppServices appServices = Get.find<AppServices>();
  IoTDevices deviceModel = Get.arguments['device'];
  ChangePowerStatusModel? changePowerStatusModel;
  RxString emptyConsumption = ''.obs;

  @override
  void onInit() {
    litersListInit();
    super.onInit();
  }

  @override
  void onClose() {
    appServices.flowDays.clear();
    appServices.flowSeries.clear();
    appServices.litersDays.clear();
    appServices.litersSeries.clear();
    super.onClose();
  }

  void changePowerStatus(String deviceID, int state) {
    DioHelper.postData(
      url: EndPoints.changePowerStatus,
      token: appServices.accessToken.value,
      data: {
        'token': deviceID,
        'start_read': state,
        '_method': 'PUT',
      },
    ).then((value) {
      changePowerStatusModel = ChangePowerStatusModel.fromJson(value.data);
      if (changePowerStatusModel!.status == 200) {
        appServices.startRead[deviceModel.name!] = state;
        UiTheme.successGetBar(changePowerStatusModel!.message!);
      } else {
        UiTheme.errorGetBar('Error changing the state of the device');
      }
    }).catchError((onError) {});
  }

  void litersListInit() {
    if (!isCustom.value) {
      emptyConsumption.value = '';
      for (int j = 0; j < deviceModel.readings!.length; j++) {
        appServices.litersSeries.add(deviceModel.readings![j].litersConsumed!);
        appServices.litersDays.add(deviceModel.readings![j].createdAt!);
        appServices.flowSeries.add(deviceModel.readings![j].flowRate!);
        appServices.flowDays.add(deviceModel.readings![j].createdAt!);
      }
    } else {
      appServices.clearConsumptionLists();
      emptyConsumption.value = '';
      for (int i = 0; i < deviceModel.readings!.length; i++) {
        if (isTimeValid(i)) {
          appServices.litersSeries.add(deviceModel.readings![i].litersConsumed!);
          appServices.litersDays.add(deviceModel.readings![i].createdAt!);
          appServices.flowSeries.add(deviceModel.readings![i].flowRate!);
          appServices.flowDays.add(deviceModel.readings![i].createdAt!);
        } else {
          emptyConsumption.value = StringsManager.emptyConsumptionErrorText;
        }
      }
    }
  }

  bool isTimeValid(int i) {
    return (DateTime.parse(deviceModel.readings![i].createdAt!.split('T').first).isAfter(DateTime.parse(startDate.value)) ||
            DateTime.parse(deviceModel.readings![i].createdAt!.split('T').first).isAtSameMomentAs(DateTime.parse(startDate.value))) &&
        (DateTime.parse(deviceModel.readings![i].createdAt!.split('T').first).isBefore(DateTime.parse(endDate.value)) ||
            DateTime.parse(deviceModel.readings![i].createdAt!.split('T').first).isAtSameMomentAs(DateTime.parse(endDate.value)));
  }

  LineChartData loadDataLiters() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: appServices.litersDays.length.toDouble(),
      minY: 0,
      maxY: (appServices.litersSeries.reduce(max) / 100).ceil().toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (double i = 0; i < appServices.litersSeries.length; i++)
              FlSpot(
                i,
                (appServices.litersSeries[i.toInt()] / 100),
              ),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
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

    for (int i = 0; i < appServices.litersDays.length; i++) {
      date.add(appServices.litersDays[i].split('T').first);
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

  LineChartData loadDataFlow() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 100,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 55,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: appServices.litersDays.length.toDouble(),
      minY: 0,
      maxY: (appServices.flowSeries.reduce(max) / 10).ceil().toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (double i = 0; i < appServices.flowSeries.length; i++)
              FlSpot(
                i,
                (appServices.flowSeries[i.toInt()] / 10),
              ),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  RxBool isCustom = false.obs;
  void openDateDialog() {
    Get.dialog(
      Dialog(
        elevation: 10,
        backgroundColor: (appServices.isDark.value) ? Get.theme.cardColor : Colors.white,
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
              InkWell(
                onTap: () {
                  isCustom.value = true;
                  litersListInit();
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
              )
            ],
          ),
        ),
      ),
      transitionCurve: Curves.easeInOutBack,
    );
  }

  RxString startDate = ''.obs;
  RxString endDate = ''.obs;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    startDate.value = args.value.startDate.toString().split(' ').first;
    endDate.value = args.value.endDate.toString().split(' ').first;
  }
}
