import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/extensions.dart';
import 'package:osm_v2/app/core/constants/page_cards_data.dart';
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';
import 'package:osm_v2/app/routes/app_pages.dart';

import 'card.dart';

class PageContent extends GetView<HomeController> {
  const PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          10.height,
          Text(
            controller.appServices.loginData!.user!.firstName!,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: controller.appServices.isDark.value ? Colors.white : Colors.black,
            ),
          ),
          InkWell(
            onTap: controller.scanBarCode,
            child: const CircleAvatar(
              radius: 30,
              child: Icon(Icons.qr_code),
            ),
          ),
          16.height,
          const Divider(),
          for (int i = 0; i < PageCardData.map.length; i++)
            PageCard(
              img: PageCardData.map[i]['image'],
              tit: PageCardData.map[i]['title'],
              onTapp: () => PageCardData.map[i]['onTapp'].call(controller.appServices),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListTile(
                  onTap: () => Get.offAllNamed(Routes.login),
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Color.fromRGBO(0, 154, 202, 1),
                  ),
                  title: Text(
                    "Logout".tr,
                    style: TextStyle(
                      color: controller.appServices.isDark.value ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right_outlined, color: Color.fromRGBO(0, 154, 202, 1)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
