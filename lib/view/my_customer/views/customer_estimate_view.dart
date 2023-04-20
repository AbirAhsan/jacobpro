import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/services/validator_service.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button_with_icon.dart';
import 'package:service/view/widgets/custom_dropdown.dart';
import 'package:service/view/widgets/custom_submit_button.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../../controller/customer_controller.dart';
import '../../../model/material_item_model.dart';
import '../../../model/service_item_model.dart';
import '../../widgets/cupertino_bottom_sheet.dart';

class CustomerEstimateView extends StatelessWidget {
  const CustomerEstimateView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
        init: CustomerController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Get.put(CustomerController()).serviceTextFieldSection.isEmpty) {
              //  Get.put(CustomerController()).addNewServiceTextEditingCtrl();
            }
          });
        },
        builder: (customerCtrl) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    //<======================= Serivces
                    Form(
                      key: customerCtrl.addEstimateServiceFormKey,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "SERVICES",
                                  style:
                                      CustomTextStyle.mediumBoldStyleDarkGrey,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              const Divider(),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount: customerCtrl
                                      .serviceTextFieldSection.length,
                                  itemBuilder: (buildContex, index) {
                                    dynamic serviceTextCtrl = customerCtrl
                                        .serviceTextFieldSection[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                                onTap: () {
                                                  customerCtrl
                                                      .closeServiceTextFields(
                                                          serviceTextCtrl[
                                                              'id']);
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomColors
                                                            .primary
                                                            .withOpacity(0.1)),
                                                    child: const Icon(
                                                        Icons.close))),
                                          ),
                                          CustomTextField(
                                            labelText:
                                                serviceTextCtrl["itemLabel"],
                                            controller:
                                                serviceTextCtrl["labelCtrl"],
                                            validator: ValidatorService
                                                .validateSimpleFiled,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: serviceTextCtrl[
                                                      "unitNameLabel"],
                                                  controller: serviceTextCtrl[
                                                      "unitNameCtrl"],
                                                  validator: ValidatorService
                                                      .validateSimpleFiled,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: serviceTextCtrl[
                                                      "unitPriceLabel"],
                                                  controller: serviceTextCtrl[
                                                      "unitPriceCtrl"],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow((RegExp(
                                                            r'^\d+\.?\d{0,2}'))),
                                                  ],
                                                  validator: ValidatorService
                                                      .validateIntNumberField,
                                                  onChanged: (value) {
                                                    serviceTextCtrl["totalCtrl"]
                                                        .text = (double.tryParse(
                                                                serviceTextCtrl[
                                                                        "quantityCtrl"]
                                                                    .text
                                                                    .toString())! *
                                                            num.tryParse(
                                                                serviceTextCtrl[
                                                                        "unitPriceCtrl"]
                                                                    .text
                                                                    .toString())!)
                                                        .toString();
                                                    customerCtrl
                                                        .calculateTotalServicePrice();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: serviceTextCtrl[
                                                      "quantityLabel"],
                                                  controller: serviceTextCtrl[
                                                      "quantityCtrl"],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  validator: ValidatorService
                                                      .validateIntNumberField,
                                                  onChanged: (value) {
                                                    serviceTextCtrl["totalCtrl"]
                                                        .text = (double.tryParse(
                                                                serviceTextCtrl[
                                                                        "quantityCtrl"]
                                                                    .text
                                                                    .toString())! *
                                                            num.tryParse(
                                                                serviceTextCtrl[
                                                                        "unitPriceCtrl"]
                                                                    .text
                                                                    .toString())!)
                                                        .toString();
                                                    customerCtrl
                                                        .calculateTotalServicePrice();
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: serviceTextCtrl[
                                                      "totalLabel"],
                                                  controller: serviceTextCtrl[
                                                      "totalCtrl"],
                                                  readOnly: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                          CustomTextField(
                                            labelText: serviceTextCtrl[
                                                "descriptionLabel"],
                                            controller: serviceTextCtrl[
                                                "descriptionCtrl"],
                                            minLines: 2,
                                            maxLines: 5,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Align(
                                alignment: Alignment.topRight,
                                child: CustomCompanyButtonWithIcon(
                                    buttonName: "ADD SERVICE",
                                    bottomPadding: 0,
                                    topPadding: 0,
                                    fizedSize: const Size(double.infinity, 30),
                                    icon: null,
                                    isFitted: true,
                                    onPressed: () async {
                                      if (ValidatorService().validateAndSave(
                                          customerCtrl
                                              .addEstimateServiceFormKey)) {
                                        customerCtrl.selectedServicePrice =
                                            null;
                                        customerCtrl.selectedService = null;
                                        customerCtrl.serviceUnitQuantityTxtCtrl
                                            .clear();
                                        customerCtrl.serviceUnitCostTxtCtrl
                                            .clear();
                                        showServiceModal(context);
                                      }
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    //<======================= Material
                    Form(
                      key: customerCtrl.addEstimateMaterialFormKey,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "MATERIALS",
                                  style:
                                      CustomTextStyle.mediumBoldStyleDarkGrey,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              const Divider(),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount: customerCtrl
                                      .materialTextFieldSection.length,
                                  itemBuilder: (buildContex, index) {
                                    dynamic materialCtrl = customerCtrl
                                        .materialTextFieldSection[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                                onTap: () {
                                                  customerCtrl
                                                      .closeMaterialTextFields(
                                                          materialCtrl['id']);
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: CustomColors
                                                            .primary
                                                            .withOpacity(0.1)),
                                                    child: const Icon(
                                                      Icons.close,
                                                      color:
                                                          CustomColors.primary,
                                                    ))),
                                          ),
                                          CustomTextField(
                                            labelText:
                                                materialCtrl["itemLabel"],
                                            controller:
                                                materialCtrl["labelCtrl"],
                                            validator: ValidatorService
                                                .validateSimpleFiled,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: materialCtrl[
                                                      "unitNameLabel"],
                                                  controller: materialCtrl[
                                                      "unitNameCtrl"],
                                                  validator: ValidatorService
                                                      .validateSimpleFiled,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: materialCtrl[
                                                      "unitPriceLabel"],
                                                  controller: materialCtrl[
                                                      "unitPriceCtrl"],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow((RegExp(
                                                            r'^\d+\.?\d{0,2}'))),
                                                  ],
                                                  validator: ValidatorService
                                                      .validateIntNumberField,
                                                  onChanged: (value) {
                                                    materialCtrl["totalCtrl"]
                                                        .text = (double.tryParse(
                                                                materialCtrl[
                                                                        "quantityCtrl"]
                                                                    .text
                                                                    .toString())! *
                                                            num.tryParse(materialCtrl[
                                                                    "unitPriceCtrl"]
                                                                .text
                                                                .toString())!)
                                                        .toString();
                                                    customerCtrl
                                                        .calculateTotalMaterialPrice();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: materialCtrl[
                                                      "quantityLabel"],
                                                  controller: materialCtrl[
                                                      "quantityCtrl"],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  validator: ValidatorService
                                                      .validateIntNumberField,
                                                  onChanged: (value) {
                                                    materialCtrl["totalCtrl"]
                                                        .text = (double.tryParse(
                                                                materialCtrl[
                                                                        "quantityCtrl"]
                                                                    .text
                                                                    .toString())! *
                                                            num.tryParse(materialCtrl[
                                                                    "unitPriceCtrl"]
                                                                .text
                                                                .toString())!)
                                                        .toString();
                                                    customerCtrl
                                                        .calculateTotalMaterialPrice();
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: materialCtrl[
                                                      "totalLabel"],
                                                  controller:
                                                      materialCtrl["totalCtrl"],
                                                ),
                                              ),
                                            ],
                                          ),
                                          CustomTextField(
                                            labelText: materialCtrl[
                                                "descriptionLabel"],
                                            controller:
                                                materialCtrl["descriptionCtrl"],
                                            minLines: 2,
                                            maxLines: 5,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Align(
                                alignment: Alignment.topRight,
                                child: CustomCompanyButtonWithIcon(
                                    buttonName: "ADD MATERIAL",
                                    topMargin: 0,
                                    bottomMargin: 0,
                                    bottomPadding: 0,
                                    topPadding: 0,
                                    fizedSize: const Size(double.infinity, 30),
                                    icon: null,
                                    isFitted: true,
                                    onPressed: () async {
                                      if (ValidatorService().validateAndSave(
                                          customerCtrl
                                              .addEstimateMaterialFormKey)) {
                                        customerCtrl.selectedMaterialPrice =
                                            null;
                                        customerCtrl.selectedMaterial = null;
                                        customerCtrl.materialUnitQuantityTxtCtrl
                                            .clear();
                                        customerCtrl.materialUnitCostTxtCtrl
                                            .clear();
                                        showMaterialModal(context);
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 2, child: Text('')),
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Service Price',
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.left,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${customerCtrl.totalServicePrice}",
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    ))
                              ],
                            ),
                            const Divider(),
                            // const Divider(
                            //   height: 2,
                            //   thickness: 0,
                            //   color: CustomColors.white,
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 2, child: Text('')),
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Material Price',
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.left,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${customerCtrl.totalMaterialPrice}",
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    ))
                              ],
                            ),
                            const Divider(
                              thickness: 2.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 2, child: Text('')),
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Sub Total',
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.left,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${(customerCtrl.totalServicePrice! + customerCtrl.totalMaterialPrice!)}",
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    ))
                              ],
                            ),
                            const Divider(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 2, child: Text('')),
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Discount',
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.left,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "(-) \$${customerCtrl.discount}",
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    ))
                              ],
                            ),
                            const Divider(
                              thickness: 2.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 2, child: Text('')),
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'FINAL BILL',
                                      style:
                                          CustomTextStyle.mediumBoldStyleBlack,
                                      textAlign: TextAlign.left,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${(customerCtrl.totalServicePrice! + customerCtrl.totalMaterialPrice! - customerCtrl.discount!)}",
                                      style:
                                          CustomTextStyle.mediumBoldStyleBlack,
                                      textAlign: TextAlign.right,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: CustomSubmitButton(
                          rightMargin: 4,
                          fizedSize: const Size(double.infinity, 30),
                          buttonName: "Add Estimate",
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

void showServiceModal(BuildContext context) async {
  await showCupertinoModalPopup(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<CustomerController>(
          init: CustomerController(),
          initState: (state) async {
            await Get.put(CustomerController()).getServiceItemList();
          },
          builder: (customerCtrl) {
            return MyCupertinoBottomSheet(
                title: Text(
                  "ADD SERVICE",
                  style: CustomTextStyle.titleRegularStyleDarkGrey,
                ),
                onConfirm: () async {
                  await customerCtrl.addNewServiceTextEditingCtrl(
                      customerCtrl.selectedService!.value,
                      customerCtrl.selectedServicePrice!.unitName,
                      customerCtrl.serviceUnitQuantityTxtCtrl.text,
                      customerCtrl.serviceUnitCostTxtCtrl.text);
                  PageNavigationService.backScreen();
                },
                onCancel: () {
                  PageNavigationService.backScreen();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropDown(
                        label: "Service Name",
                        marginRight: 0,
                        marginLeft: 0,
                        value: customerCtrl.selectedService,
                        items: customerCtrl.serviceItemList.map((service) {
                          return DropdownMenuItem<ServiceItemModel>(
                              value: service,
                              child: Text(service!.value.toString()));
                        }).toList(),
                        onChanged: (value) async {
                          customerCtrl.selectedServicePrice = null;
                          customerCtrl.selectedService = value;
                          customerCtrl.serviceItem.value = ServiceItemModel();
                          customerCtrl.serviceItem.value!.servicePrices
                              ?.clear();
                          customerCtrl.update();
                          await customerCtrl.getServiceItem(value.key);
                        }),
                    CustomDropDown(
                        label: "Unit Name",
                        marginRight: 0,
                        marginLeft: 0,
                        value: customerCtrl.selectedServicePrice,
                        items: customerCtrl.serviceItem.value!.servicePrices
                                ?.map((servicePrice) {
                              return DropdownMenuItem<ServicePrices>(
                                  value: servicePrice,
                                  child:
                                      Text(servicePrice.unitName.toString()));
                            }).toList() ??
                            [],
                        onChanged: (value) {
                          customerCtrl.selectedServicePrice = value;

                          customerCtrl.serviceUnitCostTxtCtrl.text =
                              value.servicePrice;
                          customerCtrl.serviceUnitQuantityTxtCtrl.text = "1";
                          customerCtrl.update();
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: "Service Price",
                            controller: customerCtrl.serviceUnitCostTxtCtrl,
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            labelText: "Qty",
                            controller: customerCtrl.serviceUnitQuantityTxtCtrl,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ));
          });
    },
  );
  // customerCtrl.addNewServiceTextEditingCtrl();
}

void showMaterialModal(BuildContext context) async {
  await showCupertinoModalPopup(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<CustomerController>(
          init: CustomerController(),
          initState: (state) async {
            await Get.put(CustomerController()).getMaterialItemList();
          },
          builder: (customerCtrl) {
            return MyCupertinoBottomSheet(
                title: Text(
                  "ADD MATERIAL",
                  style: CustomTextStyle.titleRegularStyleDarkGrey,
                ),
                onConfirm: () async {
                  await customerCtrl.addNewMaterialTextEditingCtrl(
                      customerCtrl.selectedMaterial!.value,
                      customerCtrl.selectedMaterialPrice!.unitName,
                      customerCtrl.materialUnitQuantityTxtCtrl.text,
                      customerCtrl.materialUnitCostTxtCtrl.text);
                  PageNavigationService.backScreen();
                },
                onCancel: () {
                  PageNavigationService.backScreen();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomDropDown(
                        label: "Material Name",
                        marginRight: 0,
                        marginLeft: 0,
                        value: customerCtrl.selectedMaterial,
                        items: customerCtrl.materialItemList.map((material) {
                          return DropdownMenuItem<MaterialItemModel>(
                              value: material,
                              child: Text(material!.value.toString()));
                        }).toList(),
                        onChanged: (value) async {
                          customerCtrl.selectedMaterialPrice = null;
                          customerCtrl.selectedMaterial = value;
                          customerCtrl.materialItem.value = MaterialItemModel();
                          customerCtrl.materialItem.value!.materialPrices
                              ?.clear();
                          customerCtrl.update();
                          await customerCtrl.getMaterialItem(value.key);
                        }),
                    CustomDropDown(
                        label: "Unit Name",
                        marginRight: 0,
                        marginLeft: 0,
                        value: customerCtrl.selectedMaterialPrice,
                        items: customerCtrl.materialItem.value!.materialPrices
                                ?.map((materialPrice) {
                              return DropdownMenuItem<MaterialPrices>(
                                  value: materialPrice,
                                  child:
                                      Text(materialPrice.unitName.toString()));
                            }).toList() ??
                            [],
                        onChanged: (value) {
                          customerCtrl.selectedMaterialPrice = value;

                          customerCtrl.materialUnitCostTxtCtrl.text =
                              value.materialPrice;
                          customerCtrl.materialUnitQuantityTxtCtrl.text = "1";
                          customerCtrl.update();
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: "Matrial Price",
                            controller: customerCtrl.materialUnitCostTxtCtrl,
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            labelText: "Qty",
                            controller:
                                customerCtrl.materialUnitQuantityTxtCtrl,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ));
          });
    },
  );
  // customerCtrl.addNewServiceTextEditingCtrl();
}
