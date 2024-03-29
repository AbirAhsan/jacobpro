import 'package:get/get.dart';

import 'view/auth/forget_pass/forget_pass_find_account.dart';
import 'view/auth/forget_pass/forget_pass_otp.dart';
import 'view/auth/forget_pass/forget_pass_reset_password.dart';
import 'view/auth/forget_pass/forget_pass_selection.dart';
import 'view/auth/login_screen.dart';
import 'view/auth/registration_phone_verification.dart';
import 'view/auth/registration_screen.dart';
import 'view/auth/registration_email_verification.dart';
import 'view/dashboard/dashboard_screen.dart';
import 'view/job_list/job_details_screen.dart';
import 'view/job_list/job_list_screen.dart';
import 'view/my_apprentice/my_apprentice_screen.dart';
import 'view/my_customer/add_new_customer_screen.dart';
import 'view/my_customer/customer_details_screen.dart';
import 'view/my_customer/estimate/add_item_form_screen.dart';
import 'view/my_customer/estimate/estimate_details_screen.dart';
import 'view/my_customer/my_customer_screen.dart';
import 'view/notification/notification_screen.dart';
import 'view/on going job/on_going_job_screen.dart';
import 'view/payment/payment_screen.dart';
import 'view/profile/profile_screen.dart';
import 'view/schedule/schedule_screen.dart';
import 'view/splash/splash_screen.dart';
import 'view/time_sheet/time_sheet_main_screen.dart';

class ScreenRoutes {
  static List<GetPage<dynamic>>? pageList = [
    GetPage(name: '/', page: () => const SplashScreen()),
    //
    GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
    GetPage(
        name: '/RegistrationScreen', page: () => const RegistrationScreen()),
    GetPage(
        name: '/RegistrationEmailOtpVerification',
        page: () => const RegistrationEmailOtpVerification()),
    GetPage(
        name: '/RegistrationPhoneOtpVerification',
        page: () => const RegistrationPhoneOtpVerification()),
    GetPage(
        name: '/ForgetPassFindAccount',
        page: () => const ForgetPassFindAccount()),
    GetPage(
        name: '/ForgetPassMakeSelectionScreen',
        page: () => const ForgetPassMakeSelectionScreen()),
    GetPage(name: '/ForgetPassOTP', page: () => const ForgetPassOTP()),
    GetPage(
        name: '/ForgetResetPassScreen',
        page: () => const ForgetResetPassScreen()),

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
    GetPage(
        name: '/EstimateDetailsScreen',
        page: () => const EstimateDetailsScreen()),
    GetPage(name: '/AddItemFormScreen', page: () => const AddItemFormScreen()),
    GetPage(name: '/PaymentScreen', page: () => const PaymentScreen()),
    GetPage(
        name: '/MyApprenticeScreen', page: () => const MyApprenticeScreen()),
  ];
}
