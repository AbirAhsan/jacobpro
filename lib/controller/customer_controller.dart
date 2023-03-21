import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/services/api_service/address_api_services.dart';
import 'package:service/services/api_service/customer_api_services.dart';
import 'package:service/services/page_navigation_service.dart';

import '../model/customer_model.dart';
import '../services/custom_eassy_loading.dart';
import '../services/debouncher_service.dart';
import '../services/error_code_handle_service.dart';
import '../services/validator_service.dart';

class CustomerController extends GetxController {
  GlobalKey<FormState> addCustomerFormKey = GlobalKey<FormState>();
  TextEditingController customerFirstNameCtrl = TextEditingController();
  TextEditingController customerLastNameCtrl = TextEditingController();
  TextEditingController customerPrefferedNameCtrl = TextEditingController();
  TextEditingController customerEmailCtrl = TextEditingController();
  TextEditingController customerMobileCtrl = TextEditingController();
  TextEditingController customerAddressCtrl = TextEditingController();
  TextEditingController customerStateCtrl = TextEditingController();
  TextEditingController customerCityCtrl = TextEditingController();
  TextEditingController customerCountryCtrl = TextEditingController();
  TextEditingController customerPostCodeCtrl = TextEditingController();
  TextEditingController customerNoteCtrl = TextEditingController();
  TextEditingController searchTextCtrl = TextEditingController();

  TextEditingController searchCustomerTextCtrl = TextEditingController();

  double? addressLat;
  double? addressLong;

  List suggestedAddressList = List.empty(growable: true);
  List<CustomerInfoModel?> customerList =
      List<CustomerInfoModel?>.empty(growable: true);
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
  Future<void> getCustomerList() async {
    try {
      //  CustomEassyLoading.startLoading();

      CustomerApiService().getCustomerList(searchCustomerTextCtrl.text).then(
          (resp) async {
        customerList = resp;

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
          addressLat = resp.lat;
          addressLong = resp.lng;
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

  //<======================= Add New Customer
  Future<void> addNewCustomer() async {
    if (ValidatorService().validateAndSave(addCustomerFormKey)) {
      try {
        CustomEassyLoading.startLoading();

        CustomerApiService()
            .addNewCustomer(
          customerFirstNameCtrl.text,
          customerLastNameCtrl.text,
          customerPrefferedNameCtrl.text,
          customerNoteCtrl.text,
          customerEmailCtrl.text,
          customerMobileCtrl.text,
          customerAddressCtrl.text,
          "", //addressUnit
          customerCityCtrl.text,
          customerStateCtrl.text,
          customerPostCodeCtrl.text,
          addressLat.toString(),
          addressLong.toString(),
        )
            .then((resp) async {
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
