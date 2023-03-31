// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:intl/intl.dart';

// import 'package:get/get.dart';
// import 'package:osm_v2/app/data/services/network_helper.dart';
// import 'package:osm_v2/app/modules/consum/water_cost.dart';

// import '../../data/models/consum_model.dart';
// import '../../data/services/app_services.dart';
// import '../../data/services/shared_helper.dart';

// class Consum_Amount extends StatefulWidget {
//   const Consum_Amount({Key key}) : super(key: key);

//   @override
//   State<Consum_Amount> createState() => _Consum_AmountState();
// }

// class _Consum_AmountState extends State<Consum_Amount> {
//   List<ConsumModel> consumption = [];
//   bool loading = false;
//   final NetworkHelper _networkHelper = NetworkHelper();

//   void getData() async {
//     setState(() {
//       loading = true;
//     });
//     var response =
//         await _networkHelper.get("https://rooot.azurewebsites.net/reading/get/period?userId=${SharedHelper.getId()}&start=$start&end=$end");
//     List<ConsumModel> tempdata = consumModelFromJson(response.body);
//     print(response.body);
//     setState(() {
//       consumption = tempdata;
//       loading = false;
//     });
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
//         padding: const EdgeInsets.only(right: 10, left: 10, top: 35),
//         child: ListView(
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
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 MaterialButton(
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                   shape: const StadiumBorder(),
//                   color: const Color.fromRGBO(0, 154, 202, 1),
//                   child: Text(
//                     'show cost'.tr,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (contest) => const WaterCost(),
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
