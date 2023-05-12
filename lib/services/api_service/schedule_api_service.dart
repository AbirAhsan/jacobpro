import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:service/model/schedule_data_model.dart';
import 'dart:convert';

import '../../app_config.dart';
import '../shared_data_manage_service.dart';

class ScheduleApiService {
  //<============================= Get Schedule List
  static Future<List<ScheduleDataModel?>> getScheduleList(
      String? firstDate) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Schedule/GetSchedules/2023-05-12/7?format=app");

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
      var decoded = jsonDecode(jsonResponse.toString());

      List<ScheduleDataModel?> mapdatalist = decoded['dataObj']
          .map<ScheduleDataModel?>((b) => ScheduleDataModel.fromJson(b))
          .toList();

      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }
}
