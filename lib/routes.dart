import 'package:get/get.dart';

import 'view/auth/login_screen.dart';
import 'view/splash/splash_screen.dart';

class ScreenRoutes {
  static List<GetPage<dynamic>>? pageList = [
    GetPage(name: '/', page: () => const SplashScreen()),
    //
    GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
    // GetPage(name: '/', page: () => const SplashScreen()),

    //
    // GetPage(name: '/', page: () => const MainScreen()),
  ];
}
