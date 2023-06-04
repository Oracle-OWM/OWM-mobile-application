import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';
import 'package:osm_v2/app/modules/home/widgets/profile_image.dart';

import 'cover_image.dart';

class TopPart extends GetView<HomeController> {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottom = controller.profileHeight / 2;
    final top = controller.coverHeight - controller.profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: const CoverImage(),
        ),
        Positioned(
          top: top,
          child: const ProfileImage(),
        ),
      ],
    );
  }
}
