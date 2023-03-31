// import 'package:flutter/material.dart';
// import '../../data/services/app_services.dart';
// import '../home/view/home_view.dart';
// import 'consum_energy.dart';
// import 'consum_cost.dart';
// import 'package:get/get.dart';
//
// class ConsumTabs extends StatelessWidget {
//   final appServices = Get.find<AppServices>();
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
//           leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (contest) => const HomeView(),
//                   ),
//                 );
//               }),
//           title: Text('conss'.tr,
//               style: const TextStyle(
//                 fontSize: 22,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               )),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'consum'.tr),
//               Tab(text: 'cost'.tr),
//             ],
//           ),
//         ),
//         body:  TabBarView(
//           children: [
//
//           ],
//         ),
//       ),
//     );
//   }
// }
