import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/payment_model.dart';
import 'package:service/services/api_service/payment_api_service.dart';

import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';

class PaymentController extends GetxController {
  List paymentMethodList = List.empty(growable: true);

  TextEditingController? recipientEmailTxtCtrl;
  TextEditingController? amountTxtCtrl;
  TextEditingController? pNoteTxtCtrl;
  TextEditingController? chequeIssueTxtCtrl;
  TextEditingController? chequeDateTxtCtrl;

  int? selectedOtherPaymentMethod;
  PaymentDtoModel paymentDetails = PaymentDtoModel();
  CardData cardDetails = CardData();
  ChequeData checkDetails = ChequeData();
  initializeTextCtrlData(String? email, String? amount) {
    recipientEmailTxtCtrl = TextEditingController(text: email);
    amountTxtCtrl = TextEditingController(text: amount);
    paymentDetails.paymentAmount = int.parse(amount ?? "0");
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
    paymentDetails.chequeData!.chequeIssueDate = chequeDateTxtCtrl!.text;
    try {
      CustomEassyLoading.startLoading();

      await PaymentApiService()
          .submitChequePayment(paymentDetails, checkDetails, jobUuid)
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
}
