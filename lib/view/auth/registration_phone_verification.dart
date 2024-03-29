import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/model/technician_profile_model.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';

import '../../controller/auth_controller.dart';
import '../../generated/locale_keys.g.dart';
import '../variables/icon_variables.dart';
import '../widgets/custom_company_button.dart';
import '../widgets/custom_otp_screen.dart';

class RegistrationPhoneOtpVerification extends StatelessWidget {
  const RegistrationPhoneOtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    String? userId = Get.arguments[0];
    ProfileGeneralData? profile = Get.arguments[1];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<AuthController>(
          init: AuthController(),
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.put(AuthController()).startTimer();
            });
          },
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
                    LocaleKeys.otpVerification_otp.tr(),
                    style: CustomTextStyle.titleBoldStyleBlack,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.otpVerification_msg.tr(args: [userId!]),
                    style: CustomTextStyle.mediumRegularStyleGrey,
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
                          authCtrl.resendOtp(userId);
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
                    buttonName: LocaleKeys.auth_signup.tr(),
                    onPressed: () async {
                      await authCtrl.tryToVerifyOtp(
                          userName: userId, profileData: profile);
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
