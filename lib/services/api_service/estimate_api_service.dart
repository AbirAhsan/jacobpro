import 'package:service/model/estimate_grid_model.dart';
import 'package:service/model/estimation_details_model.dart';

import '../../app_config.dart';
import '../../model/service_and_material_item_model.dart';
import '../shared_data_manage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EstimateApiService {
  //<=============================================== Fetch Service And Material Item List
  Future<List<ServiceandMaterialItemModel?>> getServiceAndMaterialItemList(
      {String? searchStr, String? itemType}) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/GetLineItemsBySearch/$itemType?search=$searchStr&format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);

    var response = jsonDecode(respStr.body);

    if (respStr.statusCode == 200 && response["statusCode"] == 200) {
      var jsonResponse = respStr.body;
      var decoded = jsonDecode(jsonResponse);

      List<ServiceandMaterialItemModel?> mapdatalist = decoded['dataObj']
          .map<ServiceandMaterialItemModel?>(
              (b) => ServiceandMaterialItemModel.fromJson(b))
          .toList();

      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<=============================================== Fetch Customer Estimate List
  Future<List<EstimateGridModel?>> getCustomerEstimateList(
      {String? customerId}) async {
    String? token = await SharedDataManageService().getToken();

    Uri url =
        Uri.parse("${AppConfig.baseUrl}/Job/GetJobs/$customerId/E?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);

    var response = jsonDecode(respStr.body);

    if (respStr.statusCode == 200 && response["statusCode"] == 200) {
      var jsonResponse = respStr.body;
      var decoded = jsonDecode(jsonResponse);

      List<EstimateGridModel?> mapdatalist = decoded['dataObj']
          .map<EstimateGridModel?>((b) => EstimateGridModel.fromJson(b))
          .toList();

      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<=================== Create Estimate
  Future<String> createEstimate(
    String? customerId,
  ) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/AddEstimationByCustomer?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode({
      "CustomerId": customerId,
      "JobCategory": "E",
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);
    print(respStr);
    if (respStr.statusCode == 200) {
      return response["dataObj"];
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<=============================================== Fetch  Estimate Details
  Future<EstimateDetailsModel?> getEstimationDetails({String? jobUuid}) async {
    String? token = await SharedDataManageService().getToken();
    print(jobUuid);
    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/GetEstimateDetails/$jobUuid?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);

    var response = jsonDecode(respStr.body);

    if (respStr.statusCode == 200 && response["statusCode"] == 200) {
      var jsonResponse = respStr.body;

      var decoded = json.decode(jsonResponse);
      return EstimateDetailsModel.fromJson(decoded["dataObj"]);
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<=================== Add Estimate Service and Material Item
  Future<bool> addServiceAndMaterialItem(
      String? jobUuid,
      ServiceandMaterialItemModel serviceandMaterialItem,
      String? totalBill) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/AddLineItem/$jobUuid/$totalBill");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode(serviceandMaterialItem);

    request.headers.addAll(headers);

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

  //<=================== Delete Estimate Item
  Future<bool> deleteEstimateItem(String? jobUuid,
      ServiceandMaterialItemModel? item, String? totalBill) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/DeleteLineItem/$jobUuid/$totalBill?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode(item);

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);
    print(request.body);
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

  //<=================== Update Estimate Details
  Future<bool> updateEstimateDetails({
    String? jobUuid,
    String? subTotalBill,
    String? totalBill,
    String? discountType,
    String? jobDiscountRate,
    String? jobDiscountAmount,
    String? jobDiscountNote,
    int? jobTaxTypeId,
    String? jobTaxAmount,
  }) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/UpdateEstimationBill/$jobUuid");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode({
      "jobCalculatedBillAmount": subTotalBill ?? "0", // SUB Total
      "jobDiscountType": discountType, // P or F
      "jobDiscountRate": jobDiscountRate,
      "jobDiscountAmount": jobDiscountAmount, // calculated discount amount
      "jobDiscountNote": jobDiscountNote,
      "jobTaxTypeId": jobTaxTypeId,
      "jobTaxAmount": jobTaxAmount,
      "jobBillAmountBeforeAdjustment": 0, // N/A
      "jobBillAdjustmentAmount": 0, // N/A
      "jobFinalBillAmount": totalBill, // Final Bill
      "jobTotalPaidAmount": 0, // Paid Bill
      "jobTotalRemainAmount": 0 // Remain Bill
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);
    print(url);
    print(request.body);
    print(respStr.statusCode);
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
