class EstimateGridModel {
  int? jobSystemId;
  String? jobUuid;
  int? jobOptionId;
  String? jobSystemNo;
  String? jobScheduleStartDate;
  String? billingCustomerDisplayName;
  String? jobAddress;
  String? leadSourceName;
  String? jobFinalBillAmount;
  String? statusName;
  String? statusRelatedName;
  String? jobPrivateNote;
  String? jobTag;

  EstimateGridModel(
      {this.jobSystemId,
      this.jobUuid,
      this.jobOptionId,
      this.jobSystemNo,
      this.jobScheduleStartDate,
      this.billingCustomerDisplayName,
      this.jobAddress,
      this.leadSourceName,
      this.jobFinalBillAmount,
      this.statusName,
      this.statusRelatedName,
      this.jobPrivateNote,
      this.jobTag});

  EstimateGridModel.fromJson(Map<String, dynamic> json) {
    jobSystemId = json['jobSystemId'];
    jobUuid = json['jobUuid'];
    jobOptionId = json['jobOptionId'];
    jobSystemNo = json['jobSystemNo'];
    jobScheduleStartDate = json['jobScheduleStartDate'];
    billingCustomerDisplayName = json['billingCustomerDisplayName'];
    jobAddress = json['jobAddress'];
    leadSourceName = json['leadSourceName'];
    jobFinalBillAmount = json['jobFinalBillAmount'].toString();
    statusName = json['statusName'];
    statusRelatedName = json['statusRelatedName'];
    jobPrivateNote = json['jobPrivateNote'];
    jobTag = json['jobTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobSystemId'] = jobSystemId;
    data['jobUuid'] = jobUuid;
    data['jobOptionId'] = jobOptionId;
    data['jobSystemNo'] = jobSystemNo;
    data['jobScheduleStartDate'] = jobScheduleStartDate;
    data['billingCustomerDisplayName'] = billingCustomerDisplayName;
    data['jobAddress'] = jobAddress;
    data['leadSourceName'] = leadSourceName;
    data['jobFinalBillAmount'] = jobFinalBillAmount;
    data['statusName'] = statusName;
    data['statusRelatedName'] = statusRelatedName;
    data['jobPrivateNote'] = jobPrivateNote;
    data['jobTag'] = jobTag;
    return data;
  }
}
