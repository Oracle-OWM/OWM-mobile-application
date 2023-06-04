import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';

class CoverImage extends GetView<HomeController> {
  const CoverImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Image.asset(
        'assets/cover.jpg',
        width: double.infinity,
        height: controller.coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
