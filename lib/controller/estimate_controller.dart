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
import 'search_controller.dart';

class EstimatedController extends GetxController {
  double totalServicePrice = 0.0;
  double totalMaterialPrice = 0.0;
  double totalTaxableItemPrice = 0.0;
  double discount = 0.0;
  GlobalKey<FormState> addItemFormKey = GlobalKey<FormState>();
  // TextEditingController searchServiceItemTextCtrl = TextEditingController();
  // TextEditingController searchMaterialItemTextCtrl = TextEditingController();
  // List<ServiceandMaterialItemModel?> serviceItemSearchList =
  //     List<ServiceandMaterialItemModel?>.empty(growable: true);
  // List<ServiceandMaterialItemModel?> materialItemSearchList =
  //     List<ServiceandMaterialItemModel?>.empty(growable: true);

  //<================ Estimate List
  List<EstimateGridModel?> customerEstimateList =
      List<EstimateGridModel?>.empty(growable: true);
  EstimateDetailsModel? estimationDetails = EstimateDetailsModel();
  ServiceandMaterialItemModel? serviceAndMaterialItemDetailsForm =
      ServiceandMaterialItemModel();

  TextEditingController itemDescriptionTxtCtrl = TextEditingController();
  TextEditingController itemQuantityTxtCtrl = TextEditingController();
  TextEditingController itemUnitPriceTxtCtrl = TextEditingController();
  TextEditingController itemTotalTxtCtrl = TextEditingController();

  final debouncer = Debouncer(milliseconds: 1000);

  //<== Tax
  double totalTaxAmount = 0.0;
  int? selectedTaxCategory;
  double? selectedTaxRate = 0.0;
  List taxCategoryList = [
    {"id": 0, "text": "Out of scopes", "percent": 0.0},
    {"id": 1, "text": "Sales Tax", "percent": 10.0},
    {"id": 2, "text": "WA-Federal Way", "percent": 10.1},
    {"id": 3, "text": "WA-Kent", "percent": 10.1},
    {"id": 4, "text": "WA-Seattle", "percent": 10.1},
  ];
  //<== Discount
  String? selectedDiscount;
  List discountTypeList = [
    {"id": "P", "text": "Percentage"},
    {"id": "F", "text": "Dollar Amount"}
  ];

  String? discountDescription;
  String? discountAmount;
  TextEditingController discountDesTxtCrtl = TextEditingController();
  TextEditingController discountAmountTxtCrtl = TextEditingController();

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
        PageNavigationService.generalNavigation("/EstimateDetailsScreen",
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

        selectedDiscount = resp!.jobPriceCalculationDto?.jobDiscountType ?? "";
        discount = resp.jobPriceCalculationDto?.jobDiscountAmount ??
            0.0; //calculated amount
        discountDescription =
            resp.jobPriceCalculationDto?.jobDiscountNote ?? "";
        discountAmount =
            "${resp.jobPriceCalculationDto?.jobDiscountRate ?? 0.0}";

        selectedTaxCategory = resp.jobPriceCalculationDto?.jobTaxTypeId;
        totalTaxAmount = resp.jobPriceCalculationDto?.jobTaxAmount ?? 0.0;
        update();
        print("Data fetch ${resp.jobPriceCalculationDto?.jobDiscountType}");
        await calculateTotalPriceOfServiceItem(
            resp.lineItems?.where((item) => item.itemType == "S").toList() ??
                []);
        await calculateTotalPriceOfMaterialItem(
            resp.lineItems?.where((item) => item.itemType == "M").toList() ??
                []);
        await calculateTotalPriceOfTaxableItem(resp.lineItems
                ?.where((item) => item.itemIsTaxable == true)
                .toList() ??
            []);
        await calculateTax();

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

  calculateTotalPriceOfServiceItem(
      List<ServiceandMaterialItemModel> item) async {
    totalServicePrice = 0.0;
    for (var element in item) {
      totalServicePrice +=
          (element.itemQty ?? 0) * (double.parse(element.itemUnitPrice ?? "0"));
    }

    update();
  }

  calculateTotalPriceOfMaterialItem(
      List<ServiceandMaterialItemModel> item) async {
    totalMaterialPrice = 0.0;
    for (var element in item) {
      totalMaterialPrice +=
          (element.itemQty ?? 0) * (double.parse(element.itemUnitPrice ?? "0"));
    }
    update();
  }

  calculateTotalPriceOfTaxableItem(
      List<ServiceandMaterialItemModel> item) async {
    totalTaxableItemPrice = 0.0;

    for (var element in item) {
      totalTaxableItemPrice +=
          (element.itemQty ?? 0) * (double.parse(element.itemUnitPrice ?? "0"));
      print(element.itemQty);
      print(element.itemUnitPrice);
      print(totalTaxableItemPrice);
    }
    update();
  }

  calculateTax() async {
    double subTotal = totalServicePrice + totalMaterialPrice;
    if (subTotal == 0.0) {
      totalTaxAmount = 0.0;
    } else {
      double weightAvgDiscountOfTaxableAmount =
          (discount * totalTaxableItemPrice) / subTotal;

      double finalTaxableItemPrice =
          totalTaxableItemPrice - weightAvgDiscountOfTaxableAmount;

      totalTaxAmount = double.tryParse(
          ((finalTaxableItemPrice * selectedTaxRate!) / 100)
              .toStringAsFixed(2))!;
    }
    update();
  }

  addDataToServiceAndMaterialItemModel(ServiceandMaterialItemModel details) {
    serviceAndMaterialItemDetailsForm = details;
    itemDescriptionTxtCtrl.text = details.itemDescription!;
    itemQuantityTxtCtrl.text = "${details.itemQty ?? 0}";
    itemUnitPriceTxtCtrl.text = details.itemUnitPrice!;
    itemTotalTxtCtrl.text =
        ((details.itemQty ?? 0) * double.parse(details.itemUnitPrice ?? "0"))
            .toString();

    update();
  }

  //<======================= Fetch  Estimate Item
  Future<void> addItem(String? jobUuid) async {
    try {
      CustomEassyLoading.startLoading();

      await EstimateApiService()
          .addServiceAndMaterialItem(jobUuid,
              serviceAndMaterialItemDetailsForm!, itemTotalTxtCtrl.text)
          .then((resp) async {
        CustomEassyLoading.stopLoading();
        clearForTextCtrl();
        PageNavigationService.backScreen();
        await fetchEstimationDetails(jobUuid);
        await updateEstimate(jobUuid);
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

  assignDataForEditItemForm(ServiceandMaterialItemModel? item) {
    Get.put(SearchControl()).searchTextEditingCtrl!.text = item!.itemName ?? "";
    itemDescriptionTxtCtrl.text = item.itemDescription ?? "";
    itemQuantityTxtCtrl.text = "${item.itemQty ?? 0}";
    itemUnitPriceTxtCtrl.text = item.itemUnitPrice ?? "0";
    itemTotalTxtCtrl.text =
        ((item.itemQty ?? 0) * double.parse(item.itemUnitPrice ?? "0"))
            .toString();

    serviceAndMaterialItemDetailsForm = item;
    update();
  }

  //<======================= Fetch  Estimate Item
  Future<void> deleteItem(String? jobUuid, ServiceandMaterialItemModel? item,
      String? totalBill) async {
    try {
      CustomEassyLoading.startLoading();

      await EstimateApiService()
          .deleteEstimateItem(jobUuid, item, totalBill)
          .then((resp) async {
        if (resp) {
          estimationDetails!.lineItems!
              .removeWhere((element) => element.itemId == item!.itemId);
        }

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

  //<======================= Update  Estimate Details
  Future<void> updateEstimate(String? jobUuid) async {
    try {
      //  CustomEassyLoading.startLoading();

      await EstimateApiService()
          .updateEstimateDetails(
        jobUuid: jobUuid,
        subTotalBill: (totalMaterialPrice + totalServicePrice).toString(),
        totalBill:
            (totalServicePrice + totalMaterialPrice - discount + totalTaxAmount)
                .toString(),
        discountType: selectedDiscount,
        jobDiscountAmount: "$discount", //calculated amount
        jobDiscountNote: discountDescription,
        jobDiscountRate: discountAmount,
        jobTaxTypeId: selectedTaxCategory,
        jobTaxAmount: totalTaxAmount.toString(),
      )
          .then((resp) async {
        CustomEassyLoading.stopLoading();
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

  clearForTextCtrl() {
    Get.put(SearchControl()).searchTextEditingCtrl!.clear();
    itemDescriptionTxtCtrl.clear();
    itemQuantityTxtCtrl.clear();
    itemUnitPriceTxtCtrl.clear();
    itemTotalTxtCtrl.clear();
    update();
  }
}
