import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/modules/payment/controller/payment_controller.dart';

class PreviousPaymentsView extends GetView<PaymentController> {
  const PreviousPaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  'Choose Date'.title(),
                  InkWell(
                    onTap: () => controller.appServices.openDateDialog(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          controller.appServices.startDate.value.subtitle(),
                          ' to '.subtitle(),
                          controller.appServices.endDate.value.subtitle(),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.appServices.openDateDialog(),
                    child: 'date'.icon(),
                  ),
                ],
              ),
              50.height,
              controller.emptyCost.value == StringsManager.emptyCostErrorText
                  ? controller.emptyCost.value.title()
                  : AspectRatio(
                      aspectRatio: 1.50,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Color(0xff232d37),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 18,
                            left: 12,
                            top: 24,
                            bottom: 32,
                          ),
                          child: controller.appServices.isCustom.value ? controller.loadCostBars() : Container(),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
