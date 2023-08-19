import 'package:get/get.dart' show GetPage;
import 'package:osm_v2/app/modules/about_us/binding/about_us_binding.dart';
import 'package:osm_v2/app/modules/about_us/view/about_us.dart';
import 'package:osm_v2/app/modules/payment/view/bill_tabs.dart';
import 'package:osm_v2/app/modules/contacts/binding/contacts_binding.dart';
import 'package:osm_v2/app/modules/contacts/view/contact.dart';
import 'package:osm_v2/app/modules/device/bindings/device_binding.dart';
import 'package:osm_v2/app/modules/device/view/device_view.dart';
import 'package:osm_v2/app/modules/home/binding/home_binding.dart';
import 'package:osm_v2/app/modules/home/view/home_view.dart';
import 'package:osm_v2/app/modules/login/view/forget_password.dart';
import 'package:osm_v2/app/modules/payment/bindings/payment_binding.dart';
import 'package:osm_v2/app/modules/payment/view/payment_view.dart';
import 'package:osm_v2/app/modules/questions/bindings/questions_binding.dart';
import 'package:osm_v2/app/modules/questions/view/question.dart';
import 'package:osm_v2/app/modules/settings/bindings/settings_binding.dart';
import 'package:osm_v2/app/modules/settings/view/setting_page.dart';
import 'package:osm_v2/app/modules/splash/bindings/splash_binding.dart';
import 'package:osm_v2/app/modules/splash/view/splash.dart';

import '../modules/device/view/device_leakage_detection.dart';
import '../modules/login/bindings/login_bindings.dart';
import '../modules/login/view/login.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.forgetPasswordView,
      page: () => const ForgetPasswordView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.deviceView,
      page: () => const DeviceView(),
      binding: DeviceBinding(),
    ),
    GetPage(
      name: Routes.deviceAndLeakageDetection,
      page: () => const DeviceAndLeakageDetection(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.paymentView,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.questions,
      page: () => const Questions(),
      binding: QuestionBinding(),
    ),
    GetPage(
      name: Routes.contacts,
      page: () => const Contact(),
      binding: ContactsBinding(),
    ),
    GetPage(
      name: Routes.aboutUs,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.billTabs,
      page: () => const BillTabs(),
      binding: PaymentBinding(),
    ),
  ];
}
