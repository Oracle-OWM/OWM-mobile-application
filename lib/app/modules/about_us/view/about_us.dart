import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/modules/about_us/controller/about_us_controller.dart';
import 'package:osm_v2/app/modules/about_us/widgets/everyone_widget.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
        title: Text(
          "About us".tr,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.offAllNamed(Routes.home),
        ),
      ),
      body: ListView(
        children: [
          8.height,
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Oracle Team",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(0, 154, 202, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const EveryoneWidget(
              img: StringsManager.noorImg,
              name: StringsManager.noorName,
              job: StringsManager.noorJob),
          const EveryoneWidget(
              img: StringsManager.rawanImg,
              name: StringsManager.rawanName,
              job: StringsManager.rawanJob),
          const EveryoneWidget(
              img: StringsManager.asmaaImg,
              name: StringsManager.asmaaName,
              job: StringsManager.asmaaJob),
          const EveryoneWidget(
              img: StringsManager.moutazImg,
              name: StringsManager.moutazName,
              job: StringsManager.moutazJob),
        ],
      ),
    );
  }
}
