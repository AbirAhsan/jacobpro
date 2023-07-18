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
import '../view/variables/text_style.dart';
import 'screen_controller.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgetResetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController? forgetPassUserNameCtrl = TextEditingController();
  TextEditingController? forgetNewPassCtrl = TextEditingController();
  TextEditingController? forgetConfirmNewPassCtrl = TextEditingController();

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
        Get.put(ScreenController()).changeProfileTabbar(0);
        AuthApiService()
            .loginRequest(
          loginUserNameCtrl!.text,
          loginPasswordCtrl!.text,
          "", //fcmtoken
        )
            .then((resp) async {
          if (resp.isNotEmpty) {
            clearLoginTextEditingController();
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

  //<============================== Find User for Forget Password
  Future<void> findUser() async {
    if (ValidatorService().validateAndSave(forgetPasswordFormKey)) {
      // fcmToken = await getFCMToken();
      try {
        CustomEassyLoading.startLoading();
        AuthApiService()
            .findUser(
          forgetPassUserNameCtrl!.text,
        )
            .then((resp) async {
          CustomEassyLoading.stopLoading();
          if (resp.isNotEmpty) {
            PageNavigationService.generalNavigation(
                "/ForgetPassMakeSelectionScreen",
                arguments: resp);
            forgetPassUserNameCtrl!.clear();
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

  //<============================== Registration Send Otp to Request

  Future<void> sendOtp(ProfileGeneralData? profileData) async {
    if (ValidatorService().validateAndSave(registrationFormKey)) {
      // fcmToken = await getFCMToken();
      try {
        CustomEassyLoading.startLoading();
        selectedUserType!.value == "Email"
            ? AuthApiService()
                .sendOtpRequestToMail(
                profileData!.userMail,
              )
                .then((resp) async {
                CustomEassyLoading.stopLoading();
                if (resp!) {
                  print(resp);
                  PageNavigationService.generalNavigation(
                      "/RegistrationEmailOtpVerification",
                      arguments: [profileData.userMail, profileData]);
                }
              }, onError: (err) {
                ApiErrorHandleService.handleStatusCodeError(err);
                CustomEassyLoading.stopLoading();
              })
            : AuthApiService()
                .sendOtpRequestToPhone(
                profileData!.userContactNo,
              )
                .then((resp) async {
                selectedUserType!.value == "Mobile";
                CustomEassyLoading.stopLoading();
                if (resp) {
                  print(selectedUserType!.value);
                  PageNavigationService.removeAndNavigate(
                      "/RegistrationPhoneOtpVerification",
                      arguments: [profileData.userContactNo, profileData]);
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
      if (selectedUserType!.value == "Email") {
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
      } else {
        AuthApiService()
            .sendOtpRequestToPhone(
          userName,
        )
            .then((resp) async {
          CustomEassyLoading.stopLoading();
          if (resp) {
            startTimer();
          }
        }, onError: (err) {
          ApiErrorHandleService.handleStatusCodeError(err);
          CustomEassyLoading.stopLoading();
        });
      }
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

  //<============================== Forget Password otp Request
  Future<void> forgetPassSendOtp(String mailOrPhone, userSystemId) async {
    // fcmToken = await getFCMToken();
    try {
      CustomEassyLoading.startLoading();
      selectedUserType!.value == "Email"
          ? AuthApiService()
              .sendForgetOtpRequestToMail(
              mailOrPhone,
            )
              .then((resp) async {
              CustomEassyLoading.stopLoading();
              if (resp!) {
                await startTimer();
                PageNavigationService.removeAndNavigate(
                  "/ForgetPassOTP",
                  arguments: [mailOrPhone, userSystemId],
                );
              }
            }, onError: (err) {
              ApiErrorHandleService.handleStatusCodeError(err);
              CustomEassyLoading.stopLoading();
            })
          : AuthApiService()
              .sendForgetOtpRequestToPhone(
              mailOrPhone,
            )
              .then((resp) async {
              CustomEassyLoading.stopLoading();
              if (resp) {
                await startTimer();
                PageNavigationService.removeAndNavigate("/ForgetPassOTP",
                    arguments: [mailOrPhone, userSystemId]);
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

  //<================ Forget Password  VerifyOtp
  Future<void> tryToVerifyOtpForgetpassword(
      {String? userName, String? systemId}) async {
    try {
      CustomEassyLoading.startLoading();
      AuthApiService.verifyOtp(otp: currentOtpPin ?? "12", userName: userName)
          .then((resp) {
        CustomEassyLoading.stopLoading();
        if (resp) {
          PageNavigationService.generalNavigation("/ForgetResetPassScreen",
              arguments: [userName, systemId]);
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

  //<============================== Forget Password Resend OTP Request
  Future<void> forgetPassResendOtp(String mailOrPhone) async {
    // fcmToken = await getFCMToken();
    try {
      CustomEassyLoading.startLoading();
      selectedUserType!.value == "Email"
          ? AuthApiService()
              .sendForgetOtpRequestToMail(
              mailOrPhone,
            )
              .then((resp) async {
              CustomEassyLoading.stopLoading();
              if (resp!) {
                await startTimer();
              }
            }, onError: (err) {
              ApiErrorHandleService.handleStatusCodeError(err);
              CustomEassyLoading.stopLoading();
            })
          : AuthApiService()
              .sendForgetOtpRequestToPhone(
              mailOrPhone,
            )
              .then((resp) async {
              CustomEassyLoading.stopLoading();
              if (resp) {
                await startTimer();
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

  //<================ Verify Otp  and
  Future<void> tryToVerifyOtp(
      {String? userName, ProfileGeneralData? profileData}) async {
    try {
      CustomEassyLoading.startLoading();
      AuthApiService.verifyOtp(otp: currentOtpPin, userName: userName).then(
          (resp) {
        CustomEassyLoading.stopLoading();
        if (resp) {
          print("verified");
          if (selectedUserType!.value == "Email") {
            selectedUserType!.value = "Mobile";
            sendOtp(profileData);
          } else {
            tryToRegister(userName: userName, profileData: profileData);
          }

          //
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

  //<================ Register
  Future<void> tryToRegister(
      {String? userName, ProfileGeneralData? profileData}) async {
    try {
      CustomEassyLoading.startLoading();
      AuthApiService()
          .registrationRequest(userName: userName, profileData: profileData)
          .then((resp) {
        clearRegistrationTextEditingController();
        CustomEassyLoading.stopLoading();
        CustomDialogShow.showSuccessDialog(
            barrierDismissible: true,
            title: "CONGRATULATIONS!",
            descriptionWidget: RichText(
              text: const TextSpan(
                  text: "",
                  style: CustomTextStyle.mediumRegularStyleBlack,
                  children: [
                    TextSpan(
                      text:
                          "You are successfully signed up for Jacob Pro. You can login to your account using username and password to submit your documents for further verification",
                      style: CustomTextStyle.mediumRegularStyleBlack,
                    ),
                    TextSpan(
                      text: "\n\n",
                      style: CustomTextStyle.mediumRegularStyleBlack,
                    ),
                    TextSpan(
                      text: "Your temporary password is ",
                      style: CustomTextStyle.mediumRegularStyleBlack,
                    ),
                    TextSpan(
                      text: "1234 ",
                      style: CustomTextStyle.mediumBoldStyleBlack,
                    ),
                    TextSpan(
                      text: "You can reset your password later.",
                      style: CustomTextStyle.mediumRegularStyleBlack,
                    ),
                  ]),
              textAlign: TextAlign.center,
            ),
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

  //<================ Reset Password Request
  Future<void> resetPasswordRequest(
      {String? userName, String? userSystemId}) async {
    if (ValidatorService().validateAndSave(forgetResetPasswordFormKey)) {
      try {
        CustomEassyLoading.startLoading();
        AuthApiService()
            .resetPasswordRequest(
                userName: userName,
                userSystemId: userSystemId,
                password: forgetConfirmNewPassCtrl!.text)
            .then((resp) {
          CustomEassyLoading.stopLoading();
          CustomDialogShow.showSuccessDialog(
              title: "CONGRATULATIONS!",
              description:
                  "You've successfully reset your password.\nYou'll receive a mail/sms with access credential shortly.",
              okayButtonName: "Go To Login",
              btnOkOnPress: () {
                PageNavigationService.backScreen();
                PageNavigationService.removeAllAndNavigate("/LoginScreen");
              });
        }, onError: (err) {
          CustomEassyLoading.stopLoading();
          ApiErrorHandleService.handleStatusCodeError(err);
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
    PageNavigationService.removeAllAndNavigate("/LoginScreen");
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

  //clear Registration Controller
  clearRegistrationTextEditingController() {
    registrationFirstNameCtrl.clear();
    registrationLastNameCtrl.clear();
    registrationEmailCtrl.clear();
    registrationMobileCtrl.clear();
  }

  //clear Login Controller
  clearLoginTextEditingController() {
    loginUserNameCtrl!.clear();
    loginPasswordCtrl!.clear();
  }
}
