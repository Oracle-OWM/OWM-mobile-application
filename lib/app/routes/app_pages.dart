import 'package:get/get.dart' show GetPage;
import 'package:osm_v2/app/modules/device/bindings/device_binding.dart';
import 'package:osm_v2/app/modules/device/view/device_view.dart';
import 'package:osm_v2/app/modules/home/binding/home_binding.dart';
import 'package:osm_v2/app/modules/home/view/home_view.dart';
import 'package:osm_v2/app/modules/login/view/forget_password.dart';
import 'package:osm_v2/app/modules/payment/bindings/payment_binding.dart';
import 'package:osm_v2/app/modules/payment/view/payment_view.dart';
import 'package:osm_v2/app/modules/splash/bindings/splash_binding.dart';
import 'package:osm_v2/app/modules/splash/view/splash.dart';

import '../modules/device_leakage_detection/device_leakage_detection.dart';
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
  ];
}
