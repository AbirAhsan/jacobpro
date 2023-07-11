import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/controller/screen_controller.dart';

import '../../../controller/auth_controller.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../services/validator_service.dart';
import '../../variables/icon_variables.dart';
import '../../variables/text_style.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_company_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgetResetPassScreen extends StatelessWidget {
  const ForgetResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? userName = Get.arguments[0];
    String? userSystemId = Get.arguments[1];

    return Scaffold(
      appBar: const CustomAppBar(
        elevation: 0,
        title: "",
        hideNotificationIcon: true,
      ),
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authCtrl) {
            return Form(
              key: authCtrl.forgetResetPasswordFormKey,
              child: GetBuilder<ScreenController>(
                  init: ScreenController(),
                  builder: (screenCtrl) {
                    return ListView(
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.all(15.0),
                      children: [
                        Image.asset(
                          CustomIcons.forgotPass,
                          width: 200,
                          height: 120,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          LocaleKeys.forgetPassword_resetPass.tr(),
                          style: CustomTextStyle.titleBoldStyleBlack,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          LocaleKeys.forgetPassword_resetPassBody.tr(),
                          style: CustomTextStyle.normalRegularStyleBlack,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          controller: authCtrl.forgetNewPassCtrl,
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 10, 15, 10),
                          prefixIcon: const Icon(Icons.lock),
                          labelText: LocaleKeys.forgetPassword_newPassword.tr(),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          validator: ValidatorService.validatePassword,
                        ),
                        CustomTextField(
                          controller: authCtrl.forgetConfirmNewPassCtrl,
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 10, 15, 10),
                          prefixIcon: const Icon(Icons.lock),
                          labelText: LocaleKeys.forgetPassword_confirmPass.tr(),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.auth_passwordRule1.tr();
                            } else if (value !=
                                authCtrl.forgetNewPassCtrl!.text.toString()) {
                              return "Password is not match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomCompanyButton(
                          buttonName: LocaleKeys.forgetPassword_confirm.tr(),
                          onPressed: () {
                            authCtrl.resetPasswordRequest(
                                userName: userName, userSystemId: userSystemId);
                          },
                        )
                      ],
                    );
                  }),
            );
          }),
    );
  }
}
