import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/data/services/translation_service.dart';
import 'package:osm_v2/app/modules/bill_tabs/bill_tabs.dart';
import 'package:osm_v2/app/modules/payment/controller/payment_controller.dart';

class Previous extends GetView<PaymentController> {
  const Previous({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (contest) => BillTabs(),
              ),
            );
          },
        ),
        title: Text(
          "Previous Bill".tr,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "amountt".tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(0, 154, 202, 1),
                          ),
                        ),
                        Text("500",
                            style: TextStyle(
                              fontSize: 18,
                              color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                            )),
                      ],
                    ),
                    20.height,
                    Row(
                      children: [
                        Text(
                          'resett'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(0, 154, 202, 1),
                          ),
                        ),
                        Text(
                          "1940187",
                          style: TextStyle(
                            fontSize: 18,
                            color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    20.height,
                    Row(
                      children: [
                        Text('pay date'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(0, 154, 202, 1),
                            )),
                        Text(
                          "12/9/2022",
                          style: TextStyle(
                            fontSize: 18,
                            color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
