import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_appbar.dart';
import 'package:service/view/widgets/custom_company_button.dart';

import '../../../controller/auth_controller.dart';
import '../../../generated/locale_keys.g.dart';
import '../../variables/icon_variables.dart';
import '../../widgets/custom_text_field.dart';

class ForgetPassFindAccount extends StatelessWidget {
  const ForgetPassFindAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        elevation: 0,
        title: "",
        hideNotificationIcon: true,
      ),
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (authCtrl) {
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
                  LocaleKeys.forgetPassword_title1.tr(),
                  style: CustomTextStyle.titleBoldStyleBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  LocaleKeys.forgetPassword_body1.tr(),
                  style: CustomTextStyle.normalRegularStyleBlack,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  prefixIcon: const Icon(
                    Icons.card_membership_outlined,
                  ),
                  controller: authCtrl.loginUserNameCtrl,
                  keyboardType: TextInputType.text,
                  labelText: LocaleKeys.forgetPassword_userId.tr(),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomCompanyButton(
                  buttonName: LocaleKeys.forgetPassword_button1.tr(),
                  onPressed: () {
                    PageNavigationService.generalNavigation(
                        "/ForgetPassMakeSelectionScreen");
                  },
                )
              ],
            );
          }),
    );
  }
}
