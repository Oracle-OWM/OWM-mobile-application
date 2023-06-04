import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/data/services/dio_helper.dart';
import 'package:osm_v2/app/modules/login/controller/login_controller.dart';

import 'forget.dart';

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
                'assets/logo.png',
                width: 230,
                height: 230,
              ),
              Center(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                        child: TextFormField(
                          style: TextStyle(
                            color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                          ),
                          controller: controller.email,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "User".tr,
                            hintText: "user validate empty".tr,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color.fromRGBO(34, 177, 76, 1),
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
                      const SizedBox(height: 10),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: TextFormField(
                            style: TextStyle(
                              color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                            ),
                            obscureText: controller.check.value,
                            controller: controller.pass,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Password'.tr,
                              hintText: "pass validate empty".tr,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock, color: Color.fromRGBO(34, 177, 76, 1)),
                              suffixIcon: IconButton(
                                  icon: const Icon(Icons.remove_red_eye, color: Color.fromRGBO(34, 177, 76, 1)),
                                  onPressed: () {
                                    // print(controller.check);
                                    controller.check.value = !controller.check.value;
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
                            onSaved: (String? value) {
                              controller.passwd = value!;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: TextFormField(
                          style: TextStyle(
                            color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                          ),
                          controller: controller.ip,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'IP'.tr,
                            hintText: "Enter Server's IP".tr,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.electrical_services_rounded, color: Color.fromRGBO(34, 177, 76, 1)),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "please Enter IP".tr;
                            } else if (value.length < 6) {
                              return "6 digit".tr;
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String? value) {
                            controller.serverIP = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                    // print('object');
                    DioHelper.init(path: controller.serverIP);
                    controller.login(
                      username: controller.mail,
                      password: controller.passwd,
                    );
                  }
                },
              ),
              const SizedBox(height: 7),
              TextButton(
                child: Text("Forgot Password?".tr,
                    style: TextStyle(
                      color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                      fontSize: 17,
                    )),
                onPressed: () => Get.offAll(const Forget()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
