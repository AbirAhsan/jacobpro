import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_submit_button.dart';

class CustomDialogShow {
  static showSuccessDialog({
    String? title,
    String? description,
    String? okayButtonName,
    void Function()? btnOkOnPress,
    String? cancelButtonName,
    void Function()? btnCancelOnPress,
  }) async {
    return showDialog(
        context: Get.context!,
        builder: (buildContext) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Get.height * 0.2,
                  width: double.infinity,
                  color: CustomColors.green,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check_circle_outline_outlined,
                    color: CustomColors.white,
                    size: Get.height * 0.1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        title ?? "",
                        style: CustomTextStyle.titleBoldStyleBlack,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          description ?? "",
                          style: CustomTextStyle.mediumRegularStyleBlack,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          btnCancelOnPress != null
                              ? CustomSubmitButton(
                                  leftMargin: 10,
                                  rightMargin: 10,
                                  topMargin: 10,
                                  bottomMargin: 10,
                                  topPadding: 0,
                                  bottomPadding: 0,
                                  buttonName: cancelButtonName ?? "",
                                  onPressed: btnCancelOnPress,
                                )
                              : Container(),
                          CustomSubmitButton(
                            leftMargin: 10,
                            rightMargin: 10,
                            topMargin: 10,
                            bottomMargin: 10,
                            topPadding: 0,
                            bottomPadding: 0,
                            buttonName: okayButtonName ?? "",
                            onPressed: btnOkOnPress,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static showInfoDialog({
    String? title,
    String? description,
    String? okayButtonName,
    void Function()? btnOkOnPress,
    String? cancelButtonName,
    void Function()? btnCancelOnPress,
  }) async {
    return showDialog(
        context: Get.context!,
        builder: (buildContext) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Get.height * 0.2,
                  width: double.infinity,
                  color: CustomColors.warning,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.info,
                    color: CustomColors.white,
                    size: Get.height * 0.1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        title ?? "",
                        style: CustomTextStyle.titleBoldStyleBlack,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          description ?? "",
                          style: CustomTextStyle.mediumRegularStyleBlack,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          btnCancelOnPress != null
                              ? CustomSubmitButton(
                                  leftMargin: 10,
                                  rightMargin: 10,
                                  topMargin: 10,
                                  bottomMargin: 10,
                                  topPadding: 0,
                                  bottomPadding: 0,
                                  buttonName: cancelButtonName ?? "",
                                  onPressed: btnCancelOnPress,
                                )
                              : Container(),
                          CustomSubmitButton(
                            leftMargin: 10,
                            rightMargin: 10,
                            topMargin: 10,
                            bottomMargin: 10,
                            topPadding: 0,
                            bottomPadding: 0,
                            buttonName: okayButtonName ?? "",
                            onPressed: btnOkOnPress,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
