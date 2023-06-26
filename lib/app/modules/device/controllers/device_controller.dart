import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/data/models/all_devices_model.dart';
import 'package:osm_v2/app/data/services/app_services.dart';

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

  @override
  void onInit() {
    for (int j = 0; j < deviceModel.readings!.length; j++) {
      appServices.litersSeries.add(deviceModel.readings![j].litersConsumed!);
      appServices.litersDays.add(deviceModel.readings![j].createdAt!);
      appServices.flowSeries.add(deviceModel.readings![j].flowRate!);
      appServices.flowDays.add(deviceModel.readings![j].createdAt!);
    }

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
            showTitles: false,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
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
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
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

    List newDate = [];
    for (int i = 0; i < appServices.litersDays.length; i++) {
      newDate.add(appServices.litersDays[i].split('T'));
    }

    if (value < newDate.length) {
      text = Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text(
          '${newDate[value.toInt()][0]}',
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
    // switch (value.toInt()) {
    //   case 1:
    //     text = value.toString();
    //     break;
    //   case 3:
    //     text = '30k';
    //     break;
    //   case 5:
    //     text = '50k';
    //     break;
    //   default:
    //     return Container();
    // }

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
            showTitles: false,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 32,
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
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
