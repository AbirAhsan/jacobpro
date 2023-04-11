import 'package:http/http.dart';
import 'package:service/model/job_grid_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../app_config.dart';
import '../error_code_handle_service.dart';
import '../shared_data_manage_service.dart';

class JobApiService {
  Future<List<JobGridDetailsModel?>> getMyPendingJobList() async {
    String? token = await SharedDataManageService().getToken();
    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Technician/GetJobsByTechnician/0/0?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    MultipartRequest request = http.MultipartRequest('GET', url);

    request.headers.addAll(headers);

    StreamedResponse streamedResponse = await request
        .send()
        .timeout(Duration(seconds: ApiErrorHandleService.timeOutDuration!));

    Response respStr = await http.Response.fromStream(streamedResponse);

    var response = json.decode(respStr.body);
    if (respStr.statusCode == 200) {
      var jsonResponse = respStr.body;
      var decoded = json.decode(jsonResponse);

      List<JobGridDetailsModel?> mapdatalist = decoded["dataObj"]
          .map<JobGridDetailsModel?>((b) => JobGridDetailsModel.fromJson(b))
          .toList();

      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future<bool> acceptOrRejectPendingJob(int? jobSystemId, int isAccept) async {
    String? token = await SharedDataManageService().getToken();
    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Technician/ConfirmJobAcceptByTechician/$jobSystemId/$isAccept?format=app");
    print(url);
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

    var response = jsonDecode(respStr.body);
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
