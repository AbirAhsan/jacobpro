import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/services/api_service/payment_api_service.dart';

import '../services/custom_eassy_loading.dart';
import '../services/error_code_handle_service.dart';

class PaymentController extends GetxController {
  List paymentMethodList = List.empty(growable: true);

  int? selectedOtherPaymentMethod;
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
}
