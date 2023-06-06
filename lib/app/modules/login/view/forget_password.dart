import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/core/constants/images.dart';
import 'package:osm_v2/app/core/constants/sizes.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/modules/login/controller/forget_controller.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: SizeManager.applogoWidth,
                height: SizeManager.applogoHeight,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImagesManager.forgetPasswordImage))),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              StringsManager.forgetPasswordText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: controller.appServices.isDark.value ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: TextFormField(
                style: const TextStyle(),
                controller: controller.mail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "mail".tr,
                  hintText: "maill".tr,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color.fromRGBO(34, 177, 76, 1),
                  ),
                ),
              ),
            ),
            40.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: const StadiumBorder(),
                  color: const Color.fromRGBO(0, 154, 202, 1),
                  child: Text(
                    StringsManager.resetPasswordText,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
                7.width,
                MaterialButton(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: const StadiumBorder(),
                  color: const Color.fromRGBO(0, 154, 202, 1),
                  child: Text(
                    "Back".tr,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Get.offAllNamed(Routes.login),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
