import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/view/variables/text_style.dart';

import '../../controller/auth_controller.dart';
import '../../generated/locale_keys.g.dart';
import '../widgets/custom_company_button.dart';
import '../widgets/custom_otp_screen.dart';

class RegistrationOtpVerification extends StatelessWidget {
  const RegistrationOtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    String? userId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.otpVerification_otp.tr(),
          style: CustomTextStyle.titleBoldStyleGrey,
          textAlign: TextAlign.center,
        ),
      ),
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authCtrl) {
            print(authCtrl.registrationEmailCtrl.text);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(authCtrl.selectedUserType!.value),
                      Text(
                        LocaleKeys.otpVerification_msg.tr(args: [
                          // authCtrl.selectedUserType!.value == "Email"
                          //     ? userId!.replaceRange(
                          //         0, userId.indexOf("@") - 3, " *****")
                          //     :
                          userId!.replaceRange(2, 7, "*****")
                        ]),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const CustomPinCode(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${LocaleKeys.otpVerification_dinotReceive.tr()} ",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          // Flexible(
                          //   child: ArgonTimerButton(
                          //     initialTimer: 60, // Optional
                          //     height: 35,
                          //     width: 110,
                          //     minWidth: 100,
                          //     color: primaryBlueColor,
                          //     borderRadius: 5.0,

                          //     child: Text(
                          //       LocaleKeys.otpVerification_resend.tr(),
                          //       style: const TextStyle(
                          //           color: white,
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.w700),
                          //     ),
                          //     loader: (timeLeft) {
                          //       return Padding(
                          //         padding: const EdgeInsets.all(3.0),
                          //         child: Text(
                          //           "$timeLeft ${LocaleKeys.otpVerification_wait.tr()}",
                          //           style: const TextStyle(
                          //             color: white,
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w700,
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //     onTap: (startTimer, btnState) {
                          //       if (btnState == ButtonState.Idle) {
                          //         authCtrl.resendOTp().then((value) {
                          //           if (value) {
                          //             startTimer(60);
                          //           }
                          //         });
                          //       }
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomCompanyButton(
                        leftPadding: 30,
                        rightPadding: 30.0,
                        buttonName: LocaleKeys.auth_signup.tr(),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
