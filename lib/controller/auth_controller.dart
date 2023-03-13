import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_service/auth_api_service.dart';
import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';
import '../services/page_navigation_service.dart';
import '../services/shared_data_manage_service.dart';
import '../services/validator_service.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController? loginUserName = TextEditingController();
  TextEditingController? loginpassword = TextEditingController();

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    initializeTextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //<============================== Login Request
  void tryToLogin() async {
    if (ValidatorService().validateAndSave(loginFormKey)) {
      // fcmToken = await getFCMToken();
      try {
        CustomEassyLoading.startLoading();

        AuthApiService()
            .loginRequest(
          loginUserName!.text,
          loginpassword!.text,
          "", //fcmtoken
        )
            .then((resp) async {
          if (resp.isNotEmpty) {
            await SharedDataManageService().setToken(resp["token"]);
            await SharedDataManageService().setMenuToken(resp["menuToken"]);
            update();
            // PageNavigationService.removeAllAndNavigate(
            //   "/MainScreen",
            // );
            CustomEassyLoading.stopLoading();
          }
          CustomEassyLoading.stopLoading();
        }, onError: (err) {
          ApiErrorHandleService.handleStatusCodeError(err);
          CustomEassyLoading.stopLoading();
        });
      } on SocketException catch (e) {
        debugPrint('error $e');
        CustomEassyLoading.stopLoading();
      } on Exception catch (e) {
        CustomEassyLoading.stopLoading();
        debugPrint("$e");
      } catch (e) {
        CustomEassyLoading.stopLoading();
        debugPrint("$e");
      }

      update();
    }
  }

  //<=================== Intialize Login TexEdition Controller
  initializeTextEditingController() {
    loginUserName = TextEditingController();
    loginpassword = TextEditingController();
  }
}
