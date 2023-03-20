import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/services/api_service/address_api_services.dart';
import 'package:service/services/page_navigation_service.dart';

import '../services/custom_eassy_loading.dart';
import '../services/debouncher_service.dart';
import '../services/error_code_handle_service.dart';

class CustomerController extends GetxController {
  GlobalKey<FormState> addCustomerFormKey = GlobalKey<FormState>();
  TextEditingController customerFirstNameCtrl = TextEditingController();
  TextEditingController customerLastNameCtrl = TextEditingController();
  TextEditingController customerEmailCtrl = TextEditingController();
  TextEditingController customerMobileCtrl = TextEditingController();
  TextEditingController customerAddressCtrl = TextEditingController();
  TextEditingController customerStateCtrl = TextEditingController();
  TextEditingController customerCityCtrl = TextEditingController();
  TextEditingController customerCountryCtrl = TextEditingController();
  TextEditingController customerPostCodeCtrl = TextEditingController();
  TextEditingController customerNoteCtrl = TextEditingController();
  TextEditingController searchTextCtrl = TextEditingController();

  List suggestedAddressList = List.empty(growable: true);
  final debouncer = Debouncer(milliseconds: 1000);
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

  //<======================= Fetch Suggested Address List
  Future<void> getAddressDetails() async {
    if (searchTextCtrl.text.length > 3) {
      try {
        CustomEassyLoading.startLoading();

        AddressApiService().getAddressDetails(searchTextCtrl.text).then(
            (resp) async {
          customerAddressCtrl.text = searchTextCtrl.text;
          customerCityCtrl.text = resp!.city ?? "";
          customerStateCtrl.text = resp.state ?? "";
          customerCountryCtrl.text = resp.country ?? "";
          customerPostCodeCtrl.text = resp.postalcode ?? "";
          searchTextCtrl.clear();
          CustomEassyLoading.stopLoading();
          update();
          PageNavigationService.backScreen();
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
}
