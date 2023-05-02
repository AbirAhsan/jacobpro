class PaymentInvoiceModel {
  int? paymentSystemId;
  bool? isAutomatedPayment;
  String? paymentSystemNo;
  String? paymentMethodName;
  String? paymentAmount;
  String? paymentDatetime;
  String? paymentConfirmationDatetime;
  String? jobSystemNo;
  String? paymentStatus;

  PaymentInvoiceModel(
      {this.paymentSystemId,
      this.isAutomatedPayment,
      this.paymentSystemNo,
      this.paymentMethodName,
      this.paymentAmount,
      this.paymentDatetime,
      this.paymentConfirmationDatetime,
      this.jobSystemNo,
      this.paymentStatus});

  PaymentInvoiceModel.fromJson(Map<String, dynamic> json) {
    paymentSystemId = json['paymentSystemId'];
    isAutomatedPayment = json['isAutomatedPayment'];
    paymentSystemNo = json['paymentSystemNo'];
    paymentMethodName = json['paymentMethodName'];
    paymentAmount = json['paymentAmount'].toString();
    paymentDatetime = json['paymentDatetime'];
    paymentConfirmationDatetime = json['paymentConfirmationDatetime'];
    jobSystemNo = json['jobSystemNo'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentSystemId'] = paymentSystemId;
    data['isAutomatedPayment'] = isAutomatedPayment;
    data['paymentSystemNo'] = paymentSystemNo;
    data['paymentMethodName'] = paymentMethodName;
    data['paymentAmount'] = paymentAmount;
    data['paymentDatetime'] = paymentDatetime;
    data['paymentConfirmationDatetime'] = paymentConfirmationDatetime;
    data['jobSystemNo'] = jobSystemNo;
    data['paymentStatus'] = paymentStatus;
    return data;
  }
}
