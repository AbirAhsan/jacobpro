import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/page_navigation_service.dart';
import '../services/shared_data_manage_service.dart';

class ScreenController extends GetxController with GetTickerProviderStateMixin {
  RxBool isObscureText = true.obs;

  TabController? profileTabController;
  int profileInitialIndex = 0;
  int profileCurrentIndex = 0;

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    profileTabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: profileInitialIndex,
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
}
