import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static var prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static set(String access) async {
    await prefs.setString('token', access);
  }

  static String get() {
    final String action = prefs.getString('token');
    return action;
  }

  static setUsername(String access) async {
    await prefs.setString('name', access);
  }

  static String getUsername() {
    final String action = prefs.getString('name');
    return action;
  }

  static setEmail(String access) async {
    await prefs.setString('email', access);
  }

  static String getEmail() {
    final String action = prefs.getString('email');
    return action;
  }

  static setPass(String access) async {
    await prefs.setString('pass', access);
  }

  static String getPass() {
    final String action = prefs.getString('pass');
    return action;
  }

  static setId(int access) async {
    await prefs.setInt('id', access);
  }

  static int getId() {
    final int action = prefs.getInt('id');
    return action;
  }

  static setState(String access) async {
    await prefs.setString('state', access);
  }

  static String getState() {
    final String action = prefs.getString('state');
    return action;
  }

  static setPhone(String access) async {
    await prefs.setString('phone', access);
  }

  static String getPhone() {
    final String action = prefs.getString('phone');
    return action;
  }

  static setAddress(String access) async {
    await prefs.setString('address', access);
  }

  static String getAddress() {
    final String action = prefs.getString('address');
    return action;
  }
}
