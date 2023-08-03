import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/data/services/app_services.dart';
import 'package:osm_v2/app/data/services/translation_service.dart';

class SettingsController extends GetxController {
  bool valNotify2 = false;
  bool valNotify3 = false;
  final appServices = Get.find<AppServices>();

  final translationServices = Get.find<TranslationService>();

  onChangeFunction1(bool newValue1) {
    appServices.changeTheme(newValue1);
  }

  onChangeFunction2(bool newValue2) {
    valNotify2 = newValue2;
  }

  onChangeFunction3(bool newValue3) {
    valNotify3 = newValue3;
  }

  showLanguageDialog(context, int type) {
    final List titles = ['ar'.tr, 'english'.tr];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor:
            (appServices.isDark.value) ? Colors.grey.shade700 : Colors.white,
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
                  style: Get.textTheme.titleLarge!.copyWith(
                      color: (appServices.isDark.value)
                          ? Colors.white
                          : Colors.black),
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
                        style: Get.textTheme.bodyLarge!
                            .copyWith(color: Colors.grey),
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
      ),
    );
  }
}
