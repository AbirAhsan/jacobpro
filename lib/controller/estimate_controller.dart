//  //<======================= Fetch Service Item List
//   Future<void> getServiceItemList() async {
//     try {
//       CustomEassyLoading.startLoading();

//       await CustomerApiService().getServiceItemList().then((resp) async {
//         serviceItemList = resp;
//         print(serviceItemList.length);
//         CustomEassyLoading.stopLoading();
//         update();
//       }, onError: (err) {
//         ApiErrorHandleService.handleStatusCodeError(err);
//         CustomEassyLoading.stopLoading();
//       });
//     } on SocketException catch (e) {
//       debugPrint('error $e');
//       CustomEassyLoading.stopLoading();
//     } catch (e) {
//       CustomEassyLoading.stopLoading();
//       debugPrint("$e");
//     }
//   }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/estimate_grid_model.dart';
import 'package:service/model/estimation_details_model.dart';
import 'package:service/model/service_and_material_item_model.dart';
import 'package:service/services/api_service/estimate_api_service.dart';
import 'package:service/services/page_navigation_service.dart';

import '../services/custom_eassy_loading.dart';
import '../services/debouncher_service.dart';
import '../services/error_code_handle_service.dart';

class EstimatedController extends GetxController {
  TextEditingController searchServiceItemTextCtrl = TextEditingController();
  TextEditingController searchMaterialItemTextCtrl = TextEditingController();
  List<ServiceandMaterialItemModel?> serviceItemSearchList =
      List<ServiceandMaterialItemModel?>.empty(growable: true);
  List<ServiceandMaterialItemModel?> materialItemSearchList =
      List<ServiceandMaterialItemModel?>.empty(growable: true);

  //<================ Estimate List
  List<EstimateGridModel?> customerEstimateList =
      List<EstimateGridModel?>.empty(growable: true);
  EstimateDetailsModel? estimationDetails = EstimateDetailsModel();

  final debouncer = Debouncer(milliseconds: 1000);

  //<======================= Fetch Service  Item Search List
  Future<void> getServiceItemSearchList() async {
    try {
      CustomEassyLoading.startLoading();

      await EstimateApiService()
          .getServiceAndMaterialItemList(
              itemType: "S", searchStr: searchServiceItemTextCtrl.text)
          .then((resp) async {
        serviceItemSearchList = resp;

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
      debugPrint('error $e');
    }
  }

  //<======================= Fetch Material  Item Search List
  Future<void> getMaterialItemSearchList() async {
    try {
      CustomEassyLoading.startLoading();

      await EstimateApiService()
          .getServiceAndMaterialItemList(
              itemType: "M", searchStr: searchMaterialItemTextCtrl.text)
          .then((resp) async {
        materialItemSearchList = resp;

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
      debugPrint('error $e');
    }
  }

  //<======================= Fetch Customer Estimate List
  Future<void> getCustomerEstimateList(String? customerId) async {
    try {
      CustomEassyLoading.startLoading();

      await EstimateApiService()
          .getCustomerEstimateList(
        customerId: customerId,
      )
          .then((resp) async {
        customerEstimateList = resp;

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
      debugPrint('error $e');
    }
  }

  //<======================= Fetch Customer Estimate List
  Future<void> createEstimate(String? customerId) async {
    try {
      CustomEassyLoading.startLoading();

      await EstimateApiService()
          .createEstimate(
        customerId,
      )
          .then((resp) async {
        CustomEassyLoading.stopLoading();
        PageNavigationService.generalNavigation("/EstimateScreen",
            arguments: resp);
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
      debugPrint('error $e');
    }
  }

  //<======================= Fetch  Estimate Details
  Future<void> fetchEstimationDetails(String? jobUuid) async {
    try {
      CustomEassyLoading.startLoading();

      await EstimateApiService()
          .getEstimationDetails(
        jobUuid: jobUuid,
      )
          .then((resp) async {
        estimationDetails = resp;

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
      debugPrint('error $e');
    }
  }
}
