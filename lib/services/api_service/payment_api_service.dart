import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:service/model/payment_model.dart';
import 'dart:convert';

import '../../app_config.dart';
import '../shared_data_manage_service.dart';

class PaymentApiService {
  // AuthController authCtrl = Get.find<AuthController>();
  // LanguageController langCtrl = Get.put(LanguageController());
  //<===================================== Login Request
  Future<List> getOthersPaymentMethod() async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Payment/GetPaymentMethods/secondary?format=app");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', url);

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);

    var response = jsonDecode(respStr.body);

    if (respStr.statusCode == 200) {
      List mapdatalist = response['dataObj'].map((b) => (b)).toList();
      // print(mapdatalist);
      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<================ Submit Card Payment Method
  //
  Future<bool> submitCardPayment(PaymentDtoModel? paymentDetails,
      CardData cardDetails, String? jobUuid) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse("${AppConfig.baseUrl}/Payment/AddPayment/$jobUuid");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode({
      "paymentMethodId": paymentDetails!.paymentMethodId,
      "cardData": cardDetails,
      "chequeData": null,
      "paymentNote": paymentDetails.paymentNote,
      "paymentAmount": paymentDetails.paymentAmount,
    });

    request.headers.addAll(headers);
    print(request.body);
    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);
    print(response);
    if (respStr.statusCode == 200) {
      return true;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<================ Submit Cash Payment Method
  //
  Future<bool> submitCheckPayment(PaymentDtoModel paymentDetails) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse("${AppConfig.baseUrl}/Customer/AddCustomer");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode({
      "paymentMethodId": paymentDetails.paymentMethodId,
      "cardData": null,
      "chequeData": null,
      "paymentNote": paymentDetails.paymentNote,
      "paymentAmount": paymentDetails.paymentAmount,
    });

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
}
