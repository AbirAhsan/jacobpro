import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/services/api_service/address_api_services.dart';
import 'package:service/services/api_service/customer_api_services.dart';
import 'package:service/services/page_navigation_service.dart';

import '../model/customer_details_model.dart';
import '../model/customer_model.dart';
import '../model/material_item_model.dart';
import '../model/service_item_model.dart';
import '../services/custom_eassy_loading.dart';
import '../services/debouncher_service.dart';
import '../services/error_code_handle_service.dart';
import '../services/validator_service.dart';

class CustomerController extends GetxController {
  GlobalKey<FormState> addCustomerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addEstimateFormKey = GlobalKey<FormState>();

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

  Rx<Future<CustomerDetailsModel?>> customerDetails =
      Future.value(CustomerDetailsModel()).obs;

  double? addressLat;
  double? addressLong;

  List suggestedAddressList = List.empty(growable: true);
  List<CustomerInfoModel?> customerList =
      List<CustomerInfoModel?>.empty(growable: true);

  final debouncer = Debouncer(milliseconds: 1000);

//
  List<ServiceItemModel?> serviceItemList =
      List<ServiceItemModel?>.empty(growable: true);
  Rx<ServiceItemModel?> serviceItem = ServiceItemModel().obs;

  ServiceItemModel? selectedService;
  ServicePrices? selectedServicePrice;
  TextEditingController serviceUnitCostTxtCtrl = TextEditingController();
  TextEditingController serviceUnitQuantityTxtCtrl = TextEditingController();

  List serviceTextFieldSection = [];

  addNewServiceTextEditingCtrl() {
    if (ValidatorService().validateAndSave(addEstimateFormKey)) {
      TextEditingController serviceItemTxtCtrl = TextEditingController();
      TextEditingController serviceQuantityTxtCtrl = TextEditingController();
      TextEditingController serviceUnitTxtCtrl = TextEditingController();
      TextEditingController serviceTotalCostTxtCtrl = TextEditingController();
      TextEditingController serviceDescriptionCostTxtCtrl =
          TextEditingController();
      serviceTextFieldSection.add({
        "id": serviceTextFieldSection.length + 1,
        "itemLabel": "Item Name",
        "labelCtrl": serviceItemTxtCtrl,
        "quantityLabel": "Qty",
        "quantityCtrl": serviceQuantityTxtCtrl,
        "unitLabel": "Unit Price",
        "unitCtrl": serviceUnitTxtCtrl,
        "totalLabel": "Total",
        "totalCostCtrl": serviceTotalCostTxtCtrl,
        "descriptionLabel": "Description",
        "descriptionCtrl": serviceDescriptionCostTxtCtrl,
      });
    } else {}

    update();
  }

  closeServiceTextFields(int id) {
    if (id != 1) {
      serviceTextFieldSection.removeWhere((element) => element["id"] == id);
    }

    update();
  }

//
  List<MaterialItemModel?> materialItemList =
      List<MaterialItemModel?>.empty(growable: true);
  List<MaterialPrices?> materialPriceList =
      List<MaterialPrices?>.empty(growable: true);
  List materialTextFieldSection = [];
  addNewMaterialTextEditingCtrl() {
    TextEditingController materialItemTxtCtrl = TextEditingController();
    TextEditingController materialQuantityTxtCtrl = TextEditingController();
    TextEditingController materialUnitTxtCtrl = TextEditingController();
    TextEditingController materialTotalCostTxtCtrl = TextEditingController();
    TextEditingController materialDescriptionCostTxtCtrl =
        TextEditingController();

    materialTextFieldSection.add({
      "id": materialTextFieldSection.length + 1,
      "itemLabel": "Item Name",
      "labelCtrl": materialItemTxtCtrl,
      "quantityLabel": "Quantity",
      "quantityCtrl": materialQuantityTxtCtrl,
      "unitLabel": "Unit Price",
      "unitCtrl": materialUnitTxtCtrl,
      "totalLabel": "Total Cost",
      "totalCostCtrl": materialTotalCostTxtCtrl,
      "descriptionLabel": "Description",
      "descriptionCtrl": materialDescriptionCostTxtCtrl,
    });
    update();
  }

  closeMaterialTextFields(int id) {
    if (id != 1) {
      materialTextFieldSection.removeWhere((element) => element["id"] == id);
    }

    update();
  }

  @override
  void onClose() {
    for (var elements in serviceTextFieldSection) {
      elements["labelCtrl"].dispose();
      elements["quantityCtrl"].dispose();
    }
    serviceTextFieldSection.clear();
    super.onClose();
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

  //<======================= Fetch Service Item List
  Future<void> getServiceItemList() async {
    try {
      CustomEassyLoading.startLoading();

      await CustomerApiService().getServiceItemList().then((resp) async {
        serviceItemList = resp;
        print(serviceItemList.length);
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

  //<======================= Fetch Service Item List
  Future<void> getServiceItem(int? serviceId) async {
    selectedServicePrice = null;
    update();
    try {
      CustomEassyLoading.startLoading();

      await CustomerApiService().getServiceDetails(serviceId).then(
          (resp) async {
        serviceItem.value = resp;

        print(serviceItem.value!.servicePrices?.length);
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

  //<======================= Fetch Material Item List
  Future<void> getMaterialItemList() async {
    try {
      CustomEassyLoading.startLoading();

      await CustomerApiService().getMaterialItemList().then((resp) async {
        materialItemList = resp;

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

  //<======================= Fetch Customer Address List
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

  //<======================= Fetch Customer Details
  Future<void> getCustomerDetails(String? customerId) async {
    try {
      //  CustomEassyLoading.startLoading();

      customerDetails.value =
          CustomerApiService().getCustomerDetails(customerId);

      update();
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
