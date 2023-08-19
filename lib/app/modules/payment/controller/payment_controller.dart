import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/data/models/previous_model.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/data/services/translation_service.dart';

class PaymentController extends GetxController {
  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();
  List<PreviousModel> previousModel = [];

  DateTime? startTime;
  String? start;
  bool loading = false;
  RxString emptyCost = ''.obs;
  final List<BarChartGroupData> _costBarGroupData = [];

  @override
  void onInit() {
    _initCostBarsData();
    super.onInit();
  }

  //* function to load the Dummy cost data in Bar chart
  loadCostBars() {
    return BarChart(
      BarChartData(
        maxY: 20,
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
        barGroups: _costBarGroupData,
      ),
    );
  }

  _initCostBarsData() {
    // todo add empty check for cost data
    // todo change the length later (PaymentAPICall.costLength)
    for (int i = 0; i < 5; i++) {
      // todo change the (10 + i) to the value from the previous cost later (data from payment API)
      _costBarGroupData.add(appServices.makeGroupData(i, (10 + i).toDouble()));
    }
  }
}
