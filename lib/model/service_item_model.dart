class ServiceItemModel {
  int? key;
  String? value;
  ServiceGeneralData? serviceGeneralData;
  List<ServicePrices>? servicePrices;

  ServiceItemModel(
      {this.key, this.value, this.serviceGeneralData, this.servicePrices});

  ServiceItemModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    serviceGeneralData = json['serviceGeneralData'] != null
        ? ServiceGeneralData.fromJson(json['serviceGeneralData'])
        : null;
    if (json['servicePrices'] != null) {
      servicePrices = <ServicePrices>[];
      json['servicePrices'].forEach((v) {
        servicePrices!.add(ServicePrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    if (serviceGeneralData != null) {
      data['serviceGeneralData'] = serviceGeneralData!.toJson();
    }
    if (servicePrices != null) {
      data['servicePrices'] = servicePrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceGeneralData {
  int? serviceId;
  String? serviceName;
  int? serviceParentId;
  bool? serviceIsTaxable;
  String? serviceCode;
  String? serviceDescription;
  String? serviceTaskCode;
  bool? serviceOnlineBookingStatus;

  ServiceGeneralData(
      {this.serviceId,
      this.serviceName,
      this.serviceParentId,
      this.serviceIsTaxable,
      this.serviceCode,
      this.serviceDescription,
      this.serviceTaskCode,
      this.serviceOnlineBookingStatus});

  ServiceGeneralData.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    serviceParentId = json['serviceParentId'];
    serviceIsTaxable = json['serviceIsTaxable'];
    serviceCode = json['serviceCode'];
    serviceDescription = json['serviceDescription'];
    serviceTaskCode = json['serviceTaskCode'];
    serviceOnlineBookingStatus = json['serviceOnlineBookingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceId'] = serviceId;
    data['serviceName'] = serviceName;
    data['serviceParentId'] = serviceParentId;
    data['serviceIsTaxable'] = serviceIsTaxable;
    data['serviceCode'] = serviceCode;
    data['serviceDescription'] = serviceDescription;
    data['serviceTaskCode'] = serviceTaskCode;
    data['serviceOnlineBookingStatus'] = serviceOnlineBookingStatus;
    return data;
  }
}

class ServicePrices {
  int? servicePriceId;
  int? unitId;
  String? unitName;
  String? serviceCost;
  String? servicePrice;
  bool? serviceUnitIsDefault;
  String? servicePriceActiveFrom;
  String? servicePriceActiveTo;

  ServicePrices(
      {this.servicePriceId,
      this.unitId,
      this.unitName,
      this.serviceCost,
      this.servicePrice,
      this.serviceUnitIsDefault,
      this.servicePriceActiveFrom,
      this.servicePriceActiveTo});

  ServicePrices.fromJson(Map<String, dynamic> json) {
    servicePriceId = json['servicePriceId'];
    unitId = json['unitId'];
    unitName = json['unitName'];
    serviceCost = json['serviceCost'].toString();
    servicePrice = json['servicePrice'].toString();
    serviceUnitIsDefault = json['serviceUnitIsDefault'];
    servicePriceActiveFrom = json['servicePriceActiveFrom'];
    servicePriceActiveTo = json['servicePriceActiveTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['servicePriceId'] = servicePriceId;
    data['unitId'] = unitId;
    data['unitName'] = unitName;
    data['serviceCost'] = serviceCost;
    data['servicePrice'] = servicePrice;
    data['serviceUnitIsDefault'] = serviceUnitIsDefault;
    data['servicePriceActiveFrom'] = servicePriceActiveFrom;
    data['servicePriceActiveTo'] = servicePriceActiveTo;
    return data;
  }
}
