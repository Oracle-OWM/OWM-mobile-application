import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/core/constants/service_functions.dart';
import 'package:osm_v2/app/routes/app_pages.dart';
import 'app/data/services/app_services.dart';
import 'app/data/services/theme.dart';
import 'app/data/services/translation_service.dart';
import 'app/data/services/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesFunctions.initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appServices = Get.find<AppServices>();
  final translationServices = Get.find<TranslationService>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        themeMode: appServices.isDark.value ? ThemeMode.dark : ThemeMode.light,
        // localizationsDelegates: const [
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        supportedLocales: translationServices.supportedLocales(),
        translations: Messages(),
        // locale: Get.locale ?? Locale(Get.deviceLocale.languageCode),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        title: 'OWM',
        theme: UiTheme.light,
        darkTheme: UiTheme.dark,
        initialRoute: Routes.login,
        getPages: AppPages.routes,
        defaultTransition: Transition.zoom,
      ),
    );
  }
}
