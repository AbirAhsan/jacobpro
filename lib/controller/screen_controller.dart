import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/job_controller.dart';

import '../services/page_navigation_service.dart';
import '../services/shared_data_manage_service.dart';
import 'auth_controller.dart';

class ScreenController extends GetxController with GetTickerProviderStateMixin {
  RxBool isObscureText = true.obs;

  TabController? profileTabController;
  int profileInitialIndex = 0;
  int profileCurrentIndex = 0;
  // Time Sheet
  TabController? jobListTabController;
  int jobListInitialIndex = 0;
  int jobListCurrentIndex = 0;
  // Customer
  TabController? customerTabController;
  int customerInitialIndex = 0;
  int customerCurrentIndex = 0;

  // Payment
  TabController? paymentTabController;
  int paymentInitialIndex = 0;
  int paymentCurrentIndex = 0;

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    Get.put(AuthController());

    profileTabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: profileInitialIndex,
    );

    jobListTabController = TabController(
      vsync: this,
      length: 5,
      initialIndex: jobListInitialIndex,
    );
    jobListTabController!.addListener(() {
      //  if (jobListTabController!.indexIsChanging) {
      print("Index is changing ${jobListTabController!.index} ");
      Get.put(JobController()).fetchJobCount();
      // }
    });
    customerTabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: customerInitialIndex,
    );
    paymentTabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: paymentInitialIndex,
    );
    super.onInit();
  }

  //<================================= Splash Delay
  Future<void> splashDelay() async {
    Get.put(ScreenController());
    Get.put(AuthController());
    Future.delayed(const Duration(seconds: 3)).then((value) {
      SharedDataManageService().getToken().then((token) async {
        if (token!.isNotEmpty) {
          String? status =
              await SharedDataManageService().getUserVerification();

          if (status == "1") {
            PageNavigationService.removeAllAndNavigate(
              "/DashBoardScreen",
            );
          } else {
            PageNavigationService.removeAllAndNavigate(
              "/ProfileDetailsScreen",
            );
          }
        } else {
          PageNavigationService.removeAllAndNavigate(
            "/LoginScreen",
          );
        }
      });
    });
  }

  // <=============================== Password Visibility Change
  void passwordVisibility() {
    isObscureText.value = false;
    update();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isObscureText.value = true;
      update();
    });
  }

  //<============================ Change Profile Tabbar
  Future<void> changeProfileTabbar(int index) async {
    print("Change Profile Tab 1st: $index");
    profileTabController!.animateTo(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
    print("Change Profile Tab 2nd: ${profileTabController!.index}");
    // profileTabController!.index = index >= 0 && index < 4 ? index : 0;
    profileCurrentIndex = index >= 0 && index < 4 ? index : 0;

    print("Change Profile Tab 3rd: $profileCurrentIndex");
    update();
  }

  //<============================ Change Job Tabbar
  void changeJobTabbar(int index) {
    jobListTabController!.index = index >= 0 && index < 5 ? index : 0;
    jobListCurrentIndex = index >= 0 && index < 5 ? index : 0;
    update();
  }

  //<============================ Change Customer  Tabbar
  void changeCustomerTabbar(int index) {
    customerTabController!.index = index >= 0 && index < 4 ? index : 0;
    customerCurrentIndex = index >= 0 && index < 4 ? index : 0;
    update();
  }

  //<============================ Change Customer  Tabbar
  void changePaymentTabbar(int index) {
    paymentTabController!.index = index >= 0 && index < 4 ? index : 0;
    paymentCurrentIndex = index >= 0 && index < 4 ? index : 0;
    update();
  }
}
