import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osm_v2/app/routes/app_pages.dart';
import 'app/data/services/app_services.dart';
import 'app/data/services/shared_helper.dart';
import 'app/data/services/theme.dart';
import 'app/data/services/translation_service.dart';
import 'app/data/services/translations.dart';

Future<void> initServices() async {
  Get.log('starting services ...');

  await Get.putAsync<AppServices>(() async => AppServices());
  await SharedHelper.init();
  // await DioHelper.init();
  await Get.putAsync<TranslationService>(() async => TranslationService());
  Get.log('All Services Started ...');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
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
        initialRoute: Routes.splash,
        getPages: AppPages.routes,
        defaultTransition: Transition.zoom,
      ),
    );
  }
}
