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
  TabController? timeSheetTabController;
  int timeSheetInitialIndex = 0;
  int timeSheetCurrentIndex = 0;

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    profileTabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: profileInitialIndex,
    );
    timeSheetTabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: timeSheetInitialIndex,
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

  //<============================ Change Time Sheet Tabbar
  void changeTimeSheetTabbar(int index) {
    timeSheetTabController!.index = index >= 0 && index < 4 ? index : 0;
    timeSheetCurrentIndex = index >= 0 && index < 4 ? index : 0;
    update();
  }
}
