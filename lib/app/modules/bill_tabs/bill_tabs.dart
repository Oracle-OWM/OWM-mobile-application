import 'package:flutter/material.dart';
import 'package:osm_v2/app/modules/home/view/home_view.dart';
import '../../data/services/app_services.dart';

import 'package:get/get.dart';

import '../pay.dart';
import '../show_prev.dart';

class BillTabs extends StatelessWidget {
  final appServices = Get.find<AppServices>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (contest) => const HomeView(),
                  ),
                );
              }),
          title: Text('b&p'.tr,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          bottom: TabBar(
            tabs: [Tab(text: 'paay'.tr), Tab(text: 'prev'.tr)],
          ),
        ),
        body: TabBarView(
          children: [
            Pay(),
            const ShowPrev(),
          ],
        ),
      ),
    );
  }
}
