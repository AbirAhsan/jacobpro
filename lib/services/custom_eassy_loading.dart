import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../generated/locale_keys.g.dart';
import '../view/variables/icon_variables.dart';

class CustomEassyLoading {
  //<=============== Start Loading Function
  static startLoading() async {
    await EasyLoading.show(
      dismissOnTap: false,
      status: LocaleKeys.extra_pleaseWait.tr(),
      indicator: Image.asset(
        CustomIcons.loader,
        width: 130,
        height: 130,
      ),
    );
  }

//<<================ Sho Success Function
  static showSuccess() async {
    await EasyLoading.showSuccess(
      'Success!',
      dismissOnTap: true,
    );
  }

//<<================ Stop Loading Function
  static stopLoading() async {
    await EasyLoading.dismiss();
  }

//<<================ Show  Toast Function
  static showToast(String? message) async {
    EasyLoading.showToast(message ?? "");
  }

//<================================ Show Progress
  static startWithProgress(int value) async {
    await EasyLoading.showProgress(
      value / 100, maskType: EasyLoadingMaskType.none,
      status: "$value%\n${LocaleKeys.extra_pleaseWait.tr()}",
      // indicator: Image.asset(
      //   loader,
      //   width: 100,
      //   height: 130,
      // ),
    );
  }
}
