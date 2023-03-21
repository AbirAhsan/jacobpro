class CustomerInfoModel {
  int? customerId;
  String? customerFirstName;
  String? customerLastName;
  String? customerDisplayName;
  String? customerCompanyName;
  String? customerJobTitle;
  String? customerDefaultContact;
  String? customerDefaultMail;
  String? customerBillingAddress;

  CustomerInfoModel(
      {this.customerId,
      this.customerFirstName,
      this.customerLastName,
      this.customerDisplayName,
      this.customerCompanyName,
      this.customerJobTitle,
      this.customerDefaultContact,
      this.customerDefaultMail,
      this.customerBillingAddress});

  CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerFirstName = json['customerFirstName'];
    customerLastName = json['customerLastName'];
    customerDisplayName = json['customerDisplayName'];
    customerCompanyName = json['customerCompanyName'];
    customerJobTitle = json['customerJobTitle'];
    customerDefaultContact = json['customerDefaultContact'];
    customerDefaultMail = json['customerDefaultMail'];
    customerBillingAddress = json['customerBillingAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['customerFirstName'] = customerFirstName;
    data['customerLastName'] = customerLastName;
    data['customerDisplayName'] = customerDisplayName;
    data['customerCompanyName'] = customerCompanyName;
    data['customerJobTitle'] = customerJobTitle;
    data['customerDefaultContact'] = customerDefaultContact;
    data['customerDefaultMail'] = customerDefaultMail;
    data['customerBillingAddress'] = customerBillingAddress;
    return data;
  }
}
