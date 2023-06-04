import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? prefs;

/*----------------------------------------------------------------------------*/
/*----------------------------  Initialize Prefs  ----------------------------*/
/*----------------------------------------------------------------------------*/
  static initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

/*----------------------------------------------------------------------------*/
/*--------------------------------  App Theme  -------------------------------*/
/*----------------------------------------------------------------------------*/
  static Future<bool> checkTheme() async {
    final shared = await SharedPreferences.getInstance();
    return shared.containsKey("theme");
  }

  static Future saveTheme(bool themeId) async {
    await initPrefs();
    prefs!.setBool('theme', themeId);
  }

  static Future<bool> getTheme() async {
    await initPrefs();
    bool? themeIdSaved = prefs!.getBool('theme');
    return themeIdSaved!;
  }

/*----------------------------------------------------------------------------*/
/*--------------------------------  Language  --------------------------------*/
/*----------------------------------------------------------------------------*/
  static storeLanguage(String language) async {
    await initPrefs();
    await prefs!.setString("lang", language);
  }

  static Future<String> getLanguage()  async {
    await initPrefs();
    return Future.value(prefs!.getString("lang"));
  }

  static removeLanguage() async {
    await initPrefs();
    prefs!.remove("lang");
  }

  static storeisLoggedin(bool log) async {
    await initPrefs();
    await prefs!.setBool("Log", log);
  }

  static Future<bool> getisLoggedin() async {
    await initPrefs();
    return Future.value(prefs!.getBool("Log"));
  }

  static removeisLoggedin() async {
    await initPrefs();
    prefs!.remove("Log");
  }

  static storePic(String path) async {
    await initPrefs();
    await prefs!.setString("path", path);
  }

  static Future<String> getPic() async {
    await initPrefs();
    return Future.value(prefs!.getString("path"));
  }

  static removePic() async {
    await initPrefs();
    prefs!.remove("path");
  }
}
