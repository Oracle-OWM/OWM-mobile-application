// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'consum_tabs.dart';

// class WaterCost extends StatelessWidget {
//   static final List<ChartElement> chartData = [
//     ChartElement("10/10/2022", 50, const Color.fromRGBO(34, 177, 76, 1)),
//     ChartElement("11/10/2022", 60, const Color.fromRGBO(34, 177, 76, 1)),
//     ChartElement("12/10/2022", 40, const Color.fromRGBO(34, 177, 76, 1)),
//   ];

//   const WaterCost({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     List<charts.Series<ChartElement, String>> series = [
//       charts.Series(
//           data: chartData,
//           id: "Chart Elements",
//           domainFn: (ChartElement pops, _) => pops.day,
//           measureFn: (ChartElement pops, _) => pops.cons,
//           colorFn: (ChartElement pops, _) => charts.ColorUtil.fromDartColor(pops.barColor))
//     ];
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
//         leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(
//                   builder: (contest) => ConsumTabs(),
//                 ),
//               );
//             }),
//         title: Text("Cost Chart".tr,
//             style: const TextStyle(
//               fontSize: 22,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             )),
//         //automaticallyImplyLeading: true,
//       ),
//       body: Center(
//           child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height / 2,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: charts.BarChart(
//             series,
//             animate: true,
//           ),
//         ),
//       )),
    
//     );
//   }
// }

// class ChartElement {
//   final String day;
//   final int cons;
//   final Color barColor;

//   ChartElement(this.day, this.cons, this.barColor);
// }
