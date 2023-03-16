import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/api_service/auth_api_service.dart';
import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';
import '../services/page_navigation_service.dart';
import '../services/shared_data_manage_service.dart';
import '../services/validator_service.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  TextEditingController? loginUserNameCtrl = TextEditingController();
  TextEditingController? loginPasswordCtrl = TextEditingController();
  //
  TextEditingController registrationFirstNameCtrl = TextEditingController();
  TextEditingController registrationLastNameCtrl = TextEditingController();
  TextEditingController registrationEmailCtrl = TextEditingController();
  TextEditingController registrationMobileCtrl = TextEditingController();

  //
  bool? isTermsCheck = false;

  List userTypeList = ["Email", "Mobile"];

  RxString? selectedUserType = "Email".obs;

  String? currentOtpPin;
  int secondsRemaining = 30;
  Timer? timer;

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    initializeTextEditingController();
    startTimer();
    super.onInit();
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }

  //<============================== Login Request
  void tryToLogin() async {
    if (ValidatorService().validateAndSave(loginFormKey)) {
      // fcmToken = await getFCMToken();
      try {
        CustomEassyLoading.startLoading();

        AuthApiService()
            .loginRequest(
          loginUserNameCtrl!.text,
          loginPasswordCtrl!.text,
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

  //<============================== Registration Request
  void tryToRegistration() async {
    if (ValidatorService().validateAndSave(registrationFormKey)) {
      // fcmToken = await getFCMToken();
      try {
        CustomEassyLoading.startLoading();

        // AuthApiService()
        //     .loginRequest(
        //   loginUserNameCtrl!.text,
        //   loginPasswordCtrl!.text,
        //   "", //fcmtoken
        // )
        //     .then((resp) async {
        //   if (resp.isNotEmpty) {
        //     await SharedDataManageService().setToken(resp["token"]);
        //     await SharedDataManageService().setMenuToken(resp["menuToken"]);
        //     update();
        //     // PageNavigationService.removeAllAndNavigate(
        //     //   "/MainScreen",
        //     // );
        //     CustomEassyLoading.stopLoading();
        //   }
        //   CustomEassyLoading.stopLoading();
        // }, onError: (err) {
        //   ApiErrorHandleService.handleStatusCodeError(err);
        //   CustomEassyLoading.stopLoading();
        // });
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

//<=================== Start Timer
  startTimer() {
    print("Working");
    secondsRemaining = 30;
    update();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;
        update();
        print("object");
      }
    });
  }

  //<=================== Intialize Login TexEdition Controller
  initializeTextEditingController() {
    loginUserNameCtrl = TextEditingController();
    loginPasswordCtrl = TextEditingController();
    registrationFirstNameCtrl = TextEditingController();
    registrationLastNameCtrl = TextEditingController();
    registrationEmailCtrl = TextEditingController();
    registrationMobileCtrl = TextEditingController();
  }
}
