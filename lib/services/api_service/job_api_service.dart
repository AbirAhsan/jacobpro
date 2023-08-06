import 'package:http/http.dart';
import 'package:service/model/job_grid_model.dart';
import 'package:http/http.dart' as http;
import 'package:service/model/job_life_cycle_model.dart';
import 'package:service/model/job_report_model.dart';
import 'dart:convert';

import '../../app_config.dart';
import '../error_code_handle_service.dart';
import '../shared_data_manage_service.dart';

class JobApiService {
  //<======================== Get Pending Job List
  Future<List<JobGridDetailsModel?>> getJobList(int offset, int status) async {
    String? token = await SharedDataManageService().getToken();
    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Technician/GetJobsByTechnician/0/$status/$offset/10?format=app");

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
    if (status == 2) {
      print("Offset is $offset");
      print("url is $url");
      print(" Response is $response");
    }

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

  //<===================================== Get Single Consutant Details
  Future<JobReportModel> getJobReortDetails(
      String? jobUuid, String? jobOptionId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/GetEstimateReportData/$jobUuid/$jobOptionId?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.MultipartRequest('GET', url);
    print("Report data is $url ");
    request.headers.addAll(headers);

    var streamedResponse = await request
        .send()
        .timeout(Duration(seconds: ApiErrorHandleService.timeOutDuration!));

    var respStr = await http.Response.fromStream(streamedResponse);

    var response = json.decode(respStr.body);
    if (respStr.statusCode == 200 && response["message"] == "Success") {
      var jsonResponse = respStr.body;

      var decoded = json.decode(jsonResponse);
      return JobReportModel.fromJson(decoded["dataObj"]);
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<===================================== Get Job LifeCycle
  Future<List<JobLifeCycleModel?>> getJobLifeCycle(
      String? jobUuid, String? jobOptionId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Estimate/GetEstimationLifecycles/$jobUuid/$jobOptionId?format=app");
    print("Job UIUID $jobUuid");
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
    print("Request  is $url");
    var response = json.decode(respStr.body);
    if (respStr.statusCode == 200 && response["message"] == "Success") {
      var jsonResponse = respStr.body;
      var decoded = json.decode(jsonResponse);

      print("Response is $jsonResponse");
      List<JobLifeCycleModel?> mapdatalist = decoded["dataObj"]
          .map<JobLifeCycleModel?>((b) => JobLifeCycleModel.fromJson(b))
          .toList();

      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  Future<bool> goJobNextLifeCycle(int? jobSystemId, int lifeCycleId) async {
    String? token = await SharedDataManageService().getToken();
    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Lifecycle/AddNextLifecycleStep/$jobSystemId/$lifeCycleId?format=app");
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

  //<================== Lifecycle declare start
  Future<bool> lifeCycleDeclareStart(String? jobUuid, String? optionId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url =
        Uri.parse("${AppConfig.baseUrl}/Lifecycle/DeclareStart?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode({
      "jobUuid": jobUuid,
      "optionId": optionId,
      "applicableOn": DateTime.now().toUtc().toIso8601String(),
      "applicableOnInText": DateTime.now().toUtc().toIso8601String(),
      "isNotifyCustomer": true
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

  //<================== Lifecycle ON My Way
  Future<bool> lifeCycleOnMyway(String? jobUuid, String? optionId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url =
        Uri.parse("${AppConfig.baseUrl}/Lifecycle/DeclareOnMyWay?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode({
      "jobUuid": jobUuid,
      "optionId": optionId,
      "applicableOn": DateTime.now().toUtc().toIso8601String(),
      "applicableOnInText": DateTime.now().toUtc().toIso8601String(),
      "isNotifyCustomer": true
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

  //<================== Lifecycle Finished
  Future<bool> lifeCycleFinished(String? jobUuid, String? optionId) async {
    String? token = await SharedDataManageService().getToken();

    Uri url =
        Uri.parse("${AppConfig.baseUrl}/Lifecycle/DeclareFinished?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);

    request.body = json.encode({
      "jobUuid": jobUuid,
      "optionId": optionId,
      "applicableOn": DateTime.now().toUtc().toIso8601String(),
      "applicableOnInText": DateTime.now().toUtc().toIso8601String(),
      "isNotifyCustomer": true
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

  getJobCountList() async {
    String? token = await SharedDataManageService().getToken();
    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Technician/CountJobByAssociateStatus/0?format=app");

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
    print("Job count is $response");
    if (respStr.statusCode == 200) {
      var jsonResponse = respStr.body;
      var decoded = json.decode(jsonResponse);

      List mapdatalist = decoded["dataObj"].map((b) => (b)).toList();

      return mapdatalist;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }
}
