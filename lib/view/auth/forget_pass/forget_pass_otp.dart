import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import '../../../controller/auth_controller.dart';
import '../../../generated/locale_keys.g.dart';
import '../../variables/colors_variable.dart';
import '../../variables/icon_variables.dart';
import '../../variables/text_style.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_company_button.dart';
import '../../widgets/custom_otp_screen.dart';

class ForgetPassOTP extends StatelessWidget {
  const ForgetPassOTP({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedUser = Get.arguments[0];
    String? userSystemId = Get.arguments[1];
    return Scaffold(
      appBar: const CustomAppBar(
        elevation: 0,
        title: "",
        hideNotificationIcon: true,
      ),
      body: GetBuilder<AuthController>(
          init: AuthController(),
          initState: (state) {},
          builder: (authCtrl) {
            return ListView(
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.only(left: 20, right: 20),
              children: [
                Image.asset(
                  CustomIcons.registration,
                  width: 200,
                  height: 120,
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.otpVerification_otp.tr().toUpperCase(),
                    style: CustomTextStyle.titleBoldStyleBlack,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.otpVerification_msg.tr(args: [
                      // authCtrl.selectedUserType!.value == "Email"
                      //     ? userId!.replaceRange(
                      //         0, userId.indexOf("@") - 3, " *****")
                      //     :
                      selectedUser!.replaceRange(2, 7, "*****")
                    ]),
                    style: CustomTextStyle.mediumBoldStyleGrey,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.otpVerification_enterOtp.tr(),
                    style: CustomTextStyle.mediumBoldStyleDarkGrey,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomPinCode(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${LocaleKeys.otpVerification_dinotReceive.tr()} ",
                      style: CustomTextStyle.normalBoldStyleGrey,
                    ),
                    CustomCompanyButton(
                      topPadding: 0,
                      isFitted: false,
                      bottomPadding: 0,
                      leftPadding: 0,
                      rightPadding: 0,
                      primaryColor: CustomColors.white,
                      textStyle: CustomTextStyle.normalBoldStylePrimary,
                      fizedSize: const Size(130, 15),
                      buttonName: authCtrl.secondsRemaining == 0
                          ? LocaleKeys.otpVerification_resend.tr()
                          : LocaleKeys.otpVerification_wait
                              .tr(args: [authCtrl.secondsRemaining.toString()]),
                      onPressed: () {
                        if (authCtrl.secondsRemaining == 0) {
                          authCtrl.forgetPassResendOtp(selectedUser);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomCompanyButton(
                    leftPadding: 30,
                    rightPadding: 30.0,
                    buttonName: LocaleKeys.auth_continue.tr(),
                    onPressed: () {
                      authCtrl.tryToVerifyOtpForgetpassword(
                          userName: selectedUser, systemId: userSystemId);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }
}
