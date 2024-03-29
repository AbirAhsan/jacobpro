class JobGridDetailsModel {
  int? jobSystemId;
  String? jobUuid;
  int? jobOptionId;
  String? jobSystemNo;
  String? customerDisplayName;
  String? customerCompanyName;
  String? customerJobTitle;
  String? customerEmail;
  String? customerContactNo;
  String? jobAddress;
  String? jobAddressLat;
  String? jobAddressLong;
  String? jobScheduleStartDate;
  String? jobScheduleEndDate;
  String? coreServiceName;
  String? jobPrivateNote;

  JobGridDetailsModel(
      {this.jobSystemId,
      this.jobUuid,
      this.jobOptionId,
      this.jobSystemNo,
      this.customerDisplayName,
      this.customerCompanyName,
      this.customerJobTitle,
      this.customerEmail,
      this.customerContactNo,
      this.jobAddress,
      this.jobAddressLat,
      this.jobAddressLong,
      this.jobScheduleStartDate,
      this.jobScheduleEndDate,
      this.coreServiceName,
      this.jobPrivateNote});

  JobGridDetailsModel.fromJson(Map<String, dynamic> json) {
    jobSystemId = json['jobSystemId'];
    jobUuid = json['jobUuid'];
    jobOptionId = json['jobOptionId'];
    jobSystemNo = json['jobSystemNo'];
    customerDisplayName = json['customerDisplayName'];
    customerCompanyName = json['customerCompanyName'];
    customerJobTitle = json['customerJobTitle'];
    customerEmail = json['customerEmail'];
    customerContactNo = json['customerContactNo'];
    jobAddress = json['jobAddress'];
    jobAddressLat = json['jobAddressLat'];
    jobAddressLong = json['jobAddressLong'];
    jobScheduleStartDate = json['jobScheduleStartDate'];
    jobScheduleEndDate = json['jobScheduleEndDate'];
    coreServiceName = json['coreServiceName'];
    jobPrivateNote = json['jobPrivateNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobSystemId'] = jobSystemId;
    data['jobSystemNo'] = jobSystemNo;
    data['jobOptionId'] = jobOptionId;
    data['customerDisplayName'] = customerDisplayName;
    data['customerCompanyName'] = customerCompanyName;
    data['customerJobTitle'] = customerJobTitle;
    data['customerEmail'] = customerEmail;
    data['customerContactNo'] = customerContactNo;
    data['jobAddress'] = jobAddress;
    data['jobAddressLat'] = jobAddressLat;
    data['jobAddressLong'] = jobAddressLong;
    data['jobScheduleStartDate'] = jobScheduleStartDate;
    data['jobScheduleEndDate'] = jobScheduleEndDate;
    data['coreServiceName'] = coreServiceName;
    data['jobPrivateNote'] = jobPrivateNote;
    return data;
  }
}
