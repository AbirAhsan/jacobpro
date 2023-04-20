import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/job_payment_summery_model.dart';
import 'package:service/model/payment_model.dart';
import 'package:service/services/api_service/payment_api_service.dart';

import '../services/api_service/address_api_services.dart';
import '../services/custom_dialog_class.dart';
import '../services/custom_eassy_loading.dart';
import '../services/debouncher_service.dart';
import '../services/error_code_handle_service.dart';

class PaymentController extends GetxController {
  List paymentMethodList = List.empty(growable: true);

  TextEditingController? recipientEmailTxtCtrl;
  TextEditingController? amountTxtCtrl;
  TextEditingController? pNoteTxtCtrl;
  TextEditingController? chequeIssueTxtCtrl;
  TextEditingController? chequeDateTxtCtrl;
  TextEditingController searchTextCtrl = TextEditingController();

  TextEditingController? cardHolderNameCtrl = TextEditingController();
  TextEditingController? cardNumberCtrl = TextEditingController();
  TextEditingController? cardStreetCtrl = TextEditingController();
  TextEditingController? cardExpiryMonthCtrl = TextEditingController();
  TextEditingController? cardExpiryYearCtrl = TextEditingController();
  TextEditingController? cardCVCCtrl = TextEditingController();
  TextEditingController? cardPostCtrl = TextEditingController();
  TextEditingController? cardCityCtrl = TextEditingController();
  TextEditingController? cardStateCtrl = TextEditingController();
  List suggestedAddressList = List.empty(growable: true);
  List<CardData> savedCardList = List<CardData>.empty(growable: true);
  Rx<JobPaymentSummeryModel?> jobPaymentSummery = JobPaymentSummeryModel().obs;
  final debouncer = Debouncer(milliseconds: 1000);
  double? addressLat;
  double? addressLong;
  int? selectedOtherPaymentMethod;
  PaymentDtoModel paymentDetails = PaymentDtoModel();
  CardData cardDetails = CardData();
  ChequeData checkDetails = ChequeData();
  initializeTextCtrlData(String? email, String? amount) {
    recipientEmailTxtCtrl = TextEditingController(text: email);
    amountTxtCtrl = TextEditingController(text: amount);
    paymentDetails.paymentAmount = amount ?? "0";
    chequeDateTxtCtrl = TextEditingController();
  }

  //<======================= Fetch Other Payment List
  Future<void> getOtherPaymentList() async {
    try {
      CustomEassyLoading.startLoading();

      PaymentApiService().getOthersPaymentMethod().then((resp) async {
        paymentMethodList = resp;

        CustomEassyLoading.stopLoading();
        update();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  //<======================= Fetch Other Payment List
  Future<void> submitCardPayment(String? jobUuid) async {
    paymentDetails.paymentMethodId = 1;
    try {
      CustomEassyLoading.startLoading();

      await PaymentApiService()
          .submitCardPayment(paymentDetails, cardDetails, jobUuid)
          .then((resp) async {
        CustomEassyLoading.stopLoading();
        CustomDialogShow.showSuccessDialog(
            okayButtonName: "Home", btnOkOnPress: () {});
        update();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  //<======================= Cash Payment
  Future<void> submitCashPayment(String? jobUuid) async {
    paymentDetails.paymentMethodId = 2;
    try {
      CustomEassyLoading.startLoading();

      await PaymentApiService().submitCashPayment(paymentDetails, jobUuid).then(
          (resp) async {
        CustomEassyLoading.stopLoading();
        CustomDialogShow.showSuccessDialog(
            okayButtonName: "Home", btnOkOnPress: () {});
        update();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  //<======================= Cheque Payment
  Future<void> submitChequePayment(String? jobUuid) async {
    paymentDetails.paymentMethodId = 3;
    checkDetails.chequeIssueDate = chequeDateTxtCtrl!.text;
    try {
      CustomEassyLoading.startLoading();

      await PaymentApiService()
          .submitChequePayment(paymentDetails, checkDetails, jobUuid)
          .then((resp) async {
        CustomEassyLoading.stopLoading();
        if (resp) {
          CustomDialogShow.showSuccessDialog(
              okayButtonName: "Home", btnOkOnPress: () {});
        }
        update();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  //<======================= Other's Payment
  Future<void> submitOtherPayment(String? jobUuid) async {
    try {
      CustomEassyLoading.startLoading();

      await PaymentApiService()
          .submitOtherPayment(paymentDetails, jobUuid)
          .then((resp) async {
        CustomEassyLoading.stopLoading();
        update();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  //<======================= Fetch Suggested Address List
  Future<void> getSuggestedAddressList() async {
    if (searchTextCtrl.text.length > 3) {
      try {
        CustomEassyLoading.startLoading();

        AddressApiService().getAddressList(searchTextCtrl.text).then(
            (resp) async {
          suggestedAddressList = resp;

          CustomEassyLoading.stopLoading();
          update();
        }, onError: (err) {
          ApiErrorHandleService.handleStatusCodeError(err);
          CustomEassyLoading.stopLoading();
        });
      } on SocketException catch (e) {
        debugPrint('error $e');
        CustomEassyLoading.stopLoading();
      } catch (e) {
        CustomEassyLoading.stopLoading();
        debugPrint("$e");
      }
    }
  }

  Future assignCardData(CardData cardDetail) async {
    cardDetails.cardHolderName = cardDetail.cardHolderName;
    cardHolderNameCtrl!.text = cardDetail.cardHolderName!;
    cardDetails.cardNo = cardDetail.cardNo;
    cardNumberCtrl!.text = cardDetail.cardNo!;
    cardDetails.cardExpiryMonth = cardDetail.cardExpiryMonth;
    cardExpiryMonthCtrl!.text = cardDetail.cardExpiryMonth!.toString();
    cardDetails.cardExpiryYear = cardDetail.cardExpiryYear;
    cardExpiryYearCtrl!.text = cardDetail.cardExpiryYear!.toString();
    cardDetails.cardCvc = cardDetail.cardCvc;
    cardCVCCtrl!.text = cardDetail.cardCvc!.toString();

    cardDetails.cardBillingStreet = cardDetail.cardBillingStreet;
    cardStreetCtrl!.text = cardDetail.cardBillingStreet!;

    cardDetails.cardBillingCity = cardDetail.cardBillingCity ?? "";
    cardCityCtrl!.text = cardDetail.cardBillingCity ?? "";
    cardDetails.cardBillingState = cardDetail.cardBillingState ?? "";
    cardStateCtrl!.text = cardDetail.cardBillingCity ?? "";
    // cardDetails.cardBillingCity = resp.country ?? "";
    cardDetails.cardBillingZip = cardDetail.cardBillingZip ?? "";
    cardPostCtrl!.text = cardDetail.cardBillingZip ?? "";
  }

  //<======================= Fetch Suggested Address List
  Future<void> getAddressDetails() async {
    if (searchTextCtrl.text.length > 3) {
      try {
        CustomEassyLoading.startLoading();

        AddressApiService().getAddressDetails(searchTextCtrl.text).then(
            (resp) async {
          //  customerAddressCtrl.text = searchTextCtrl.text;
          cardDetails.cardBillingStreet = searchTextCtrl.text;
          cardStreetCtrl!.text = searchTextCtrl.text;

          cardDetails.cardBillingCity = resp!.city ?? "";
          cardCityCtrl!.text = resp.city ?? "";
          cardDetails.cardBillingState = resp.state ?? "";
          cardStateCtrl!.text = resp.state ?? "";
          // cardDetails.cardBillingCity = resp.country ?? "";
          cardDetails.cardBillingZip = resp.postalcode ?? "";
          cardPostCtrl!.text = resp.postalcode ?? "";

          suggestedAddressList.clear();
          // searchTextCtrl.clear();
          CustomEassyLoading.stopLoading();
          update();
          //   PageNavigationService.backScreen();
        }, onError: (err) {
          ApiErrorHandleService.handleStatusCodeError(err);
          CustomEassyLoading.stopLoading();
        });
      } on SocketException catch (e) {
        debugPrint('error $e');
        CustomEassyLoading.stopLoading();
      } catch (e) {
        CustomEassyLoading.stopLoading();
        debugPrint("$e");
      }
    }
  }

  //<======================= Fetch Job Payment Summery List
  Future<void> fetchJobPaymentSummery(int? jobServiceId) async {
    try {
      //  CustomEassyLoading.startLoading();

      await PaymentApiService().getJobPaymentSummery(jobServiceId).then(
          (resp) async {
        jobPaymentSummery.value = resp;

        CustomEassyLoading.stopLoading();
        update();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }

  //<======================= Fetch Saved Card List
  Future<void> fetchSavedCardList(int? customerId) async {
    try {
      CustomEassyLoading.startLoading();

      await PaymentApiService().getSavedCardList(customerId).then((resp) async {
        savedCardList = resp;

        CustomEassyLoading.stopLoading();
        update();
      }, onError: (err) {
        ApiErrorHandleService.handleStatusCodeError(err);
        CustomEassyLoading.stopLoading();
      });
    } on SocketException catch (e) {
      debugPrint('error $e');
      CustomEassyLoading.stopLoading();
    } catch (e) {
      CustomEassyLoading.stopLoading();
      debugPrint("$e");
    }
  }
}
