import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/modules/about_us/controller/about_us_controller.dart';

class EveryoneWidget extends GetView<AboutUsController> {
  const EveryoneWidget(
      {super.key, required this.img, required this.name, required this.job});
  final String img;
  final String name;
  final String job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 90,
                height: 90,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    img,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(0, 154, 202, 1),
                  ),
                ),
                8.height,
                Text(
                  job,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: controller.appServices.isDark.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
