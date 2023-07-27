import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:service/model/payment_model.dart';
import 'dart:convert';

import '../../app_config.dart';
import '../../model/job_payment_summery_model.dart';
import '../../model/payment_invoice_model.dart';
import '../shared_data_manage_service.dart';

class PaymentApiService {
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
  Future<bool> submitCashPayment(
      PaymentDtoModel paymentDetails, String? jobUuid) async {
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

  //<================ Submit Cheque Payment Method
  //
  Future<bool> submitChequePayment(PaymentDtoModel paymentDetails,
      ChequeData chequeDetails, String? jobUuid) async {
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
      "paymentMethodId": paymentDetails.paymentMethodId,
      "cardData": null,
      "chequeData": chequeDetails,
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

  //<================ Submit Other Payment Method
  //
  Future<bool> submitOtherPayment(
      PaymentDtoModel paymentDetails, String? jobUuid) async {
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

  //<============================= Get Job Payment Summery
  Future<JobPaymentSummeryModel> getJobPaymentSummery(
      int? jobServicceId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Job/GetJobPaymentSummery/$jobServicceId/0?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('GET', url);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);

    var response = json.decode(respStr.body);
    print(url);
    if (respStr.statusCode == 200) {
      var jsonResponse = respStr.body;

      var decoded = json.decode(jsonResponse);

      return JobPaymentSummeryModel.fromJson(decoded["dataObj"]);
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<=========== Get Saved Card List
  Future<List<CardData>> getSavedCardList(int? customerId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Customer/GetCustomerCardsWithDetails/$customerId?format=app");

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
      List<CardData> mapdatalist = response['dataObj']
          .map<CardData>((b) => CardData.fromJson(b))
          .toList();
      // print(mapdatalist);
      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<=========== Get Payment Invoice List
  Future<List<PaymentInvoiceModel>> getPaymentInvoiceList(
      int? jobSystemId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Job/GetJobPaymentSummery/$jobSystemId/X?format=app");

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', url);
    print(url);
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var respStr = await http.Response.fromStream(streamedResponse);

    var response = jsonDecode(respStr.body);

    if (respStr.statusCode == 200) {
      List<PaymentInvoiceModel> mapdatalist = response['dataObj']['jobPayments']
          .map<PaymentInvoiceModel>((b) => PaymentInvoiceModel.fromJson(b))
          .toList();
      // print(mapdatalist);
      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }
}
