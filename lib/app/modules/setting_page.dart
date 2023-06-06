import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/modules/home/view/home_view.dart';
import '../data/services/translation_service.dart';


class SettingPageUI extends StatefulWidget {
  const SettingPageUI({Key? key}) : super(key: key);

  @override
  SettingPageUIState createState() => SettingPageUIState();
}

class SettingPageUIState extends State<SettingPageUI> {
  bool valNotify2 = false;
  bool valNotify3 = false;
  final appServices = Get.find<AppServices>();

  final translationServices = Get.find<TranslationService>();

  onChangeFunction1(bool newValue1) {
    appServices.changeTheme(newValue1);
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  showLanguageDialog(context, int type) {
    final List titles = ['ar'.tr, 'english'.tr];
    final appServices = Get.find<AppServices>();
    // final translationServices = Get.find<TranslationService>();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, c) {
        return Dialog(
          backgroundColor: (appServices.isDark.value) ? Colors.grey.shade700 : Colors.white,
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'lang'.tr,
                    style: Get.textTheme.titleLarge!.copyWith(color: (appServices.isDark.value) ? Colors.white : Colors.black),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    TranslationService.languages.length,
                    (index) {
                      var lang = TranslationService.languages.elementAt(index);
                      return RadioListTile<String>(
                        controlAffinity: ListTileControlAffinity.trailing,
                        groupValue: Get.locale.toString(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        activeColor: const Color.fromRGBO(34, 177, 76, 1),
                        title: Text(
                          titles[index],
                          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.grey),
                        ),
                        value: lang,
                        onChanged: (val) {
                          // translationServices.updateLocale(val);
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

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
          title: Text("Settings".tr,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          //automaticallyImplyLeading: true,
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
                    Text("general settings".tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ))
                  ],
                ),
                const Divider(height: 30, thickness: 1),
                const SizedBox(height: 10),
                buildAccountOption(context, "Languages".tr, () {
                  showLanguageDialog(context, 2);
                }),
                const SizedBox(height: 30),
                buildNotificationOption('dark mode'.tr, appServices.isDark.value, onChangeFunction1),
                const SizedBox(height: 40),
                Row(
                  children: [
                    const Icon(Icons.person, color: Color.fromRGBO(34, 177, 76, 1)),
                    const SizedBox(width: 10),
                    Text('user settings'.tr,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: appServices.isDark.value ? Colors.white : Colors.black,
                        ))
                  ],
                ),
                const Divider(height: 20, thickness: 1),
                const SizedBox(height: 10),
                buildAccountOption(context, 'edit username'.tr, () {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (contest) => const EditProfileUI(),
                  //   ),
                  // );
                }),
                const SizedBox(height: 30),
                buildAccountOption(context, 'edit pass'.tr, () {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (contest) => const EditPasswordView(),
                  //   ),
                  // );
                }),
              ],
            )));
  }
}

Padding buildNotificationOption(String title, bool value, Function onChangeMethod) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[600])),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeColor: const Color.fromRGBO(34, 177, 76, 1),
            trackColor: Colors.grey,
            value: value,
            onChanged: (bool newValue) {
              onChangeMethod(newValue);
            },
          ),
        )
      ],
    ),
  );
}

GestureDetector buildAccountOption(BuildContext context, String title, GestureTapCallback? onTapp) {
  return GestureDetector(
    onTap: onTapp,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[600])),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey)
        ],
      ),
    ),
  );
}
