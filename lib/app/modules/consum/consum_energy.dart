// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:intl/intl.dart';
// import 'package:osm_v2/app/data/services/network_helper.dart';
// import 'package:osm_v2/app/modules/consum/water_cons.dart';

// import '../../data/models/consum_model.dart';

// import 'package:get/get.dart';

// import '../../data/services/app_services.dart';

// class ConsumEnergy extends StatefulWidget {
//   const ConsumEnergy({Key key}) : super(key: key);

//   @override
//   State<ConsumEnergy> createState() => _ConsumEnergyState();
// }

// class _ConsumEnergyState extends State<ConsumEnergy> {
//   List<ConsumModel> consumption = [];
//   bool loading = false;

//   List<charts.Series<ConsumModel, String>> _createSampleData() {
//     return [
//       charts.Series<ConsumModel, String>(
//         data: consumption,
//         id: 'sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#FFC154'),
//         domainFn: (ConsumModel consumModel, _) => consumModel.date,
//         measureFn: (ConsumModel consumModel, _) => consumModel.energy,
//       )
//     ];
//   }

//   final appServices = Get.find<AppServices>();
//   DateTime _startTime;
//   String start;
//   DateTime _endTime;
//   String end;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 35),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 SizedBox(
//                   width: 140,
//                   child: ElevatedButton(
//                     // color: Color.fromRGBO(0, 154, 202, 1),
//                     child: Text(
//                       'start'.tr,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                     onPressed: () {
//                       showDatePicker(
//                         context: context,
//                         initialDate: _startTime ?? DateTime.now(),
//                         firstDate: DateTime(2022),
//                         lastDate: DateTime(2080),
//                       ).then((date) {
//                         setState(() {
//                           _startTime = date;
//                           start = DateFormat('yyyy-MM-dd').format(_startTime).toString();
//                         });
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Text(
//                   _startTime == null ? 'nothing'.tr : (start),
//                   style: TextStyle(
//                     color: appServices.isDark.value ? Colors.white : Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 SizedBox(
//                   width: 140,
//                   child: ElevatedButton(
//                     // color: const Color.fromRGBO(0, 154, 202, 1),
//                     child: Text(
//                       'end'.tr,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                     onPressed: () {
//                       showDatePicker(
//                         context: context,
//                         initialDate: _endTime ?? DateTime.now(),
//                         firstDate: DateTime(2022),
//                         lastDate: DateTime(2080),
//                       ).then((date) {
//                         setState(() {
//                           _endTime = date;
//                           end = DateFormat('yyyy-MM-dd').format(_endTime).toString();
//                         });
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Text(
//                   _endTime == null ? 'nothing'.tr : (end),
//                   style: TextStyle(
//                     color: appServices.isDark.value ? Colors.white : Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 MaterialButton(
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                   shape: const StadiumBorder(),
//                   color: const Color.fromRGBO(0, 154, 202, 1),
//                   child: Text(
//                     'show cons'.tr,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (contest) => WaterCons(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             // SizedBox(height: 20),
//             // (loading)
//             //     ? Center(
//             //         child: CircularProgressIndicator(
//             //           color: Color.fromRGBO(0, 154, 202, 1),
//             //         ),
//             //       )
//             //     : Container(
//             //         height: 500,
//             //         child: charts.BarChart(
//             //           _createSampleData(),
//             //           animate: true,
//             //         ),
//             //       ),
//           ],
//         ),
//       ),
//     );
//   }
// }
