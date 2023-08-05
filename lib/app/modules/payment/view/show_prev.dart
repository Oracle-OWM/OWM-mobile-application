import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osm_v2/app/modules/payment/controller/payment_controller.dart';
import 'package:osm_v2/app/modules/payment/view/previous.dart';

class ShowPrev extends GetView<PaymentController> {
  const ShowPrev({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    child: Text(
                      'pick'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: controller.startTime ?? DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2080),
                      ).then(
                        (date) {
                          controller.startTime = date;
                          controller.start = DateFormat('yyyy-MM-dd').format(controller.startTime!).toString();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  controller.startTime == null ? 'nothing'.tr : (controller.start!),
                  style: TextStyle(
                    color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: const StadiumBorder(),
                  color: const Color.fromRGBO(0, 154, 202, 1),
                  child: Text(
                    'show bill'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (contest) => const Previous(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
