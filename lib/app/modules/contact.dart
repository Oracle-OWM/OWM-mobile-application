import 'package:flutter/material.dart';
import 'package:osm_v2/app/modules/home/view/home_view.dart';
import '../core/utils.dart';
import '../data/services/app_services.dart';
import '../data/services/translation_service.dart';
import 'package:get/get.dart';

class Contact extends StatelessWidget {
  final appServices = Get.find<AppServices>();

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
                    builder: (contest) => const HomeView(),
                  ),
                );
              }),
          title: Text("Contact".tr,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "you can".tr,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: appServices.isDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 1.8, left: 1.8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Card(
                            child: ListTile(
                              title: Text(
                                "via ph".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: appServices.isDark.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              leading: Image.asset(
                                'assets/phone-call.png',
                                width: 30,
                                color: const Color.fromRGBO(34, 177, 76, 1),
                              ),
                              onTap: () {
                                Utils.openPhone(
                                  phoneNumber: '01117199897',
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          child: Card(
                            child: ListTile(
                              title: Text(
                                "via SMS".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: appServices.isDark.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              leading: Image.asset(
                                'assets/chatting.png',
                                width: 30,
                                color: const Color.fromRGBO(34, 177, 76, 1),
                              ),
                              onTap: () {
                                Utils.openMessage(phoneNumber: '01117199897');
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 60,
                          child: Card(
                            child: ListTile(
                              title: Text(
                                "via mail".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: appServices.isDark.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              leading: Image.asset(
                                'assets/message.png',
                                width: 30,
                                color: const Color.fromRGBO(34, 177, 76, 1),
                              ),
                              onTap: () {
                                Utils.openEmail(
                                  toEmail: 'example@gmail.com',
                                  subject: "Help",
                                  body: "Help me with...",
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
