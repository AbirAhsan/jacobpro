import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'generated/codegen_loader.g.dart';
import 'routes.dart';
import 'view/variables/colors_variable.dart';
import 'view/variables/text_style.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
//  await AppConfig.getVersionStatus();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    EasyLocalization(
      path: "assets/langs",
      saveLocale: true,
      supportedLocales: const [
        Locale("en", "EN"),
        //    Locale("bn", "BD"),
      ],
      fallbackLocale: const Locale('en', 'EN'),
      startLocale: const Locale('en', 'EN'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = CustomColors.darkGrey
    ..backgroundColor = CustomColors.black
    ..indicatorColor = CustomColors.white
    ..textColor = CustomColors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Jacob Pro',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      //     localizationsDelegates: [
      //       AppLocalizations.delegate,
      //       GlobalMaterialLocalizations.delegate,
      //  GlobalWidgetsLocalizations.delegate,
      //  GlobalCupertinoLocalizations.delegate,],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Arcon",
        appBarTheme: const AppBarTheme(
          backgroundColor: CustomColors.white,
          titleTextStyle: CustomTextStyle.titleBoldStyleBlack,
        ),
        scaffoldBackgroundColor: CustomColors.white,
      ),
      initialRoute: "/",
      builder: EasyLoading.init(),
      getPages: ScreenRoutes.pageList,
    );
  }
}


// flutter pub run easy_localization:generate --source-dir ./assets/langs
// flutter pub run easy_localization:generate --source-dir ./assets/langs -f keys -o locale_keys.g.dart