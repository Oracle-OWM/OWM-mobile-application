import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/colors.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/core/constants/images.dart';
import 'package:osm_v2/app/core/constants/padding.dart';
import 'package:osm_v2/app/core/constants/sizes.dart';
import 'package:osm_v2/app/core/constants/strings.dart';
import 'package:osm_v2/app/modules/login/controller/login_controller.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagesManager.appLogo,
                width: SizeManager.applogoWidth,
                height: SizeManager.applogoHeight,
              ),
              Center(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: PaddingManager.p10,
                            right: PaddingManager.p20,
                            left: PaddingManager.p20),
                        child: TextFormField(
                          style: TextStyle(
                            color: controller.appServices.isDark.value
                                ? ColorsManager.white
                                : ColorsManager.black,
                          ),
                          controller: controller.email,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: StringsManager.userLoginText,
                            hintText: StringsManager.userLoginHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: ColorsManager.userIconColor,
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "please user".tr;
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String? value) {
                            controller.mail = value!;
                          },
                        ),
                      ),
                      10.height,
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            style: TextStyle(
                              color: controller.appServices.isDark.value
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            obscureText: controller.check.value,
                            controller: controller.pass,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Password'.tr,
                              hintText: "pass validate empty".tr,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color.fromRGBO(34, 177, 76, 1)),
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.remove_red_eye,
                                      color: Color.fromRGBO(34, 177, 76, 1)),
                                  onPressed: () {
                                    // print(controller.check);
                                    controller.check.value =
                                        !controller.check.value;
                                  }),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "please password".tr;
                              } else if (value.length < 6) {
                                return "6 digit".tr;
                              } else {
                                return null;
                              }
                            },
                            onSaved: (String? value) =>
                                controller.passwd = value!,
                          ),
                        ),
                      ),
                      10.height,
                    ],
                  ),
                ),
              ),
              30.height,
              MaterialButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: const StadiumBorder(),
                color: const Color.fromRGBO(0, 154, 202, 1),
                child: controller.load
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Login'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    controller.formKey.currentState!.save();
                    controller.login(
                      username: controller.mail,
                      password: controller.passwd,
                    );
                  }
                },
              ),
              7.height,
              TextButton(
                child: Text(
                  "Forgot Password?".tr,
                  style: TextStyle(
                    color: controller.appServices.isDark.value
                        ? Colors.white
                        : Colors.black,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => Get.toNamed(Routes.forgetPasswordView),
              )
            ],
          ),
        ),
      ),
    );
  }
}
