import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:service/services/validator_service.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../../controller/profile_controller.dart';
import '../../../controller/screen_controller.dart';
import '../../widgets/custom_company_button.dart';

class BankDetailsView extends StatelessWidget {
  const BankDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        initState: (state) {
          Get.put(ProfileController()).fetchMyProfileDetails();
        },
        builder: (profileCtrl) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: profileCtrl.profileBankFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: profileCtrl.bankNameTxtCtrl,
                    isRequired: true,
                    labelText: "Bank Name",
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      profileCtrl.profilePaymentMethod.value
                          ?.paymentMethodName = value;
                      print(profileCtrl
                          .profilePaymentMethod.value?.paymentMethodName);
                      profileCtrl.update();
                    },
                    validator: ValidatorService.validateSimpleFiled,
                  ),
                  CustomTextField(
                    controller: profileCtrl.branchNameTxtCtrl,
                    isRequired: true,
                    labelText: "Branch Address",
                    keyboardType: TextInputType.streetAddress,
                    onChanged: (value) {
                      profileCtrl.profilePaymentMethod.value
                          ?.paymentAccountBranchName = value;
                      profileCtrl.update();
                    },
                    validator: ValidatorService.validateSimpleFiled,
                  ),
                  CustomTextField(
                    controller: profileCtrl.accountHolderNameTxtCtrl,
                    isRequired: true,
                    labelText: "Account Holder Name",
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      profileCtrl.profilePaymentMethod.value
                          ?.paymentAccountName = value;
                      profileCtrl.update();
                    },
                    validator: ValidatorService.validateSimpleFiled,
                  ),
                  CustomTextField(
                    controller: profileCtrl.accountNumberTxtCtrl,
                    isRequired: true,
                    labelText: "Account Number",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    onChanged: (value) {
                      profileCtrl.profilePaymentMethod.value?.paymentAccountNo =
                          value;
                      profileCtrl.update();
                    },
                    validator: ValidatorService.validateSimpleFiled,
                  ),
                  CustomTextField(
                    controller: profileCtrl.routingNumberTxtCtrl,
                    isRequired: true,
                    labelText: "Routing Number",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    onChanged: (value) {
                      profileCtrl.profilePaymentMethod.value?.paymentRoutingNo =
                          value;
                      profileCtrl.update();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Routing Number is required";
                      } else if (value.length != 9) {
                        return "Routing Number must have exactly 9 digits";
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GetBuilder<ScreenController>(
                      init: ScreenController(),
                      builder: (screenCtrl) {
                        return CustomCompanyButton(
                          buttonName: "PROCEED",
                          //  textStyle: CustomTextStyle.mediumBoldStylePrimary,
                          isFitted: true,
                          onPressed: () async {
                            await profileCtrl.updateProfileBankDetails();
                            // screenCtrl.changeProfileTabbar(2);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
