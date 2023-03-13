import 'package:get/get.dart';

import 'view/auth/login_screen.dart';
import 'view/auth/registration_screen.dart';
import 'view/splash/splash_screen.dart';

class ScreenRoutes {
  static List<GetPage<dynamic>>? pageList = [
    GetPage(name: '/', page: () => const SplashScreen()),
    //
    GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
    GetPage(
        name: '/RegistrationScreen', page: () => const RegistrationScreen()),

    //
    // GetPage(name: '/', page: () => const MainScreen()),
  ];
}
