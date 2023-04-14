class PaymentDtoModel {
  int? paymentMethodId;
  CardData? cardData;
  ChequeData? chequeData;
  String? paymentNote;
  int? paymentAmount;

  PaymentDtoModel(
      {this.paymentMethodId,
      this.cardData,
      this.chequeData,
      this.paymentNote,
      this.paymentAmount});

  PaymentDtoModel.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['paymentMethodId'];
    cardData =
        json['cardData'] != null ? CardData.fromJson(json['cardData']) : null;
    chequeData = json['chequeData'] != null
        ? ChequeData.fromJson(json['chequeData'])
        : null;
    paymentNote = json['paymentNote'];
    paymentAmount = json['paymentAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethodId'] = paymentMethodId;
    if (cardData != null) {
      data['cardData'] = cardData!.toJson();
    }
    if (chequeData != null) {
      data['chequeData'] = chequeData!.toJson();
    }
    data['paymentNote'] = paymentNote;
    data['paymentAmount'] = paymentAmount;
    return data;
  }
}

class CardData {
  String? cardHolderName;
  String? cardNo;
  int? cardExpiryYear;
  int? cardExpiryMonth;
  int? cardCvc;
  String? cardBillingStreet;
  String? cardBillingCity;
  String? cardBillingState;
  String? cardBillingZip;
  bool? cardIsSaved;

  CardData(
      {this.cardHolderName,
      this.cardNo,
      this.cardExpiryYear,
      this.cardExpiryMonth,
      this.cardCvc,
      this.cardBillingStreet,
      this.cardBillingCity,
      this.cardBillingState,
      this.cardBillingZip,
      this.cardIsSaved});

  CardData.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNo = json['cardNo'];
    cardExpiryYear = json['cardExpiryYear'];
    cardExpiryMonth = json['cardExpiryMonth'];
    cardCvc = json['cardCvc'];
    cardBillingStreet = json['cardBillingStreet'];
    cardBillingCity = json['cardBillingCity'];
    cardBillingState = json['cardBillingState'];
    cardBillingZip = json['cardBillingZip'];
    cardIsSaved = json['cardIsSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardHolderName'] = cardHolderName;
    data['cardNo'] = cardNo;
    data['cardExpiryYear'] = cardExpiryYear;
    data['cardExpiryMonth'] = cardExpiryMonth;
    data['cardCvc'] = cardCvc;
    data['cardBillingStreet'] = cardBillingStreet;
    data['cardBillingCity'] = cardBillingCity;
    data['cardBillingState'] = cardBillingState;
    data['cardBillingZip'] = cardBillingZip;
    data['cardIsSaved'] = cardIsSaved;
    return data;
  }
}

class ChequeData {
  String? chequeNo;
  String? chequeIssueDate;
  String? chequeBankName;
  String? chequeBankAccountNo;
  String? chequeBankAccountName;

  ChequeData(
      {this.chequeNo,
      this.chequeIssueDate,
      this.chequeBankName,
      this.chequeBankAccountNo,
      this.chequeBankAccountName});

  ChequeData.fromJson(Map<String, dynamic> json) {
    chequeNo = json['chequeNo'];
    chequeIssueDate = json['chequeIssueDate'];
    chequeBankName = json['chequeBankName'];
    chequeBankAccountNo = json['chequeBankAccountNo'];
    chequeBankAccountName = json['chequeBankAccountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chequeNo'] = chequeNo;
    data['chequeIssueDate'] = chequeIssueDate;
    data['chequeBankName'] = chequeBankName;
    data['chequeBankAccountNo'] = chequeBankAccountNo;
    data['chequeBankAccountName'] = chequeBankAccountName;
    return data;
  }
}
