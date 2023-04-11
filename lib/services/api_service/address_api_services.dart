import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../app_config.dart';
import '../../model/address_model.dart';
import '../error_code_handle_service.dart';
import '../shared_data_manage_service.dart';

class AddressApiService {
  // AuthController authCtrl = Get.find<AuthController>();
  // LanguageController langCtrl = Get.put(LanguageController());
  //<===================================== Login Request
  Future<List> getAddressList(
    String? searchStr,
  ) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Address/GetAutoCompleteAddressList?search=$searchStr");

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
      List mapdatalist = response.map((b) => (b)).toList();
      // print(mapdatalist);
      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //
  Future<AddressModel?> getAddressDetails(String? address) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Address/GetAddressDetails?address=$address");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    var streamedResponse = await request
        .send()
        .timeout(Duration(seconds: ApiErrorHandleService.timeOutDuration!));

    var respStr = await http.Response.fromStream(streamedResponse);
    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      var jsonResponse = respStr.body;

      var decoded = json.decode(jsonResponse);

      return AddressModel.fromJson(decoded);
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }
}
