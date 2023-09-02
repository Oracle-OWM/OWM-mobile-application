import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/data/models/all_devices_model.dart';
import 'package:osm_v2/app/data/services/app_services.dart';

import '../../../data/models/change_power_status_model.dart';
import '../../../data/services/dio_helper.dart';
import '../../../data/services/end_points.dart';
import '../../../data/services/theme.dart';

class DeviceController extends GetxController {
  static final List<Color> _gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final AppServices appServices = Get.find<AppServices>();
  final IoTDevices _deviceModel = Get.arguments['device'];
  ChangePowerStatusModel? _changePowerStatusModel;
  RxString emptyConsumption = ''.obs;
  final List<BarChartGroupData> _flowRateBarGroupData = [];
  final List<BarChartGroupData> _litersBarGroupData = [];

  String? get deviceModelName => _deviceModel.name;
  String? get deviceModelToken => _deviceModel.token;

  @override
  void onInit() {
    listsInit();
    _initFlowRateBarsData();
    _initLitersBarsData();
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
      token: appServices.loginData!.user!.tokenData!.accessToken,
      data: {
        'token': deviceID,
        'start_read': state,
        '_method': 'PUT',
      },
    ).then((value) {
      _changePowerStatusModel = ChangePowerStatusModel.fromJson(value.data);
      if (_changePowerStatusModel!.status == 200) {
        appServices.startRead[_deviceModel.name!] = state;
        UiTheme.successGetBar(_changePowerStatusModel!.message!);
      } else {
        UiTheme.errorGetBar('Error changing the state of the device');
      }
    }).catchError((onError) {});
  }

  void listsInit() {
    if (!appServices.isCustom.value) {
      emptyConsumption.value = '';
      for (int j = 0; j < _deviceModel.readings!.length; j++) {
        appServices.litersSeries.add(_deviceModel.readings![j].litersConsumed!);
        appServices.litersDays.add(_deviceModel.readings![j].createdAt!);
        appServices.flowSeries.add(_deviceModel.readings![j].flowRate!);
        appServices.flowDays.add(_deviceModel.readings![j].createdAt!);
      }
    } else {
      appServices.clearConsumptionLists();
      emptyConsumption.value = '';
      for (int i = 0; i < _deviceModel.readings!.length; i++) {
        if (_isTimeValid(i)) {
          appServices.litersSeries.add(_deviceModel.readings![i].litersConsumed!);
          appServices.litersDays.add(_deviceModel.readings![i].createdAt!);
          appServices.flowSeries.add(_deviceModel.readings![i].flowRate!);
          appServices.flowDays.add(_deviceModel.readings![i].createdAt!);
        } else {
          emptyConsumption.value = StringsManager.emptyConsumptionErrorText;
        }
      }
    }
  }

  bool _isTimeValid(int i) {
    return (DateTime.parse(_deviceModel.readings![i].createdAt!.split('T').first).isAfter(DateTime.parse(appServices.startDate.value)) ||
            DateTime.parse(_deviceModel.readings![i].createdAt!.split('T').first).isAtSameMomentAs(DateTime.parse(appServices.startDate.value))) &&
        (DateTime.parse(_deviceModel.readings![i].createdAt!.split('T').first).isBefore(DateTime.parse(appServices.endDate.value)) ||
            DateTime.parse(_deviceModel.readings![i].createdAt!.split('T').first).isAtSameMomentAs(DateTime.parse(appServices.endDate.value)));
  }

/*------------------------------------  Bar Charts  ---------------------------------------------*/
//-----------------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------------//
  _initFlowRateBarsData() {
    for (int i = 0; i < appServices.flowSeries.length; i++) {
      _flowRateBarGroupData.add(appServices.makeGroupData(i, appServices.flowSeries[i].toDouble() / 100));
    }
  }

  _initLitersBarsData() {
    for (int i = 0; i < appServices.litersSeries.length; i++) {
      _litersBarGroupData.add(appServices.makeGroupData(i, appServices.litersSeries[i].toDouble() / 100));
    }
  }

  loadFlowRateBars() {
    return BarChart(
      BarChartData(
        //! list.reduce(max) is to get the maximum element in the list
        maxY: appServices.flowSeries.reduce(max).toDouble() / 100,
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
              getTitlesWidget: appServices.bottomTitleWidgets,
              reservedSize: 42,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 10,
              getTitlesWidget: appServices.leftTitleWidgets,
            ),
          ),
        ),
        barGroups: _flowRateBarGroupData,
      ),
    );
  }

  loadLitersBars() {
    return BarChart(
      BarChartData(
        //! list.reduce(max) is to get the maximum element in the list
        maxY: appServices.litersSeries.reduce(max).toDouble() / 100,
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
              getTitlesWidget: appServices.bottomTitleWidgets,
              reservedSize: 42,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 10,
              getTitlesWidget: appServices.leftTitleWidgets,
            ),
          ),
        ),
        barGroups: _litersBarGroupData,
      ),
    );
  }

//-----------------------------------  line Charts  ---------------------------------------------//
//-----------------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------------//

  LineChartData loadLineChartDataFlow() {
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
            showTitles: appServices.litersDays.length > 10 ? false : true,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: appServices.bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 100,
            getTitlesWidget: appServices.leftTitleWidgets,
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
            colors: _gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: _gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData loadLineChartDataLiters() {
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
            showTitles: appServices.litersDays.length > 10 ? false : true,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: appServices.bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            getTitlesWidget: appServices.leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      maxX: appServices.litersDays.length.toDouble(),
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
            colors: _gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: _gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
