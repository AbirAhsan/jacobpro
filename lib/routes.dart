import 'package:get/get.dart';

import 'view/auth/login_screen.dart';
import 'view/auth/registration_screen.dart';
import 'view/auth/registration_verification.dart';
import 'view/dashboard/dashboard_screen.dart';
import 'view/my_customer/add_new_customer_screen.dart';
import 'view/my_customer/my_customer_screen.dart';
import 'view/notification/notification_screen.dart';
import 'view/profile/profile_screen.dart';
import 'view/splash/splash_screen.dart';

class ScreenRoutes {
  static List<GetPage<dynamic>>? pageList = [
    GetPage(name: '/', page: () => const SplashScreen()),
    //
    GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
    GetPage(
        name: '/RegistrationScreen', page: () => const RegistrationScreen()),
    GetPage(
        name: '/RegistrationOtpVerification',
        page: () => const RegistrationOtpVerification()),

    //
    GetPage(
        name: '/ProfileDetailsScreen',
        page: () => const ProfileDetailsScreen()),
    GetPage(
        name: '/NotificationScreen', page: () => const NotificationScreen()),

    GetPage(name: '/DashBoardScreen', page: () => const DashBoardScreen()),
    GetPage(name: '/MyCustomersScreen', page: () => const MyCustomersScreen()),
    GetPage(
        name: '/AddNewCustomerScreen',
        page: () => const AddNewCustomerScreen()),
  ];
}
