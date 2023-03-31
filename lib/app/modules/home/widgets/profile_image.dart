import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';

class ProfileImage extends GetView<HomeController> {
  const ProfileImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: controller.profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: controller.loginData.user.image == null ? const AssetImage('assets/man.jpg') : NetworkImage(controller.loginData.user.image),
    );
    ;
  }
}
