class JobPaymentSummeryModel {
  String? jobFinalBillAmount;
  String? jobTotalPaidAmount;
  String? jobTotalRemainAmount;
  String? recipientEmail;
  String? recipientContactNo;
  List<JobPayments>? jobPayments;

  JobPaymentSummeryModel(
      {this.jobFinalBillAmount,
      this.jobTotalPaidAmount,
      this.jobTotalRemainAmount,
      this.recipientEmail,
      this.recipientContactNo,
      this.jobPayments});

  JobPaymentSummeryModel.fromJson(Map<String, dynamic> json) {
    jobFinalBillAmount = json['jobFinalBillAmount'].toString();
    jobTotalPaidAmount = json['jobTotalPaidAmount'].toString();
    jobTotalRemainAmount = json['jobTotalRemainAmount'].toString();
    recipientEmail = json['recipientEmail'];
    recipientContactNo = json['recipientContactNo'];
    if (json['jobPayments'] != null) {
      jobPayments = <JobPayments>[];
      json['jobPayments'].forEach((v) {
        jobPayments!.add(JobPayments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobFinalBillAmount'] = jobFinalBillAmount;
    data['jobTotalPaidAmount'] = jobTotalPaidAmount;
    data['jobTotalRemainAmount'] = jobTotalRemainAmount;
    data['recipientEmail'] = recipientEmail;
    data['recipientContactNo'] = recipientContactNo;
    if (jobPayments != null) {
      data['jobPayments'] = jobPayments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobPayments {
  int? paymentSystemId;
  bool? isAutomatedPayment;
  String? paymentSystemNo;
  String? paymentMethodName;
  String? paymentAmount;
  String? paymentDatetime;
  String? paymentConfirmationDatetime;
  String? jobSystemNo;
  String? paymentStatus;

  JobPayments(
      {this.paymentSystemId,
      this.isAutomatedPayment,
      this.paymentSystemNo,
      this.paymentMethodName,
      this.paymentAmount,
      this.paymentDatetime,
      this.paymentConfirmationDatetime,
      this.jobSystemNo,
      this.paymentStatus});

  JobPayments.fromJson(Map<String, dynamic> json) {
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
