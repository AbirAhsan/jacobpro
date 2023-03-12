import 'package:get/get.dart';

import '../services/page_navigation_service.dart';
import '../services/shared_data_manage_service.dart';

class ScreenController extends GetxController {
  RxBool isObscureText = true.obs;

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    super.onInit();
  }

  //<================================= Splash Delay
  Future<void> splashDelay() async {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      SharedDataManageService().getToken().then((token) async {
        if (token!.isNotEmpty) {
          PageNavigationService.removeAllAndNavigate(
            "/LoginScreen",
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
}
