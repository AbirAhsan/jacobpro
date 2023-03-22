import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/controller/auth_controller.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/variables/icon_variables.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../controller/screen_controller.dart';
import '../../generated/locale_keys.g.dart';
import '../../services/validator_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authCtrl) {
            return Scaffold(
              body: Form(
                key: authCtrl.loginFormKey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    children: [
                      Image.asset(
                        CustomIcons.logo,
                        width: 200,
                        height: 80,
                      ),
                      const SizedBox(
                        height: 50,
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
                        controller: authCtrl.loginUserNameCtrl,
                        contentPadding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        prefixIcon: const Icon(Icons.person),
                        labelText: LocaleKeys.auth_userID.tr(),
                        validator: ValidatorService.validateSimpleFiled,
                      ),
                      GetBuilder<ScreenController>(
                          init: ScreenController(),
                          builder: (screenCtrl) {
                            return CustomTextField(
                              controller: authCtrl.loginPasswordCtrl,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(0, 10, 15, 10),
                              prefixIcon: const Icon(Icons.lock),
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
                              PageNavigationService.generalNavigation(
                                  "/ForgetPassFindAccount");
                            },
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomCompanyButton(
                        buttonName: LocaleKeys.auth_signin.tr(),
                        onPressed: () => authCtrl.tryToLogin(),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      Row(children: [
                        const Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                        Text(" ${LocaleKeys.auth_orUse.tr()} "),
                        const Expanded(
                            child: Divider(
                          thickness: 2,
                          height: 50,
                        )),
                      ]),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 2.5,
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              height: 30,
                              width: 50,
                              child: Image.asset(
                                CustomIcons.google,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2.5,
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              height: 30,
                              width: 50,
                              child: Image.asset(
                                CustomIcons.facebook,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2.5,
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              height: 30,
                              width: 50,
                              child: Image.asset(
                                CustomIcons.apple,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(
                        thickness: 2,
                        height: 50,
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
                                      PageNavigationService
                                          .removeAllAndNavigate(
                                              '/RegistrationScreen');
                                    }),
                            ]),
                        textAlign: TextAlign.center,
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
