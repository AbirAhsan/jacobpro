// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_EN = {
  "app_details": {
    "name": "Jacob Pro",
    "developedBy": "A product of {}"
  },
  "auth": {
    "login": "Log In",
    "signup": "Sign Up",
    "forgot_password": "Forgot Password ?",
    "userName": "User Name",
    "userNameRule1": "Please Enter Your User Name",
    "userNameRule2": "User name is not valid",
    "nameRule1": "Enter Your Name",
    "nameRule2": "Enter a Valid Name",
    "enterUserName": "Enter Your User Name",
    "phoneNumber": "Phone Number",
    "phoneNumberRule1": "Please Enter Your Mobile Number",
    "phoneNumberRule2": "Mobile number is not valid",
    "password": "Password",
    "enterYourPassword": "Enter Your Password",
    "confirm_password": "Confirm Password",
    "passwordRule1": "Please Enter Your Password",
    "passwordRule2": "Password must not be less than 4 characters",
    "passwordRule3": "Password is not matched",
    "orUse": "Or Use",
    "note": "By logging you agree to our",
    "and": "and",
    "terms": "Terms of Service",
    "privacy": "Privacy Policy",
    "dontHaveAccount": "Don't have an account ?",
    "alreadyHaveAccount": "Already have an account ?",
    "name": "Name",
    "firstName": "First Name",
    "lastName": "Last Name",
    "email ": "Email",
    "emailRule1": "Please  Your Email Address",
    "emailRule2": "Email address is not valid",
    "loginWelcome": "Welcome {}, to Jacob Pro"
  },
  "extra": {
    "warning": "Warning",
    "pleaseWait": "Please Wait",
    "noInternet": "Slow or no internet Conncetion\nCheck Your Internet settings and try again",
    "picTimeSlot": "Please Pick a Time from available date",
    "confirm": "Confirm",
    "close": "Close"
  },
  "notification": {
    "title": "Notifications"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_EN": en_EN};
}
