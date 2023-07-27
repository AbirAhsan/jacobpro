class JobReportModel {
  int? jobSystemId;
  String? jobSystemNo;
  String? jobUuid;
  int? customerId;
  int? jobOptionId;
  String? customerDisplayName;
  String? customerCompanyName;
  String? customerJobTitle;
  String? customerEmail;
  String? customerAllEmailSeparatedByComma;
  String? customerContactNo;
  String? customerAddressStreetUnit;
  String? customerAddressCityStateCountry;
  String? jobAddress;
  String? insertedAt;
  String? jobScheduleStartDate;
  String? jobScheduleEndDate;
  String? coreServiceName;
  String? jobPrivateNote;
  String? jobCategory;
  int? jobAssociateCurrentStatus;
  bool? isEligibleForConvertToJob;
  List<JobItems>? jobItems;
  JobPriceCalculationDto? jobPriceCalculationDto;

  JobReportModel(
      {this.jobSystemId,
      this.jobSystemNo,
      this.jobUuid,
      this.jobOptionId,
      this.customerId,
      this.customerDisplayName,
      this.customerCompanyName,
      this.customerJobTitle,
      this.customerEmail,
      this.customerAllEmailSeparatedByComma,
      this.customerContactNo,
      this.customerAddressStreetUnit,
      this.customerAddressCityStateCountry,
      this.jobAddress,
      this.insertedAt,
      this.jobScheduleStartDate,
      this.jobScheduleEndDate,
      this.coreServiceName,
      this.jobPrivateNote,
      this.jobCategory,
      this.jobAssociateCurrentStatus,
      this.isEligibleForConvertToJob,
      this.jobItems,
      this.jobPriceCalculationDto});

  JobReportModel.fromJson(Map<String, dynamic> json) {
    jobSystemId = json['jobSystemId'];
    jobSystemNo = json['jobSystemNo'];
    jobUuid = json['jobUuid'];
    jobOptionId = json['jobOptionId'];
    customerId = json['customerId'];
    customerDisplayName = json['customerDisplayName'];
    customerCompanyName = json['customerCompanyName'];
    customerJobTitle = json['customerJobTitle'];
    customerEmail = json['customerEmail'];
    customerAllEmailSeparatedByComma = json['customerAllEmailSeparatedByComma'];
    customerContactNo = json['customerContactNo'];
    customerAddressStreetUnit = json['customerAddressStreetUnit'];
    customerAddressCityStateCountry = json['customerAddressCityStateCountry'];
    jobAddress = json['jobAddress'];
    insertedAt = json['insertedAt'];
    jobScheduleStartDate = json['jobScheduleStartDate'];
    jobScheduleEndDate = json['jobScheduleEndDate'];
    coreServiceName = json['coreServiceName'];
    jobPrivateNote = json['jobPrivateNote'];
    jobCategory = json['jobCategory'];
    jobAssociateCurrentStatus = json['jobAssociateCurrentStatus'];
    isEligibleForConvertToJob = json['isEligibleForConvertToJob'];
    if (json['jobItems'] != null) {
      jobItems = <JobItems>[];
      json['jobItems'].forEach((v) {
        jobItems!.add(JobItems.fromJson(v));
      });
    }
    jobPriceCalculationDto = json['jobPriceCalculationDto'] != null
        ? JobPriceCalculationDto.fromJson(json['jobPriceCalculationDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobSystemId'] = jobSystemId;
    data['jobSystemNo'] = jobSystemNo;
    data['jobUuid'] = jobUuid;
    data['customerId'] = customerId;
    data['jobOptionId'] = jobOptionId;
    data['customerDisplayName'] = customerDisplayName;
    data['customerCompanyName'] = customerCompanyName;
    data['customerJobTitle'] = customerJobTitle;
    data['customerEmail'] = customerEmail;
    data['customerAllEmailSeparatedByComma'] = customerAllEmailSeparatedByComma;
    data['customerContactNo'] = customerContactNo;
    data['customerAddressStreetUnit'] = customerAddressStreetUnit;
    data['customerAddressCityStateCountry'] = customerAddressCityStateCountry;
    data['jobAddress'] = jobAddress;
    data['insertedAt'] = insertedAt;
    data['jobScheduleStartDate'] = jobScheduleStartDate;
    data['jobScheduleEndDate'] = jobScheduleEndDate;
    data['coreServiceName'] = coreServiceName;
    data['jobPrivateNote'] = jobPrivateNote;
    data['jobAssociateCurrentStatus'] = jobAssociateCurrentStatus;
    data['jobCategory'] = jobCategory;
    data['isEligibleForConvertToJob'] = isEligibleForConvertToJob;
    if (jobItems != null) {
      data['jobItems'] = jobItems!.map((v) => v.toJson()).toList();
    }
    if (jobPriceCalculationDto != null) {
      data['jobPriceCalculationDto'] = jobPriceCalculationDto!.toJson();
    }
    return data;
  }
}

class JobItems {
  String? itemName;
  String? itemDescription;
  String? itemQty;
  String? itemUnitName;
  String? itemUnitPrice;
  String? itemSUBTotal;

  JobItems(
      {this.itemName,
      this.itemDescription,
      this.itemQty,
      this.itemUnitName,
      this.itemUnitPrice,
      this.itemSUBTotal});

  JobItems.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    itemQty = json['itemQty'].toString();
    itemUnitName = json['itemUnitName'];
    itemUnitPrice = json['itemUnitPrice'].toString();
    itemSUBTotal = json['itemSUBTotal'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemName'] = itemName;
    data['itemDescription'] = itemDescription;
    data['itemQty'] = itemQty;
    data['itemUnitName'] = itemUnitName;
    data['itemUnitPrice'] = itemUnitPrice;
    data['itemSUBTotal'] = itemSUBTotal;
    return data;
  }
}

class JobPriceCalculationDto {
  String? jobCalculatedBillAmount;
  String? jobDiscountType;
  String? jobDiscountRate;
  String? jobDiscountAmount;
  String? jobDiscountNote;
  int? jobTaxTypeId;
  String? jobTaxAmount;
  String? jobBillAmountBeforeAdjustment;
  String? jobBillAdjustmentAmount;
  String? jobFinalBillAmount;
  String? jobTotalPaidAmount;
  String? jobTotalRemainAmount;

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
    jobCalculatedBillAmount = json['jobCalculatedBillAmount'].toString();
    jobDiscountType = json['jobDiscountType'];
    jobDiscountRate = json['jobDiscountRate'].toString();
    jobDiscountAmount = json['jobDiscountAmount'].toString();
    jobDiscountNote = json['jobDiscountNote'];
    jobTaxTypeId = json['jobTaxTypeId'];
    jobTaxAmount = json['jobTaxAmount'].toString();
    jobBillAmountBeforeAdjustment =
        json['jobBillAmountBeforeAdjustment'].toString();
    jobBillAdjustmentAmount = json['jobBillAdjustmentAmount'].toString();
    jobFinalBillAmount = json['jobFinalBillAmount'].toString();
    jobTotalPaidAmount = json['jobTotalPaidAmount'].toString();
    jobTotalRemainAmount = json['jobTotalRemainAmount'].toString();
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
