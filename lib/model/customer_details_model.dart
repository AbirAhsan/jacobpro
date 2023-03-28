class CustomerDetailsModel {
  CustomerDto? customerDto;
  List<CustomerEmails>? customerEmails;
  List<CustomerContacts>? customerContacts;
  List<CustomerAddresses>? customerAddresses;

  CustomerDetailsModel(
      {this.customerDto,
      this.customerEmails,
      this.customerContacts,
      this.customerAddresses});

  CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    customerDto = json['customerDto'] != null
        ? CustomerDto.fromJson(json['customerDto'])
        : null;
    if (json['customerEmails'] != null) {
      customerEmails = <CustomerEmails>[];
      json['customerEmails'].forEach((v) {
        customerEmails!.add(CustomerEmails.fromJson(v));
      });
    }
    if (json['customerContacts'] != null) {
      customerContacts = <CustomerContacts>[];
      json['customerContacts'].forEach((v) {
        customerContacts!.add(CustomerContacts.fromJson(v));
      });
    }
    if (json['customerAddresses'] != null) {
      customerAddresses = <CustomerAddresses>[];
      json['customerAddresses'].forEach((v) {
        customerAddresses!.add(CustomerAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerDto != null) {
      data['customerDto'] = customerDto!.toJson();
    }
    if (customerEmails != null) {
      data['customerEmails'] = customerEmails!.map((v) => v.toJson()).toList();
    }
    if (customerContacts != null) {
      data['customerContacts'] =
          customerContacts!.map((v) => v.toJson()).toList();
    }
    if (customerAddresses != null) {
      data['customerAddresses'] =
          customerAddresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerDto {
  int? customerId;
  String? customerFirstName;
  String? customerLastName;
  String? customerDisplayName;
  String? customerCompanyName;
  String? customerJobTitle;
  String? customerNotes;
  String? customerTags;
  int? customerLeadSourceId;
  int? customerBillsToCustomerId;
  bool? isNotify;

  CustomerDto(
      {this.customerId,
      this.customerFirstName,
      this.customerLastName,
      this.customerDisplayName,
      this.customerCompanyName,
      this.customerJobTitle,
      this.customerNotes,
      this.customerTags,
      this.customerLeadSourceId,
      this.customerBillsToCustomerId,
      this.isNotify});

  CustomerDto.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerFirstName = json['customerFirstName'];
    customerLastName = json['customerLastName'];
    customerDisplayName = json['customerDisplayName'];
    customerCompanyName = json['customerCompanyName'];
    customerJobTitle = json['customerJobTitle'];
    customerNotes = json['customerNotes'];
    customerTags = json['customerTags'];
    customerLeadSourceId = json['customerLeadSourceId'];
    customerBillsToCustomerId = json['customerBillsToCustomerId'];
    isNotify = json['isNotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['customerFirstName'] = customerFirstName;
    data['customerLastName'] = customerLastName;
    data['customerDisplayName'] = customerDisplayName;
    data['customerCompanyName'] = customerCompanyName;
    data['customerJobTitle'] = customerJobTitle;
    data['customerNotes'] = customerNotes;
    data['customerTags'] = customerTags;
    data['customerLeadSourceId'] = customerLeadSourceId;
    data['customerBillsToCustomerId'] = customerBillsToCustomerId;
    data['isNotify'] = isNotify;
    return data;
  }
}

class CustomerEmails {
  String? customerEmail;
  bool? customerMailIsDefault;

  CustomerEmails({this.customerEmail, this.customerMailIsDefault});

  CustomerEmails.fromJson(Map<String, dynamic> json) {
    customerEmail = json['customerEmail'];
    customerMailIsDefault = json['customerMailIsDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerEmail'] = customerEmail;
    data['customerMailIsDefault'] = customerMailIsDefault;
    return data;
  }
}

class CustomerContacts {
  String? customerContactNo;
  String? customerContactNote;
  bool? customerContactIsDefault;

  CustomerContacts(
      {this.customerContactNo,
      this.customerContactNote,
      this.customerContactIsDefault});

  CustomerContacts.fromJson(Map<String, dynamic> json) {
    customerContactNo = json['customerContactNo'];
    customerContactNote = json['customerContactNote'];
    customerContactIsDefault = json['customerContactIsDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerContactNo'] = customerContactNo;
    data['customerContactNote'] = customerContactNote;
    data['customerContactIsDefault'] = customerContactIsDefault;
    return data;
  }
}

class CustomerAddresses {
  int? customerAddressId;
  String? customerAddressStreet;
  String? customerAddressUnit;
  String? customerAddressCity;
  String? customerAddressState;
  String? customerAddressZip;
  String? customerAddressName;
  String? customerAddressNotes;
  String? customerAddressLat;
  String? customerAddressLong;
  bool? customerAddressBillingStatus;

  CustomerAddresses(
      {this.customerAddressId,
      this.customerAddressStreet,
      this.customerAddressUnit,
      this.customerAddressCity,
      this.customerAddressState,
      this.customerAddressZip,
      this.customerAddressName,
      this.customerAddressNotes,
      this.customerAddressLat,
      this.customerAddressLong,
      this.customerAddressBillingStatus});

  CustomerAddresses.fromJson(Map<String, dynamic> json) {
    customerAddressId = json['customerAddressId'];
    customerAddressStreet = json['customerAddressStreet'];
    customerAddressUnit = json['customerAddressUnit'];
    customerAddressCity = json['customerAddressCity'];
    customerAddressState = json['customerAddressState'];
    customerAddressZip = json['customerAddressZip'];
    customerAddressName = json['customerAddressName'];
    customerAddressNotes = json['customerAddressNotes'];
    customerAddressLat = json['customerAddressLat'];
    customerAddressLong = json['customerAddressLong'];
    customerAddressBillingStatus = json['customerAddressBillingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerAddressId'] = customerAddressId;
    data['customerAddressStreet'] = customerAddressStreet;
    data['customerAddressUnit'] = customerAddressUnit;
    data['customerAddressCity'] = customerAddressCity;
    data['customerAddressState'] = customerAddressState;
    data['customerAddressZip'] = customerAddressZip;
    data['customerAddressName'] = customerAddressName;
    data['customerAddressNotes'] = customerAddressNotes;
    data['customerAddressLat'] = customerAddressLat;
    data['customerAddressLong'] = customerAddressLong;
    data['customerAddressBillingStatus'] = customerAddressBillingStatus;
    return data;
  }
}
