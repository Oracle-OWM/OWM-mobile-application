import 'package:flutter/material.dart';
import '../data/services/app_services.dart';
import 'package:get/get.dart';
import 'home/view/home_view.dart';

class Questions extends StatelessWidget {
  final appServices = Get.find<AppServices>();

  Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (contest) => const HomeView(),
                ),
              );
            }),
        title: Text("FAQ".tr,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "How does head-end system benefit from the collected data?"
                          .tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 154, 202, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "* It can calculate your bill monthly.\n* Tells you how much energy do your appliances consume.\n* Helps you save your energy consumption.\n* Provides you with the needed energy."
                            .tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "How could this application help you?".tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 154, 202, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "With this application you can:\n* Show your consumption.\n* Pay your bill.\n* Contact us if you have any problem.\n* Show your old bills.\n* Show each appliance's consumption.\n* Edit your own data."
                            .tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        //textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "How could you show  your consumption?".tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 154, 202, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "You should only select the month and week and then press the button \"Show Consumption\"."
                            .tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "How could you contact us?".tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 154, 202, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "You could contact us by calling us, sending SMS or sending a mail to tell us about your problem."
                            .tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    title: Text(
                      "How could you show your old bills?".tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 154, 202, 1),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "All you have to do is to select the month you want and then press the button \"Show Bill\"."
                            .tr,
                        style: TextStyle(
                          fontSize: 17,
                          color: appServices.isDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
