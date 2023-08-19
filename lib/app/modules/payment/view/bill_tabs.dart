import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/modules/payment/view/payment_view.dart';
import 'package:osm_v2/app/modules/payment/view/previous_payments_view.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

class BillTabs extends StatelessWidget {
  const BillTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.toNamed(Routes.home),
          ),
          title: Text(
            'Bills & Payments'.tr,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Current Payment'.tr),
              Tab(text: 'Previous Payments'.tr),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PaymentView(),
            PreviousPaymentsView(),
          ],
        ),
      ),
    );
  }
}
