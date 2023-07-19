import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../app_config.dart';
import '../../model/technician_profile_model.dart';

class AuthApiService {
  // AuthController authCtrl = Get.find<AuthController>();
  // LanguageController langCtrl = Get.put(LanguageController());
  //<===================================== Login Request
  Future loginRequest(
      String? userName, String? password, String? fcmToken) async {
    // String? fcmToken = await NotificationController().getFcmToken();

    Uri url = Uri.parse("${AppConfig.baseUrl}/Auth/Login");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', url);

    request.body = json.encode({
      "username": userName,
      "userPassword": password,
    });

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);
    Map response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return response;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future<Map> findUser(String? userName) async {
    // String? fcmToken = await NotificationController().getFcmToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Emp/GetEmpBasicDataByUsername/$userName");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', url);

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);
    Map response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return response;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future<bool?> sendOtpRequestToMail(
    String? email,
  ) async {
    Uri url = Uri.parse("${AppConfig.baseUrl}/email/sendemail/reg_otp/$email");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', url);

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);

    var response = jsonDecode(respStr.body);
    print(respStr.statusCode);
    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return true;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future<bool?> sendForgetOtpRequestToMail(
    String? email,
  ) async {
    Uri url = Uri.parse("${AppConfig.baseUrl}/email/sendemail/otp/$email");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', url);

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);

    var response = jsonDecode(respStr.body);

    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return true;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future<bool> sendOtpRequestToPhone(
    String? phone,
  ) async {
    Uri url = Uri.parse("${AppConfig.baseUrl}/Sms/SendSms");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', url);

    request.headers.addAll(headers);
    request.body = json.encode({
      "smsBody": "",
      "smsSendTo": phone,
      "smsType": "reg_otp",
    });

    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return true;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future<bool> sendForgetOtpRequestToPhone(
    String? phone,
  ) async {
    Uri url = Uri.parse("${AppConfig.baseUrl}/Sms/SendSms");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', url);

    request.headers.addAll(headers);
    request.body = json.encode({
      "smsBody": "",
      "smsSendTo": phone,
      "smsType": "otp",
    });

    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return true;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  static Future<bool> verifyOtp({
    String? otp,
    String? userName,
  }) async {
    Uri url =
        Uri.parse("${AppConfig.baseUrl}/Technician/VerifyOtp/$otp/$userName");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', url);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);
    if (respStr.statusCode == 200) {
      return true;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future registrationRequest(
      {String? userName, ProfileGeneralData? profileData}) async {
    // String? fcmToken = await NotificationController().getFcmToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Technician/RegisterTechnician/$userName/${profileData!.userMail}?format=app");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', url);

    request.body = json.encode({
      "userFirstName": profileData.userFirstName,
      "userLastName": profileData.userLastName,
      "userAddress": "",
      "userContactNo": profileData.userContactNo,
      "userMail": profileData.userMail,
      "userVerificationStatus": 0,
      "workingMode": 0
    });

    debugPrint(request.body);
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);
    debugPrint(url.toString());
    debugPrint(response.toString());
    debugPrint("Code ${respStr.statusCode}");
    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return response;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future resetPasswordRequest(
      {String? userName, String? userSystemId, String? password}) async {
    // String? fcmToken = await NotificationController().getFcmToken();

    Uri url = Uri.parse("${AppConfig.baseUrl}/Emp/ResetPassword");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', url);

    request.body = json.encode({
      "userSystemId": int.parse(userSystemId!),
      "userName": userName,
      "currentPassword": null,
      "newPassword": password,
      "isReset": true
    });

    debugPrint(request.body);
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);
    debugPrint("Code ${respStr.statusCode}");
    var response = json.decode(jsonEncode(respStr.body));

    debugPrint(response.toString());
    debugPrint("Code ${respStr.statusCode}");
    if (respStr.statusCode == 200) {
      debugPrint(response.toString());

      return response;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }
}
