import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/services/validator_service.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../controller/auth_controller.dart';
import '../../generated/locale_keys.g.dart';
import '../../services/page_navigation_service.dart';
import '../variables/icon_variables.dart';
import '../variables/text_style.dart';
import '../widgets/custom_company_button.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
                  key: authCtrl.registrationFormKey,
                  child: Center(
                    child: ListView(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(20),
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
                              LocaleKeys.auth_signup.tr(),
                              style: CustomTextStyle.titleBoldStyleBlack,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: LocaleKeys.auth_firstName.tr(),
                                  controller:
                                      authCtrl.registrationFirstNameCtrl,
                                  validator:
                                      ValidatorService.validateSimpleFiled,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: LocaleKeys.auth_lastName.tr(),
                                  controller: authCtrl.registrationLastNameCtrl,
                                  validator:
                                      ValidatorService.validateSimpleFiled,
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            prefixIcon: const Icon(Icons.email),
                            labelText: LocaleKeys.auth_email.tr(),
                            controller: authCtrl.registrationEmailCtrl,
                            validator: ValidatorService.validateEmail,
                          ),
                          CustomTextField(
                            prefixIcon: const Icon(Icons.phone_android_rounded),
                            labelText: LocaleKeys.auth_phoneNumber.tr(),
                            controller: authCtrl.registrationMobileCtrl,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Your preferrable User Type ?",
                            style: CustomTextStyle.normalBoldStyleBlack,
                          ),
                          Row(
                              children: authCtrl.userTypeList.map((type) {
                            return RadioMenuButton(
                                value: type,
                                groupValue: authCtrl.selectedUserType,
                                onChanged: (value) {
                                  authCtrl.selectedUserType = value;
                                  authCtrl.update();
                                },
                                child: Text(
                                  type,
                                  style:
                                      CustomTextStyle.normalRegularStyleBlack,
                                ));
                          }).toList()),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomCompanyButton(
                            buttonName: LocaleKeys.auth_continue.tr(),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Divider(
                            thickness: 2,
                            height: 50,
                          ),
                          RichText(
                            text: TextSpan(
                                text: LocaleKeys.auth_alreadyHaveAccount.tr(),
                                style:
                                    CustomTextStyle.normalRegularStyleDarkGrey,
                                children: [
                                  TextSpan(
                                      text: " ${LocaleKeys.auth_signin.tr()}",
                                      style: CustomTextStyle
                                          .normalBoldStylePrimary,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          //Code to launch your URL

                                          PageNavigationService
                                              .removeAllAndNavigate(
                                                  '/LoginScreen');
                                        }),
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                  ),
                ),
              );
            }));
  }
}
