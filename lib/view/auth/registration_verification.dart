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
        elevation: 0,
        title: Text(
          LocaleKeys.otpVerification_otp.tr(),
          style: CustomTextStyle.titleBoldStyleGrey,
          textAlign: TextAlign.left,
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authCtrl) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.otpVerification_msg.tr(args: [
                      // authCtrl.selectedUserType!.value == "Email"
                      //     ? userId!.replaceRange(
                      //         0, userId.indexOf("@") - 3, " *****")
                      //     :
                      userId!.replaceRange(2, 7, "*****")
                    ]),
                    style: CustomTextStyle.normalBoldStyleGrey,
                    textAlign: TextAlign.left,
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
                      Flexible(
                          child: CustomCompanyButton(
                        fizedSize: const Size(50, 20),
                        buttonName: LocaleKeys.otpVerification_resend.tr(),
                        onPressed: () {},
                      )),
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
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
