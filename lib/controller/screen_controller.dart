import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/page_navigation_service.dart';
import '../services/shared_data_manage_service.dart';

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

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    profileTabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: profileInitialIndex,
    );
    jobListTabController = TabController(
      vsync: this,
      length: 6,
      initialIndex: jobListInitialIndex,
    );
    customerTabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: customerInitialIndex,
    );
    super.onInit();
  }

  //<================================= Splash Delay
  Future<void> splashDelay() async {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      SharedDataManageService().getToken().then((token) async {
        if (token!.isNotEmpty) {
          PageNavigationService.removeAllAndNavigate(
            "/DashBoardScreen",
          );
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
  void changeProfileTabbar(int index) {
    profileTabController!.index = index >= 0 && index < 3 ? index : 0;
    profileCurrentIndex = index >= 0 && index < 3 ? index : 0;
    update();
  }

  //<============================ Change Job Tabbar
  void changeJobTabbar(int index) {
    jobListTabController!.index = index >= 0 && index < 6 ? index : 0;
    jobListCurrentIndex = index >= 0 && index < 6 ? index : 0;
    update();
  }

  //<============================ Change Customer  Tabbar
  void changeCustomerTabbar(int index) {
    customerTabController!.index = index >= 0 && index < 4 ? index : 0;
    customerCurrentIndex = index >= 0 && index < 4 ? index : 0;
    update();
  }
}
