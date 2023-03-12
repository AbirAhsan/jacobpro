import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/view/variables/icon_variables.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../controller/screen_controller.dart';
import '../../generated/locale_keys.g.dart';
import '../../services/validator_service.dart';
import '../widgets/custom_submit_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Image.asset(
                      CustomIcons.logo,
                      width: 200,
                      height: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      LocaleKeys.auth_login.tr(),
                      style: CustomTextStyle.titleBoldStyleBlack,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  CustomTextField(
                    labelText: LocaleKeys.auth_userName.tr(),
                  ),
                  GetBuilder<ScreenController>(
                      init: ScreenController(),
                      builder: (screenCtrl) {
                        return CustomTextField(
                          labelText: LocaleKeys.auth_password.tr(),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: screenCtrl.isObscureText.value,
                          suffixIcon: InkWell(
                            onTap: () => screenCtrl.passwordVisibility(),
                            child: Icon(
                              screenCtrl.isObscureText.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                          ),
                          validator: ValidatorService.validatePassword,
                        );
                      }),
                  RichText(
                    text: TextSpan(
                      text: LocaleKeys.auth_forgot_password.tr(),
                      style: CustomTextStyle.normalRegularStyleDarkGrey,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          //Code to launch your URL
                          print("Forget password");
                        },
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomCompanyButton(buttonName: "Sign In ", onPressed: () {}),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                        text: LocaleKeys.auth_dontHaveAccount.tr(),
                        style: CustomTextStyle.normalRegularStyleDarkGrey,
                        children: [
                          TextSpan(
                              text: " ${LocaleKeys.auth_signup.tr()}",
                              style: CustomTextStyle.normalBoldStylePrimary,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  //Code to launch your URL
                                  print("Sign up");
                                }),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
