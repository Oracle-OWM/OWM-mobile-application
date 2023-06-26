import 'package:intl/intl.dart';
import 'package:osm_v2/app/data/services/translation_service.dart';
import 'package:osm_v2/app/modules/previous.dart';
import '../data/models/previous_model.dart';
import '../data/services/app_services.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ShowPrev extends StatefulWidget {
  const ShowPrev({Key? key}) : super(key: key);

  @override
  State<ShowPrev> createState() => _ShowPrevState();
}

class _ShowPrevState extends State<ShowPrev> {
  // final NetworkHelper _networkHelper = NetworkHelper();
  // void getData() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   var url = "https://rooot.azurewebsites.net/payment/get/by/date?userId=${SharedHelper.getId()}&date=$start";
  //   var response = await _networkHelper.get(url);
  //   if (response.statusCode == 200) {
  //     List<PreviousModel> tempdata = previousModelFromJson(response.body);

  //     setState(() {
  //       loading = false;
  //       previousModel = tempdata;
  //     });
  //   } else {
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  List<PreviousModel> previousModel = [];
  final translationServices = Get.find<TranslationService>();
  final appServices = Get.find<AppServices>();
  DateTime? _startTime;
  String? start;
  bool loading = false;

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
                    // color: const Color.fromRGBO(0, 154, 202, 1),
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
                        initialDate: _startTime ?? DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2080),
                      ).then((date) {
                        setState(() {
                          _startTime = date;
                          start = DateFormat('yyyy-MM-dd')
                              .format(_startTime!)
                              .toString();
                        });
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  _startTime == null ? 'nothing'.tr : (start!),
                  style: TextStyle(
                    color:
                        appServices.isDark.value ? Colors.white : Colors.black,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                        builder: (contest) => Previous(),
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
