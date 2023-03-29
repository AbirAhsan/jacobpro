import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';

class ValidatorService {
  bool validateAndSave(globalFormKey) {
    final FormState form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

//<=============================================Mobile Number Validaor
  static String? validateMobile(String? value) {
    String? pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (value!.isEmpty) {
      return LocaleKeys.auth_phoneNumberRule1.tr();
    } else if (value.length != 11) {
      return LocaleKeys.auth_phoneNumberRule1.tr();
    }
    return null;
  }

  //<=============================================Mobile Number Validaor
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return LocaleKeys.auth_passwordRule1.tr();
    } else if (value.length < 4) {
      return LocaleKeys.auth_passwordRule2.tr();
    }
    return null;
  }

//<=============================================== Email Validator
  static String? validateEmail(String? value) {
    String? pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return LocaleKeys.auth_emailRule1.tr();
    } else if (!regex.hasMatch(value)) {
      return LocaleKeys.auth_emailRule2.tr();
    }
    return null;
  }

  //<============================================== Name Validator
  static String? validateName(String? value) {
    final RegExp nameRegExp = RegExp('[a-zA-Z]');
    if (value!.isEmpty) {
      return LocaleKeys.auth_nameRule1.tr();
    } else if (!nameRegExp.hasMatch(value)) {
      return 'Enter a Valid Name';
    } else if (value.length < 3) {
      return LocaleKeys.auth_nameRule2.tr();
    }
    return null;
  }

  //<============================================= Simple field Validaor
  static String? validateSimpleFiled(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  //<============================================= Simple field Validaor
  static String? validateIntNumberField(String? value) {
    if (value == null || value.isEmpty) {
      return "Field is required";
    } else if (num.tryParse(value) == null) {
      return "$value is not valid";
    }
    return null;
  }
}
