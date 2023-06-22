import 'package:flutter/material.dart';
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
                    validator: ValidatorService.validateSimpleFiled,
                  ),
                  CustomTextField(
                    controller: profileCtrl.bankNameTxtCtrl,
                    isRequired: true,
                    labelText: "Branch Name",
                    keyboardType: TextInputType.name,
                    validator: ValidatorService.validateSimpleFiled,
                  ),
                  CustomTextField(
                    controller: profileCtrl.accountNumberTxtCtrl,
                    isRequired: true,
                    labelText: "Account Number",
                    keyboardType: TextInputType.number,
                    validator: ValidatorService.validateSimpleFiled,
                  ),
                  CustomTextField(
                    controller: profileCtrl.routingNumberTxtCtrl,
                    isRequired: true,
                    labelText: "Routing Number",
                    keyboardType: TextInputType.number,
                    validator: ValidatorService.validateSimpleFiled,
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
                            await profileCtrl.updateProfileSkill();
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
