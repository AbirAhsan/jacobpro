import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/services/validator_service.dart';
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
              Get.put(CustomerController()).addNewServiceTextEditingCtrl();
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
                                  "Services",
                                  style:
                                      CustomTextStyle.mediumBoldStyleDarkGrey,
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
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
                                          Visibility(
                                            visible: serviceTextCtrl['id'] != 1,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                  onTap: () {
                                                    customerCtrl
                                                        .closeServiceTextFields(
                                                            serviceTextCtrl[
                                                                'id']);
                                                  },
                                                  child:
                                                      const Icon(Icons.close)),
                                            ),
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
                                                      "unitLabel"],
                                                  controller: serviceTextCtrl[
                                                      "unitCtrl"],
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
                                                      "totalCostCtrl"],
                                                ),
                                              ),
                                            ],
                                          ),
                                          CustomTextField(
                                            labelText: serviceTextCtrl[
                                                "descriptionLabel"],
                                            controller: serviceTextCtrl[
                                                "descriptionCtrl"],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Align(
                                alignment: Alignment.topRight,
                                child: CustomCompanyButtonWithIcon(
                                    buttonName: "Service Item",
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
                                // TextButton(
                                //   onPressed: () {
                                //     customerCtrl.addNewServiceTextEditingCtrl();
                                //   },
                                //   child: Text("+ Service Item"),
                                // ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      //<======================= Material
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Material",
                                  style:
                                      CustomTextStyle.mediumBoldStyleDarkGrey,
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
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
                                          Visibility(
                                            visible: materialCtrl['id'] != 1,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                  onTap: () {
                                                    customerCtrl
                                                        .closeMaterialTextFields(
                                                            materialCtrl['id']);
                                                  },
                                                  child:
                                                      const Icon(Icons.close)),
                                            ),
                                          ),
                                          CustomTextField(
                                            labelText:
                                                materialCtrl["itemLabel"],
                                            controller:
                                                materialCtrl["labelCtrl"],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: materialCtrl[
                                                      "quantityLabel"],
                                                  controller: materialCtrl[
                                                      "quantityCtrl"],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText:
                                                      materialCtrl["unitLabel"],
                                                  controller:
                                                      materialCtrl["unitCtrl"],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  labelText: materialCtrl[
                                                      "totalLabel"],
                                                  controller: materialCtrl[
                                                      "totalCostCtrl"],
                                                ),
                                              ),
                                            ],
                                          ),
                                          CustomTextField(
                                            labelText: materialCtrl[
                                                "descriptionLabel"],
                                            controller:
                                                materialCtrl["descriptionCtrl"],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {
                                    customerCtrl
                                        .addNewMaterialTextEditingCtrl();
                                  },
                                  child: Text("+ Material Item"),
                                ),
                              )
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
