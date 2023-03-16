import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/text_style.dart';

class CustomDialogShow {
  static showSuccessDialog(String? title, String? description,
      String? okayButtonName, void Function()? btnOkOnPress) async {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      //  btnCancelOnPress: () {},
      padding: const EdgeInsets.all(10),
      btnOkOnPress: btnOkOnPress,

      descTextStyle: CustomTextStyle.normalRegularStyleBlack,
      buttonsTextStyle: CustomTextStyle.mediumBoldStyleWhite,
      btnOkText: okayButtonName,
    )..show();
  }
}
