import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button.dart';

import '../../../controller/auth_controller.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widgets/custom_appbar.dart';

class ForgetPassMakeSelectionScreen extends StatelessWidget {
  const ForgetPassMakeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userDetails = Get.arguments;
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
                Text(
                  LocaleKeys.forgetPassword_title2.tr(),
                  style: CustomTextStyle.titleBoldStyleDarkGrey,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  LocaleKeys.forgetPassword_body2.tr(),
                  style: CustomTextStyle.normalRegularStyleBlack,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: authCtrl.userTypeList.map((userName) {
                    return Card(
                      color: authCtrl.selectedUserType == userName
                          ? CustomColors.primary
                          : Colors.grey,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15.0),
                        onTap: () {
                          authCtrl.selectedUserType!.value = userName;
                          authCtrl.update();
                        },
                        leading: userName == "Email"
                            ? const Icon(
                                Icons.email,
                                size: 40,
                                color: CustomColors.white,
                              )
                            : const Icon(
                                Icons.phone_iphone_outlined,
                                size: 40,
                                color: CustomColors.white,
                              ),
                        title: Text(
                          userName == "Email"
                              ? LocaleKeys.forgetPassword_viaMail.tr()
                              : LocaleKeys.forgetPassword_viaSms.tr(),
                          style: CustomTextStyle.mediumBoldStyleWhite,
                        ),
                        subtitle: Text(
                          userName == "Email"
                              ? userDetails["userMail"].replaceRange(
                                  0,
                                  userDetails["userMail"].indexOf("@") - 3,
                                  " * * * * * ")
                              : userDetails["userContactNo"]
                                  .replaceRange(3, 8, " * * * * * "),
                          style: CustomTextStyle.mediumBoldStyleWhite,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomCompanyButton(
                    buttonName: LocaleKeys.forgetPassword_button1.tr(),
                    onPressed: () async {
                      authCtrl.selectedUserType!.value == "Email"
                          ? authCtrl.forgetPassSendOtp(userDetails["userMail"],
                              userDetails["userSystemId"].toString())
                          : authCtrl.forgetPassSendOtp(
                              userDetails["userContactNo"],
                              userDetails["userSystemId"].toString());
                    })
              ],
            );
          }),
    );
  }
}
