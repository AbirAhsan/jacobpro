import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

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
    // String? pattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regex = RegExp(pattern);

    if (value!.isEmpty) {
      return LocaleKeys.auth_phoneNumberRule1.tr();
    } else if (!value.isPhoneNumber) {
      return LocaleKeys.auth_phoneNumberRule2.tr();
    } else if (value.length != 10) {
      return "Phone number must be 10 digits";
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

  //<============================================= Simple field Validaor 2
  static String? validateSimpleFiled2(String? value) {
    if (value == null || value.isEmpty) {
      return "";
    }
    return null;
  }

//<============================================= Month field Validaor
  static String? validateMonth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a month';
    }

    final int? month = int.tryParse(value);
    if (month == null || month < 1 || month > 12) {
      return 'Invalid month';
    }

    return null; // Return null if the input is valid
  }

//<============================================= Year field Validator
  static String? validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a year';
    }

    if (value.length < 2) {
      return 'Invalid year';
    }

    return null; // Return null if the input is valid
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

  //<============================================= Simple Dropdown Validaor
  static String? validateDropdown(value) {
    if (value == null) {
      return 'Please select an option';
    }
    return null;
  }
}
