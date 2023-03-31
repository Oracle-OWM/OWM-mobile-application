import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:osm_v2/app/data/services/app_services.dart';

import '../../../data/models/user_update_model.dart';
import '../../../data/services/shared_helper.dart';
import '../../../data/services/shared_prefs.dart';

import '../../setting_page.dart';

class EditProfileUI extends StatefulWidget {
  @override
  _EditProfileUIState createState() => _EditProfileUIState();
}

class _EditProfileUIState extends State<EditProfileUI> {
  final appServices = Get.find<AppServices>();
  bool load = false;
  bool isObsecurePassword = true;
  var omail = TextEditingController();
  var opass = TextEditingController();
  var nuser = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  void postData() async {
    load = true;
    try {
      var response = await Dio().post('https://rooot.azurewebsites.net/user/create',
          data: UserUpdateModel(
            id: SharedHelper.getId(),
            name: (nuser.text.isEmpty) ? SharedHelper.getUsername() : nuser.text,
          ).toJson());
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SettingPageUI()));
      load = false;
    } catch (e) {
      load = false;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
        title: Text('edit username'.tr,
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
                  builder: (contest) => const SettingPageUI(),
                ),
              );
            }),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      return Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1))],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: appServices.profileImage.value.isEmpty
                                  ? const AssetImage('assets/girl.png')
                                  : FileImage(
                                      File(appServices.profileImage.value),
                                    ),
                            )),
                      );
                    }),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(width: 4, color: Colors.white), color: const Color.fromRGBO(34, 177, 76, 1)),
                          child: IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              }),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              buildTextField('ent mail'.tr, false, omail),
              buildTextField('ent pass'.tr, true, opass),
              buildTextField('ent new name'.tr, false, nuser),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // postData();
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      child: Text('save'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (contest) => const SettingPageUI(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(0, 154, 202, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        'cancel'.tr,
                        style: const TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String placeholder, bool isPasswordTextField, var controll) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
          style: const TextStyle(
              //color: appServices.isDark.value ? Colors.white : Colors.black,
              ),
          controller: controll,
          obscureText: isPasswordTextField ? isObsecurePassword : false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: const Icon(Icons.remove_red_eye, color: Color.fromRGBO(34, 177, 76, 1)),
                    onPressed: () {
                      setState(() {
                        isObsecurePassword = !isObsecurePassword;
                      });
                    })
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          )),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              'choose'.tr,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                    icon: const Icon(Icons.camera),
                    onPressed: () {
                      takePhoto(ImageSource.camera);
                    },
                    label: Text('camera'.tr)),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: Text('gallery'.tr),
                )
              ],
            )
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    appServices.profileImage.value = pickedFile.path;
    SharedPrefsHelper.storePic(pickedFile.path);
  }
}
