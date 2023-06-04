import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:service/model/customer_details_model.dart';
import 'package:service/model/customer_model.dart';
import 'dart:convert';

import '../../app_config.dart';
import '../../model/service_item_model.dart';
import '../shared_data_manage_service.dart';

class CustomerApiService {
  //
  Future<bool> addNewCustomer(
      String? firstName,
      String? lastName,
      String? displayName,
      String? customerNote,
      String? email,
      String? mobile,
      String? address,
      String? addressUnit,
      String? addressCity,
      String? addressState,
      String? addressPostCode,
      String? addressLat,
      String? addressLong) async {
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
      "customerDto": {
        "customerId": 0,
        "customerFirstName": "$firstName",
        "customerLastName": "$lastName",
        "customerDisplayName": "$displayName",
        "customerCompanyName": "",
        "customerJobTitle": "",
        "customerNotes": "$customerNote",
        "customerTags": "",
        "customerLeadSourceId": 0,
        "customerBillsToCustomerId": 0,
        "isNotify": true
      },
      "customerEmails": [
        {"customerEmail": "$email", "customerMailIsDefault": true}
      ],
      "customerContacts": [
        {
          "customerContactNo": "$mobile",
          "customerContactNote": "",
          "customerContactIsDefault": true
        }
      ],
      "customerAddresses": [
        {
          "customerAddressId": 0,
          "customerAddressStreet": "$address",
          "customerAddressUnit": "$addressUnit",
          "customerAddressCity": "$addressCity",
          "customerAddressState": "$addressState",
          "customerAddressZip": "$addressPostCode",
          "customerAddressName": "",
          "customerAddressNotes": "",
          "customerAddressLat": "$addressLat",
          "customerAddressLong": "$addressLong",
          "customerAddressBillingStatus": true
        }
      ]
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

  //<============================= Feetch Customer Lis
  Future<List<CustomerInfoModel?>> getCustomerList(String searchString) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Customer/GetCustomers?search=$searchString");

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

    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      var jsonResponse = respStr.body;
      var decoded = jsonDecode(jsonResponse) as List<dynamic>;

      List<CustomerInfoModel?> mapdatalist = decoded
          .map<CustomerInfoModel?>((b) => CustomerInfoModel.fromJson(b))
          .toList();
      // List<CustomerInfoModel?> mapdatalist =
      //     decoded.map((b) => CustomerInfoModel.fromJson(b)).toList();

      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<============================= Get Customer Details
  Future<CustomerDetailsModel> getCustomerDetails(String? customerId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Customer/GetCustomerDetails/$customerId?format=app");

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

    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      var jsonResponse = respStr.body;

      var decoded = json.decode(jsonResponse);
      print(decoded);
      return CustomerDetailsModel.fromJson(decoded["dataObj"]);
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<=============================================== Fetch Service Item Details
  Future<ServiceItemModel?> getServiceDetails(int? serviceId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Service/GetServiceDetails/$serviceId?format=app");

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

    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200 && response["statusCode"] == 200) {
      var jsonResponse = respStr.body;
      var decoded = jsonDecode(jsonResponse);

      return ServiceItemModel.fromJson(decoded["dataObj"]);
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  // //<=============================================== Fetch Material Item Details
  // Future<MaterialItemModel?> getMaterialDetails(int? materialId) async {
  //   String? token = await SharedDataManageService().getToken();

  //   Uri url = Uri.parse(
  //       "${AppConfig.baseUrl}/Material/GetMaterialDetails/$materialId?format=app");

  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json;charset=UTF-8',
  //     'Charset': 'utf-8'
  //   };
  //   var request = http.MultipartRequest('GET', url);

  //   request.headers.addAll(headers);

  //   var streamedResponse = await request.send();

  //   var respStr = await http.Response.fromStream(streamedResponse);

  //   var response = jsonDecode(respStr.body);

  //   if (respStr.statusCode == 200 && response["statusCode"] == 200) {
  //     var jsonResponse = respStr.body;
  //     var decoded = jsonDecode(jsonResponse);

  //     return MaterialItemModel.fromJson(decoded["dataObj"]);
  //   } else {
  //     throw {
  //       "code": respStr.statusCode,
  //       "message": response["message"],
  //     };
  //   }
  // }
}
