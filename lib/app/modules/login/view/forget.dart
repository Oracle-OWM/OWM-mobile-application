import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/modules/login/controller/forget_controller.dart';
import 'package:osm_v2/app/modules/login/view/login.dart';

class Forget extends GetView<ForgetController> {
  const Forget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: 400,
            height: 350,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/forget.png"))),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "forget".tr,
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
        const SizedBox(height: 40),
        MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: const StadiumBorder(),
          color: const Color.fromRGBO(0, 154, 202, 1),
          child: Text(
            "reset".tr,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 7),
        TextButton(
            child: Text("go".tr,
                style: TextStyle(
                  fontSize: 17,
                  color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                )),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (contest) =>  const Login(),
                ),
              );
            })
      ]),
    ));
  }
}
