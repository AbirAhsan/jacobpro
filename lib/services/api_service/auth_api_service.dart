import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../app_config.dart';

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
      "username": "dev",
      "userPassword": "1234",
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
}
