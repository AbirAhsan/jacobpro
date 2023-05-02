import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button.dart';
import 'package:service/view/widgets/custom_submit_button.dart';

class CustomDialogShow {
  static showSuccessDialog({
    String? title,
    String? description,
    String? okayButtonName,
    bool barrierDismissible = true,
    void Function()? btnOkOnPress,
    String? cancelButtonName,
    void Function()? btnCancelOnPress,
  }) async {
    return showDialog(
        barrierDismissible: barrierDismissible,
        context: Get.context!,
        builder: (buildContext) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Get.height * 0.15,
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        title ?? "Successful",
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          btnCancelOnPress != null
                              ? SizedBox(
                                  width: btnOkOnPress != null
                                      ? Get.width / 3
                                      : Get.width / 2,
                                  child: CustomSubmitButton(
                                    leftMargin: 10,
                                    rightMargin: 10,
                                    topMargin: 10,
                                    bottomMargin: 10,
                                    topPadding: 0,
                                    bottomPadding: 0,
                                    topRightBorderRadius: 0,
                                    topLeftBorderRadius: 0,
                                    bottomLeftBorderRadius: 0,
                                    bottomRightBorderRadius: 0,
                                    primaryColor: CustomColors.darkGrey,
                                    borderColor: CustomColors.darkGrey,
                                    fizedSize: Size(Get.width / 2, 30),
                                    buttonName: cancelButtonName ?? "",
                                    onPressed: btnCancelOnPress,
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            width: btnCancelOnPress != null
                                ? Get.width / 3
                                : Get.width / 2,
                            child: CustomCompanyButton(
                              leftMargin: 10,
                              rightMargin: 10,
                              topMargin: 10,
                              bottomMargin: 10,
                              primaryColor: CustomColors.green,
                              borderColor: CustomColors.green,
                              fizedSize: Size(Get.width / 2, 30),
                              topPadding: 0,
                              bottomPadding: 0,
                              topRightBorderRadius: 0,
                              topLeftBorderRadius: 0,
                              bottomLeftBorderRadius: 0,
                              bottomRightBorderRadius: 0,
                              buttonName: okayButtonName ?? "",
                              onPressed: btnOkOnPress,
                            ),
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
    bool barrierDismissible = true,
    String? title,
    String? description,
    String? okayButtonName,
    void Function()? btnOkOnPress,
    String? cancelButtonName,
    void Function()? btnCancelOnPress,
  }) async {
    return showDialog(
        barrierDismissible: barrierDismissible,
        context: Get.context!,
        builder: (buildContext) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Get.height * 0.15,
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
                  padding: const EdgeInsets.all(20.0),
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
                              ? SizedBox(
                                  width: btnOkOnPress != null
                                      ? Get.width / 3
                                      : Get.width / 2,
                                  child: CustomSubmitButton(
                                    leftMargin: 10,
                                    rightMargin: 10,
                                    topMargin: 10,
                                    bottomMargin: 10,
                                    primaryColor: CustomColors.darkGrey,
                                    borderColor: CustomColors.darkGrey,
                                    fizedSize: Size(Get.width / 2, 30),
                                    topPadding: 0,
                                    bottomPadding: 0,
                                    topRightBorderRadius: 0,
                                    topLeftBorderRadius: 0,
                                    bottomLeftBorderRadius: 0,
                                    bottomRightBorderRadius: 0,
                                    buttonName: cancelButtonName ?? "",
                                    onPressed: btnCancelOnPress,
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            width: btnCancelOnPress != null
                                ? Get.width / 3
                                : Get.width / 2,
                            child: CustomSubmitButton(
                              leftMargin: 10,
                              rightMargin: 10,
                              topMargin: 10,
                              bottomMargin: 10,
                              topPadding: 0,
                              bottomPadding: 0,
                              primaryColor: CustomColors.warning,
                              borderColor: CustomColors.warning,
                              fizedSize: Size(Get.width / 2, 30),
                              topRightBorderRadius: 0,
                              topLeftBorderRadius: 0,
                              bottomLeftBorderRadius: 0,
                              bottomRightBorderRadius: 0,
                              buttonName: okayButtonName ?? "",
                              onPressed: btnOkOnPress,
                            ),
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

  static showInformation({
    bool barrierDismissible = true,
    String? title,
    List<Widget>? contents,
    String? okayButtonName,
    void Function()? btnOkOnPress,
    String? cancelButtonName,
    void Function()? btnCancelOnPress,
  }) async {
    return showDialog(
        barrierDismissible: barrierDismissible,
        context: Get.context!,
        builder: (buildContext) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            insetPadding: EdgeInsets.zero,
            content: MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: Get.context!,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title ?? "",
                    style: CustomTextStyle.titleBoldStyleBlack,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: contents ?? [],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            btnCancelOnPress != null
                                ? SizedBox(
                                    width: btnOkOnPress != null
                                        ? Get.width / 3
                                        : Get.width / 2,
                                    child: CustomSubmitButton(
                                      leftMargin: 10,
                                      rightMargin: 10,
                                      topMargin: 10,
                                      bottomMargin: 10,
                                      primaryColor: CustomColors.darkGrey,
                                      borderColor: CustomColors.darkGrey,
                                      fizedSize: Size(Get.width / 2, 30),
                                      topPadding: 0,
                                      bottomPadding: 0,
                                      topRightBorderRadius: 0,
                                      topLeftBorderRadius: 0,
                                      bottomLeftBorderRadius: 0,
                                      bottomRightBorderRadius: 0,
                                      buttonName: cancelButtonName ?? "",
                                      onPressed: btnCancelOnPress,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: btnCancelOnPress != null
                                  ? Get.width / 3
                                  : Get.width / 2,
                              child: CustomSubmitButton(
                                leftMargin: 10,
                                rightMargin: 10,
                                topMargin: 10,
                                bottomMargin: 10,
                                topPadding: 0,
                                bottomPadding: 0,
                                primaryColor: CustomColors.warning,
                                borderColor: CustomColors.warning,
                                fizedSize: Size(Get.width / 2, 30),
                                topRightBorderRadius: 0,
                                topLeftBorderRadius: 0,
                                bottomLeftBorderRadius: 0,
                                bottomRightBorderRadius: 0,
                                buttonName: okayButtonName ?? "",
                                onPressed: btnOkOnPress,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
