import 'service_and_material_item_model.dart';

class EstimateDetailsModel {
  JobDto? jobDto;
  List<ServiceandMaterialItemModel>? lineItems;

  EstimateDetailsModel({this.jobDto, this.lineItems});

  EstimateDetailsModel.fromJson(Map<String, dynamic> json) {
    jobDto = json['jobDto'] != null ? JobDto.fromJson(json['jobDto']) : null;
    if (json['lineItems'] != null) {
      lineItems = <ServiceandMaterialItemModel>[];
      json['lineItems'].forEach((v) {
        lineItems!.add(ServiceandMaterialItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobDto != null) {
      data['jobDto'] = jobDto!.toJson();
    }
    if (lineItems != null) {
      data['lineItems'] = lineItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobDto {
  int? jobSystemId;
  String? jobSystemNo;
  String? jobUuid;
  int? customerId;
  String? jobScheduleStartDate;
  String? jobScheduleEndDate;
  String? jobPrivateNote;
  int? jobTypeId;
  int? jobBusinessUnitId;
  String? jobTypeName;
  String? businessUnitName;
  String? jobTag;
  int? jobLeadSourceId;
  int? jobCallbackCount;
  String? jobCallbackRelatedJobSystemId;
  String? jobAddress;
  String? jobCategory;
  int? jobCustomerConfirmationStatus;
  bool? isEligibleForConvertToJob;
  String? jobScheduleStartDateInText;
  String? jobScheduleEndDateInText;

  JobDto(
      {this.jobSystemId,
      this.jobSystemNo,
      this.jobUuid,
      this.customerId,
      this.jobScheduleStartDate,
      this.jobScheduleEndDate,
      this.jobPrivateNote,
      this.jobTypeId,
      this.jobBusinessUnitId,
      this.jobTypeName,
      this.businessUnitName,
      this.jobTag,
      this.jobLeadSourceId,
      this.jobCallbackCount,
      this.jobCallbackRelatedJobSystemId,
      this.jobAddress,
      this.jobCategory,
      this.jobCustomerConfirmationStatus,
      this.isEligibleForConvertToJob,
      this.jobScheduleStartDateInText,
      this.jobScheduleEndDateInText});

  JobDto.fromJson(Map<String, dynamic> json) {
    jobSystemId = json['jobSystemId'];
    jobSystemNo = json['jobSystemNo'];
    jobUuid = json['jobUuid'];
    customerId = json['customerId'];
    jobScheduleStartDate = json['jobScheduleStartDate'];
    jobScheduleEndDate = json['jobScheduleEndDate'];
    jobPrivateNote = json['jobPrivateNote'];
    jobTypeId = json['jobTypeId'];
    jobBusinessUnitId = json['jobBusinessUnitId'];
    jobTypeName = json['jobTypeName'];
    businessUnitName = json['businessUnitName'];
    jobTag = json['jobTag'];
    jobLeadSourceId = json['jobLeadSourceId'];
    jobCallbackCount = json['jobCallbackCount'];
    jobCallbackRelatedJobSystemId = json['jobCallbackRelatedJobSystemId'];
    jobAddress = json['jobAddress'];
    jobCategory = json['jobCategory'];
    jobCustomerConfirmationStatus = json['jobCustomerConfirmationStatus'];
    isEligibleForConvertToJob = json['isEligibleForConvertToJob'];
    jobScheduleStartDateInText = json['jobScheduleStartDateInText'];
    jobScheduleEndDateInText = json['jobScheduleEndDateInText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobSystemId'] = jobSystemId;
    data['jobSystemNo'] = jobSystemNo;
    data['jobUuid'] = jobUuid;
    data['customerId'] = customerId;
    data['jobScheduleStartDate'] = jobScheduleStartDate;
    data['jobScheduleEndDate'] = jobScheduleEndDate;
    data['jobPrivateNote'] = jobPrivateNote;
    data['jobTypeId'] = jobTypeId;
    data['jobBusinessUnitId'] = jobBusinessUnitId;
    data['jobTypeName'] = jobTypeName;
    data['businessUnitName'] = businessUnitName;
    data['jobTag'] = jobTag;
    data['jobLeadSourceId'] = jobLeadSourceId;
    data['jobCallbackCount'] = jobCallbackCount;
    data['jobCallbackRelatedJobSystemId'] = jobCallbackRelatedJobSystemId;
    data['jobAddress'] = jobAddress;
    data['jobCategory'] = jobCategory;
    data['jobCustomerConfirmationStatus'] = jobCustomerConfirmationStatus;
    data['isEligibleForConvertToJob'] = isEligibleForConvertToJob;
    data['jobScheduleStartDateInText'] = jobScheduleStartDateInText;
    data['jobScheduleEndDateInText'] = jobScheduleEndDateInText;
    return data;
  }
}
