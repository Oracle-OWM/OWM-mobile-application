import 'package:flutter/material.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';

import 'package:osm_v2/app/modules/payment/controller/payment_controller.dart';

import 'package:get/get.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Your bill".tr,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 154, 202, 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
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
                                'Name: '.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 154, 202, 1),
                                ),
                              ),
                              Text(
                                "${controller.appServices.loginData!.user!.firstName}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            children: [
                              Text(
                                'Mail: '.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 154, 202, 1),
                                ),
                              ),
                              Text("${controller.appServices.loginData!.user!.email}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                                  )),
                            ],
                          ),
                          10.height,
                          Row(
                            children: [
                              Text(
                                'Phone: '.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 154, 202, 1),
                                ),
                              ),
                              Text(
                                "${controller.appServices.loginData!.user!.phone}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            children: [
                              Text(
                                'Consumption: '.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 154, 202, 1),
                                ),
                              ),
                              Text(
                                "500",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            children: [
                              Text(
                                'Cost'.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 154, 202, 1),
                                ),
                              ),
                              Text(
                                "300",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          Row(
                            children: [
                              Text(
                                'Last'.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 154, 202, 1),
                                ),
                              ),
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
                20.height,
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: const StadiumBorder(),
                  color: const Color.fromRGBO(0, 154, 202, 1),
                  onPressed: () {
                    // todo start the Payment method API calls
                  },
                  child: Text(
                    "Pay".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                20.height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
