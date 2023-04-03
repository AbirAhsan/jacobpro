import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:service/model/technician_profile_model.dart';
import 'dart:convert';

import '../../app_config.dart';
import '../../model/skill_model.dart';
import '../shared_data_manage_service.dart';

class ProfileApiService {
//<============================= Get Own Profile Details
  static Future<TechnicianProfileModel> getMyProfileDetails() async {
    String? token = await SharedDataManageService().getToken();

    Uri url =
        Uri.parse("${AppConfig.baseUrl}/Emp/GetTechnicianProfile/0?format=app");

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
      return TechnicianProfileModel.fromJson(decoded["dataObj"]);
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<============================= Get Own Profile Skill
  static Future<List<SkillDataModel?>> getMyProfileSkill() async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse("${AppConfig.baseUrl}/Skill/GetSkills?format=app");

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
      var decoded = jsonDecode(jsonResponse);

      List<SkillDataModel?> mapdatalist = decoded['dataObj']
          .map<SkillDataModel?>((b) => SkillDataModel.fromJson(b))
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

//<============================= Get Own Profile Details
  static Future<String?> uploadUserFile(String? imagePath, int? docType) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Emp/UploadUserProfileDocument/$docType?mimeType=${lookupMimeType(imagePath!)}&app=format");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('iFile', imagePath));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);

    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200) {
      var jsonResponse = respStr.body;

      var decoded = json.decode(jsonResponse);
      return decoded["fileName"];
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }

  //<============================= Update Own Profile Details
  static Future<bool> updateOwnProfile(TechnicianProfileModel? profileDetails,
      List<String?> profileDocExpiryDateList) async {
    String? token = await SharedDataManageService().getToken();

    Uri url = Uri.parse(
        "${AppConfig.baseUrl}/Emp/UpdateTechnicianProfile/0?format=app");

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    var request = http.Request('POST', url);
    request.headers.addAll(headers);
    request.body = json.encode({
      "profileGeneralData": profileDetails!.profileGeneralData,
      "profileEmergencyContactData": profileDetails.profileEmergencyContactData,
      "profileSkillIdList": profileDetails.profileSkillData!.profileSkillIdList,
      "profileOtherSkill": profileDetails.profileSkillData?.profileOtherSkill,
      "ProfileDocExpiryDateList": profileDocExpiryDateList
    });

    var streamedResponse = await request.send();

    var respStr = await http.Response.fromStream(streamedResponse);

    var response = json.decode(respStr.body);

    if (respStr.statusCode == 200 && response['statusCode'] == 200) {
      return true;
    } else {
      throw {
        "code": respStr.statusCode,
        "message": response["message"],
      };
    }
  }
}
