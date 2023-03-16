import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/text_style.dart';

class CustomDialogShow {
  static showSuccessDialog(String? description) async {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Sign Up Successful',
      desc:
          'Easy Localization] [DEBUG] Init provider Reloaded 1 of 1487 libraries in 520ms Easy Localization] [DEBUG] Init provider Reloaded 1 of 1487 libraries in 520ms',
      //  btnCancelOnPress: () {},
      padding: const EdgeInsets.all(10),
      btnOkOnPress: () {},
      descTextStyle: CustomTextStyle.normalRegularStyleBlack,
      buttonsTextStyle: CustomTextStyle.mediumBoldStyleWhite,
    )..show();
  }
}
