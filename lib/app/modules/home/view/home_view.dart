import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';
import 'package:osm_v2/app/modules/home/widgets/page_content.dart';
import 'package:osm_v2/app/modules/home/widgets/top_part.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const TopPart(),
            controller.dataReturned.value
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Center(
                          child: Text(
                              'Trying to get the Device data please wait, if this takes long check your connection'),
                        ),
                      ],
                    ),
                  )
                : const PageContent(),
          ],
        ),
      ),
    );
  }
}
