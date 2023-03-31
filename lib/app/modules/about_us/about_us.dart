import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/modules/home/view/home_view.dart';
import '../../data/services/app_services.dart';

class About extends StatelessWidget {
  final appServices = Get.find<AppServices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
        title: Text("About us".tr,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (contest) => const HomeView(),
                ),
              );
            }),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Oracle Team",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(0, 154, 202, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          everyone("assets/Noor.jpg", "Noor El Deen Magdy", "Software Engineer"),
          everyone("assets/Rawan.png", "Rawan Mahmoud", "Pharmaceutical Analyst"),
          everyone("assets/Asmaa.png", "Asmaa Latif", "Embedded Systems"),
          everyone("assets/Moutaz.png", "Moutaz Bellah Hosni", "Business Analyst"),
        ],
      ),
    );
  }

  Widget everyone(String img, String name, String job) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                  style: const TextStyle(fontSize: 18, color: Color.fromRGBO(0, 154, 202, 1)),
                ),
                const SizedBox(height: 8),
                Text(
                  job,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: appServices.isDark.value ? Colors.white : Colors.black,
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
