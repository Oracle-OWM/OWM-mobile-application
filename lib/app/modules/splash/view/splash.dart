import 'package:flutter/material.dart';
import 'package:osm_v2/app/core/constants/images.dart';
import 'package:osm_v2/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset(
                ImagesManager.appLogo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
