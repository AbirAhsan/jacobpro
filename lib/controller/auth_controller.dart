import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/technician_profile_model.dart';

import '../services/api_service/auth_api_service.dart';
import '../services/custom_dialog_class.dart';
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

  Rx<ProfileGeneralData> profile = ProfileGeneralData().obs;

  //
  bool? isTermsCheck = false;

  List userTypeList = ["Email", "Mobile"];

  RxString? selectedUserType = "Email".obs;

  String? currentOtpPin;
  int secondsRemaining = 60;
  Timer? timer;

  @override
  onInit() {
    // AppConfig.getVersionStatus();
    initializeTextEditingController();

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
            await SharedDataManageService()
                .setUserVerification(resp["userVerificationStatus"].toString());

            update();
            CustomEassyLoading.stopLoading();
            if (resp["userVerificationStatus"] == 1) {
              PageNavigationService.removeAllAndNavigate(
                "/DashBoardScreen",
              );
            } else {
              PageNavigationService.removeAllAndNavigate(
                "/ProfileDetailsScreen",
              );
            }
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

  //<============================== Login Request
  Future<void> sendOtp() async {
    if (ValidatorService().validateAndSave(registrationFormKey)) {
      // fcmToken = await getFCMToken();
      try {
        CustomEassyLoading.startLoading();
        selectedUserType!.value == "Email"
            ? AuthApiService()
                .sendOtpRequestToMail(
                registrationEmailCtrl.text,
              )
                .then((resp) async {
                CustomEassyLoading.stopLoading();
                if (resp!) {
                  print(selectedUserType!.value);
                  PageNavigationService.generalNavigation(
                      "/RegistrationOtpVerification",
                      arguments: [registrationEmailCtrl.text, profile.value]);
                }
              }, onError: (err) {
                ApiErrorHandleService.handleStatusCodeError(err);
                CustomEassyLoading.stopLoading();
              })
            : AuthApiService()
                .sendOtpRequestToPhone(
                registrationMobileCtrl.text,
              )
                .then((resp) async {
                CustomEassyLoading.stopLoading();
                if (resp) {
                  print(selectedUserType!.value);
                  PageNavigationService.generalNavigation(
                      "/RegistrationOtpVerification",
                      arguments: [registrationMobileCtrl.text, profile.value]);
                }
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

  //<============================== Resend OTP Request
  Future<void> resendOtp(String? userName) async {
    // fcmToken = await getFCMToken();
    try {
      CustomEassyLoading.startLoading();
      AuthApiService()
          .sendOtpRequestToMail(
        userName,
      )
          .then((resp) async {
        CustomEassyLoading.stopLoading();
        if (resp!) {
          startTimer();
        }
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

  //<================ VerifyOtp
  Future<void> tryToVerifyOtp(
      {String? userName, ProfileGeneralData? profileData}) async {
    try {
      CustomEassyLoading.startLoading();
      AuthApiService.verifyOtp(otp: currentOtpPin, userName: userName).then(
          (resp) {
        CustomEassyLoading.stopLoading();
        if (resp) {
          print("verified");
          tryToRegister(userName: userName, profileData: profileData);
        }
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

  //<================ VerifyOtp
  Future<void> tryToRegister(
      {String? userName, ProfileGeneralData? profileData}) async {
    try {
      CustomEassyLoading.startLoading();
      AuthApiService()
          .registrationRequest(userName: userName, profileData: profileData)
          .then((resp) {
        CustomEassyLoading.stopLoading();
        CustomDialogShow.showSuccessDialog(
            barrierDismissible: true,
            title: "CONGRATULATIONS!",
            description:
                "You are successfully signed up for Jacob Pro. You can login to your account using username and password to submit your documents for further verificaon.\n\nYour temporary password is 1234. You can reset your password later.",
            okayButtonName: "Go To Login",
            btnOkOnPress: () {
              PageNavigationService.removeAllAndNavigate('/LoginScreen');
            });
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

//<=================== Start Timer
  startTimer() {
    print("Working");
    secondsRemaining = 60;
    update();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;
        update();
      } else {
        timer!.cancel();
      }
    });
  }

  //<<============================================================= Try to Logout
  void tryToLogOut() {
    SharedDataManageService().clearTokenUserID();
    PageNavigationService.removeAndNavigate("/LoginScreen");
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
