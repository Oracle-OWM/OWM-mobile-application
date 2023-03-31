import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

import '../data/services/shared_helper.dart';
import '../data/services/translation_service.dart';

class Pay extends StatefulWidget {
  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  var responsebody;

  Future getData() async {
    var url =
        "https://rooot.azurewebsites.net/generate/Bill?userId=${SharedHelper.getId()}";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "your bill".tr,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 154, 202, 1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text("id".tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text("30",
                              style: TextStyle(
                                fontSize: 18,
                                color: appServices.isDark.value
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('namee'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text(
                            "Noor El Deen",
                            style: TextStyle(
                              fontSize: 18,
                              color: appServices.isDark.value
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('your mail'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text("nooreldeen@gmail.com",
                              style: TextStyle(
                                fontSize: 18,
                                color: appServices.isDark.value
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('phone'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text("01150462982",
                              style: TextStyle(
                                fontSize: 18,
                                color: appServices.isDark.value
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('addresss'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text("17st Faisal",
                              style: TextStyle(
                                fontSize: 18,
                                color: appServices.isDark.value
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Consumption'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text("500",
                              style: TextStyle(
                                fontSize: 18,
                                color: appServices.isDark.value
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('costt'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text("300",
                              style: TextStyle(
                                fontSize: 18,
                                color: appServices.isDark.value
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text('last'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(0, 154, 202, 1),
                              )),
                          Text("12/9/2022",
                              style: TextStyle(
                                fontSize: 18,
                                color: appServices.isDark.value
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: const StadiumBorder(),
              color: const Color.fromRGBO(0, 154, 202, 1),
              onPressed: () {},
              child: Text("paay".tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }

  Future<void> _launchUrl(String urlString) async {
    if (await canLaunch(urlString)) {
      await launch(
        urlString,
      );
    } else {
      print('Can\'t launch Url');
    }
  }
}
