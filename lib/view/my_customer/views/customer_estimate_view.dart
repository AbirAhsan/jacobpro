import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/services/validator_service.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_company_button_with_icon.dart';
import 'package:service/view/widgets/custom_dropdown.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../../controller/customer_controller.dart';
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
                child: Form(
                  key: customerCtrl.addEstimateFormKey,
                  child: Column(
                    children: [
                      //<======================= Serivces
                      Card(
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
                                                  validator: ValidatorService
                                                      .validateSimpleFiled,
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
                                                      "totalLabel"],
                                                  controller: serviceTextCtrl[
                                                      "totalCtrl"],
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
                                      customerCtrl.selectedServicePrice = null;
                                      customerCtrl.selectedService = null;
                                      customerCtrl.serviceUnitQuantityTxtCtrl
                                          .clear();
                                      customerCtrl.serviceUnitCostTxtCtrl
                                          .clear();
                                      showServiceModal(context);
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //<======================= Material
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "MATERIAL",
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
                                      customerCtrl
                                          .addNewMaterialTextEditingCtrl();
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
      return MyCupertinoBottomSheet(
          child: GetBuilder<CustomerController>(
              init: CustomerController(),
              initState: (state) async {
                await Get.put(CustomerController()).getServiceItemList();
              },
              builder: (customerCtrl) {
                return Column(
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
                              value.serviceCost;
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
                );
              }));
    },
  );
  // customerCtrl.addNewServiceTextEditingCtrl();
}
