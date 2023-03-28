import 'package:get/get.dart';

import 'view/auth/forget_pass/forget_pass_find_account.dart';
import 'view/auth/forget_pass/forget_pass_otp.dart';
import 'view/auth/forget_pass/forget_pass_selection.dart';
import 'view/auth/login_screen.dart';
import 'view/auth/registration_screen.dart';
import 'view/auth/registration_verification.dart';
import 'view/dashboard/dashboard_screen.dart';
import 'view/job_list/job_list_screen.dart';
import 'view/my_customer/add_new_customer_screen.dart';
import 'view/my_customer/customer_details_screen.dart';
import 'view/my_customer/my_customer_screen.dart';
import 'view/notification/notification_screen.dart';
import 'view/on going job/on_going_job_screen.dart';
import 'view/profile/profile_screen.dart';
import 'view/schedule/schedule_screen.dart';
import 'view/splash/splash_screen.dart';
import 'view/time_sheet/job_details_screen.dart';
import 'view/time_sheet/time_sheet_main_screen.dart';

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
    GetPage(
        name: '/ForgetPassFindAccount',
        page: () => const ForgetPassFindAccount()),
    GetPage(
        name: '/ForgetPassMakeSelectionScreen',
        page: () => const ForgetPassMakeSelectionScreen()),
    GetPage(name: '/ForgetPassOTP', page: () => const ForgetPassOTP()),

    //
    GetPage(
        name: '/ProfileDetailsScreen',
        page: () => const ProfileDetailsScreen()),
    GetPage(
        name: '/NotificationScreen', page: () => const NotificationScreen()),

    GetPage(name: '/DashBoardScreen', page: () => const DashBoardScreen()),
    //
    GetPage(name: '/OnGoingJobScreen', page: () => const OnGoingJobScreen()),
    //
    GetPage(name: '/JobListScreen', page: () => const JobListScreen()),
    GetPage(name: '/JobDetailsScreen', page: () => const JobDetailsScreen()),
    //
    GetPage(name: '/ScheduleScreen', page: () => const ScheduleScreen()),
    GetPage(
        name: '/TimeSheetMainScreen', page: () => const TimeSheetMainScreen()),

    GetPage(name: '/MyCustomersScreen', page: () => const MyCustomersScreen()),
    GetPage(
        name: '/CustomerDetailsScreen',
        page: () => const CustomerDetailsScreen()),
    GetPage(
        name: '/AddNewCustomerScreen',
        page: () => const AddNewCustomerScreen()),
  ];
}
