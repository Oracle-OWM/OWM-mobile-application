import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/modules/home/controllers/home_controller.dart';

class PageCard extends GetView<HomeController> {
  final String? img;
  final String? tit;
  final GestureTapCallback? onTapp;
  const PageCard({Key? key, this.img, this.tit, this.onTapp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SizedBox(
          height: 180,
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      img!,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: ListTile(
                  onTap: onTapp,
                ),
              ),
              ListTile(
                onTap: onTapp,
                title: Text(tit!,
                    style: TextStyle(
                      color: controller.appServices.isDark.value
                          ? Colors.white
                          : Colors.black,
                    )),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined,
                    color: Color.fromRGBO(0, 154, 202, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
