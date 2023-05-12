class ScheduleDataModel {
  int? scheduleId;
  int? scheduleTypeId;
  String? scheduleName;
  String? scheduleStartDateTime;
  String? scheduleEndDateTime;
  String? scheduleItems;
  String? scheduleBillAmount;
  String? scheduleNote;
  ScheduleCustomerInfo? scheduleCustomerInfo;
  List<ScheduleAssignedUsers>? scheduleAssignedUsers;
  String? scheduleRouteURL;
  String? scheduleColorCode;
  int? scheduleRelatedRefId;

  ScheduleDataModel(
      {this.scheduleId,
      this.scheduleTypeId,
      this.scheduleName,
      this.scheduleStartDateTime,
      this.scheduleEndDateTime,
      this.scheduleItems,
      this.scheduleBillAmount,
      this.scheduleNote,
      this.scheduleCustomerInfo,
      this.scheduleAssignedUsers,
      this.scheduleRouteURL,
      this.scheduleColorCode,
      this.scheduleRelatedRefId});

  ScheduleDataModel.fromJson(Map<String, dynamic> json) {
    scheduleId = json['scheduleId'];
    scheduleTypeId = json['scheduleTypeId'];
    scheduleName = json['scheduleName'];
    scheduleStartDateTime = json['scheduleStartDateTime'];
    scheduleEndDateTime = json['scheduleEndDateTime'];
    scheduleItems = json['scheduleItems'];
    scheduleBillAmount = json['scheduleBillAmount'].toString();
    scheduleNote = json['scheduleNote'];
    scheduleCustomerInfo = json['scheduleCustomerInfo'] != null
        ? new ScheduleCustomerInfo.fromJson(json['scheduleCustomerInfo'])
        : null;
    if (json['scheduleAssignedUsers'] != null) {
      scheduleAssignedUsers = <ScheduleAssignedUsers>[];
      json['scheduleAssignedUsers'].forEach((v) {
        scheduleAssignedUsers!.add(new ScheduleAssignedUsers.fromJson(v));
      });
    }
    scheduleRouteURL = json['scheduleRouteURL'];
    scheduleColorCode = json['scheduleColorCode'];
    scheduleRelatedRefId = json['scheduleRelatedRefId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheduleId'] = this.scheduleId;
    data['scheduleTypeId'] = this.scheduleTypeId;
    data['scheduleName'] = this.scheduleName;
    data['scheduleStartDateTime'] = this.scheduleStartDateTime;
    data['scheduleEndDateTime'] = this.scheduleEndDateTime;
    data['scheduleItems'] = this.scheduleItems;
    data['scheduleBillAmount'] = this.scheduleBillAmount;
    data['scheduleNote'] = this.scheduleNote;
    if (this.scheduleCustomerInfo != null) {
      data['scheduleCustomerInfo'] = this.scheduleCustomerInfo!.toJson();
    }
    if (this.scheduleAssignedUsers != null) {
      data['scheduleAssignedUsers'] =
          this.scheduleAssignedUsers!.map((v) => v.toJson()).toList();
    }
    data['scheduleRouteURL'] = this.scheduleRouteURL;
    data['scheduleColorCode'] = this.scheduleColorCode;
    data['scheduleRelatedRefId'] = this.scheduleRelatedRefId;
    return data;
  }
}

class ScheduleCustomerInfo {
  String? customerDisplayName;
  String? customerContactNo;
  String? customerAddress;

  ScheduleCustomerInfo(
      {this.customerDisplayName, this.customerContactNo, this.customerAddress});

  ScheduleCustomerInfo.fromJson(Map<String, dynamic> json) {
    customerDisplayName = json['customerDisplayName'];
    customerContactNo = json['customerContactNo'];
    customerAddress = json['customerAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerDisplayName'] = this.customerDisplayName;
    data['customerContactNo'] = this.customerContactNo;
    data['customerAddress'] = this.customerAddress;
    return data;
  }
}

class ScheduleAssignedUsers {
  String? userFullName;
  String? userImgRef;

  ScheduleAssignedUsers({this.userFullName, this.userImgRef});

  ScheduleAssignedUsers.fromJson(Map<String, dynamic> json) {
    userFullName = json['userFullName'];
    userImgRef = json['userImgRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userFullName'] = this.userFullName;
    data['userImgRef'] = this.userImgRef;
    return data;
  }
}
