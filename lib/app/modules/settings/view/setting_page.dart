import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/modules/home/view/home_view.dart';
import 'package:osm_v2/app/modules/settings/controller/settings_controller.dart';
import 'package:osm_v2/app/modules/settings/widgets/account_option_widget.dart';
import 'package:osm_v2/app/modules/settings/widgets/notificaton_widget.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
          title: Text(
            "Settings".tr,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const Icon(
                    Icons.settings_display,
                    color: Color.fromRGBO(34, 177, 76, 1),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "general settings".tr,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: controller.appServices.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                ],
              ),
              const Divider(height: 30, thickness: 1),
              10.height,
              AccountOptionWidget(
                title: 'Languages'.tr,
                onTapp: () => controller.showLanguageDialog(context, 2),
              ),
              30.height,
              NotificationWidget(
                title: 'dark mode'.tr,
                value: controller.appServices.isDark.value,
                onChangeMethod: controller.onChangeFunction1,
              ),
              40.height,
              Row(
                children: [
                  const Icon(Icons.person,
                      color: Color.fromRGBO(34, 177, 76, 1)),
                  const SizedBox(width: 10),
                  Text(
                    'user settings'.tr,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: controller.appServices.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                ],
              ),
              const Divider(height: 20, thickness: 1),
              10.height,
              AccountOptionWidget(
                title: 'edit username'.tr,
                onTapp: () {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (contest) => const EditProfileUI(),
                  //   ),
                  // );
                },
              ),
              30.height,
              AccountOptionWidget(
                title: 'edit pass'.tr,
                onTapp: () {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (contest) => const EditPasswordView(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
