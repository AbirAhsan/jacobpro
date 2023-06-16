import 'service_and_material_item_model.dart';

class EstimateDetailsModel {
  JobDto? jobDto;
  JobPriceCalculationDto? jobPriceCalculationDto;
  List<ServiceandMaterialItemModel>? lineItems;

  EstimateDetailsModel({this.jobDto, this.lineItems});

  EstimateDetailsModel.fromJson(Map<String, dynamic> json) {
    jobDto = json['jobDto'] != null ? JobDto.fromJson(json['jobDto']) : null;
    jobPriceCalculationDto = json['jobPriceCalculationDto'] != null
        ? JobPriceCalculationDto.fromJson(json['jobPriceCalculationDto'])
        : null;
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
    if (jobPriceCalculationDto != null) {
      data['jobPriceCalculationDto'] = jobPriceCalculationDto!.toJson();
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

//
class JobPriceCalculationDto {
  double? jobCalculatedBillAmount;
  String? jobDiscountType;
  double? jobDiscountRate;
  double? jobDiscountAmount;
  String? jobDiscountNote;
  int? jobTaxTypeId;
  double? jobTaxAmount;
  double? jobBillAmountBeforeAdjustment;
  double? jobBillAdjustmentAmount;
  double? jobFinalBillAmount;
  double? jobTotalPaidAmount;
  double? jobTotalRemainAmount;

  JobPriceCalculationDto(
      {this.jobCalculatedBillAmount,
      this.jobDiscountType,
      this.jobDiscountRate,
      this.jobDiscountAmount,
      this.jobDiscountNote,
      this.jobTaxTypeId,
      this.jobTaxAmount,
      this.jobBillAmountBeforeAdjustment,
      this.jobBillAdjustmentAmount,
      this.jobFinalBillAmount,
      this.jobTotalPaidAmount,
      this.jobTotalRemainAmount});

  JobPriceCalculationDto.fromJson(Map<String, dynamic> json) {
    jobCalculatedBillAmount =
        double.tryParse("${json['jobCalculatedBillAmount'] ?? 0.0}");
    jobDiscountType = json['jobDiscountType'];
    jobDiscountRate = double.tryParse("${json['jobDiscountRate'] ?? 0.0}");
    jobDiscountAmount = double.tryParse("${json['jobDiscountRate'] ?? 0.0}");
    json['jobDiscountAmount'];
    jobDiscountNote = json['jobDiscountNote'];
    jobTaxTypeId = json['jobTaxTypeId'];
    jobTaxAmount = double.tryParse("${json['jobTaxAmount'] ?? 0.0}");
    jobBillAmountBeforeAdjustment =
        double.tryParse("${json['jobBillAmountBeforeAdjustment'] ?? 0.0}");
    jobBillAdjustmentAmount =
        double.tryParse("${json['jobBillAdjustmentAmount'] ?? 0.0}");
    jobFinalBillAmount =
        double.tryParse("${json['jobFinalBillAmount'] ?? 0.0}");
    jobTotalPaidAmount =
        double.tryParse("${json['jobTotalPaidAmount'] ?? 0.0}");
    jobTotalRemainAmount =
        double.tryParse("${json['jobTotalRemainAmount'] ?? 0.0}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobCalculatedBillAmount'] = jobCalculatedBillAmount;
    data['jobDiscountType'] = jobDiscountType;
    data['jobDiscountRate'] = jobDiscountRate;
    data['jobDiscountAmount'] = jobDiscountAmount;
    data['jobDiscountNote'] = jobDiscountNote;
    data['jobTaxTypeId'] = jobTaxTypeId;
    data['jobTaxAmount'] = jobTaxAmount;
    data['jobBillAmountBeforeAdjustment'] = jobBillAmountBeforeAdjustment;
    data['jobBillAdjustmentAmount'] = jobBillAdjustmentAmount;
    data['jobFinalBillAmount'] = jobFinalBillAmount;
    data['jobTotalPaidAmount'] = jobTotalPaidAmount;
    data['jobTotalRemainAmount'] = jobTotalRemainAmount;
    return data;
  }
}
