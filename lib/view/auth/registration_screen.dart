import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/services/validator_service.dart';
import 'package:service/view/variables/colors_variable.dart';
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: LocaleKeys.auth_firstName.tr(),
                                  controller:
                                      authCtrl.registrationFirstNameCtrl,
                                  keyboardType: TextInputType.name,
                                  validator:
                                      ValidatorService.validateSimpleFiled,
                                  onChanged: (value) {
                                    authCtrl.profile.value.userFirstName =
                                        value;
                                    authCtrl.update();
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: LocaleKeys.auth_lastName.tr(),
                                  keyboardType: TextInputType.name,
                                  controller: authCtrl.registrationLastNameCtrl,
                                  validator:
                                      ValidatorService.validateSimpleFiled,
                                  onChanged: (value) {
                                    authCtrl.profile.value.userLastName = value;
                                    authCtrl.update();
                                  },
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            prefixIcon: const Icon(Icons.email),
                            labelText: LocaleKeys.auth_email.tr(),
                            keyboardType: TextInputType.emailAddress,
                            controller: authCtrl.registrationEmailCtrl,
                            validator: ValidatorService.validateEmail,
                            onChanged: (value) {
                              authCtrl.profile.value.userMail = value;
                              authCtrl.update();
                            },
                          ),
                          CustomTextField(
                            prefixIcon: const Icon(Icons.phone_android_rounded),
                            labelText: LocaleKeys.auth_phoneNumber.tr(),
                            keyboardType: TextInputType.phone,
                            controller: authCtrl.registrationMobileCtrl,
                            validator: ValidatorService.validateMobile,
                            onChanged: (value) {
                              authCtrl.profile.value.userContactNo = value;
                              authCtrl.update();
                            },
                          ),
                          // CustomTextField(
                          //   enabled: false,
                          //   prefixIcon:
                          //       const Icon(Icons.card_membership_outlined),
                          //   labelText: LocaleKeys.auth_userID.tr(),
                          //   controller:
                          //       authCtrl.selectedUserType!.value == "Email"
                          //           ? authCtrl.registrationEmailCtrl
                          //           : authCtrl.registrationMobileCtrl,
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                      text: "Choose your verification method\n",
                                      style: CustomTextStyle
                                          .normalRegularStyleBlack,
                                      children: [
                                        TextSpan(
                                          text:
                                              "OTP will be sent to your ${authCtrl.selectedUserType}",
                                          style: CustomTextStyle
                                              .smallRegularStyleDarkGrey,
                                        )
                                      ])),
                              const SizedBox(
                                width: 5,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: authCtrl.userTypeList.map((type) {
                                    return Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: authCtrl.selectedUserType!
                                                        .value ==
                                                    type
                                                ? CustomColors.primary
                                                : CustomColors.white,
                                            border: Border.all(
                                                color: CustomColors.primary)),
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.all(5),
                                        child: InkWell(
                                          onTap: () {
                                            authCtrl.selectedUserType!.value =
                                                type;

                                            authCtrl.update();
                                          },
                                          child: Icon(
                                            type == "Email"
                                                ? Icons.email_outlined
                                                : Icons.call,
                                            color: type ==
                                                    authCtrl
                                                        .selectedUserType!.value
                                                ? CustomColors.white
                                                : CustomColors.primary,
                                          ),
                                        ));
                                  }).toList()),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomCompanyButton(
                            buttonName: LocaleKeys.auth_continue.tr(),
                            onPressed: () async {
                              await authCtrl.sendOtp();
                            },
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
