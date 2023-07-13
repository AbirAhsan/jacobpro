import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/services/custom_dialog_class.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/widgets/custom_appbar.dart';
import 'package:service/view/widgets/custom_dropdown.dart';
import 'package:service/view/widgets/custom_text_field.dart';
import 'package:service/view/widgets/custom_textbox.dart';

import '../../../controller/estimate_controller.dart';
import '../../../model/service_and_material_item_model.dart';
import '../../variables/colors_variable.dart';
import '../../variables/text_style.dart';
import '../../widgets/custom_company_button_with_icon.dart';

class EstimateDetailsScreen extends StatelessWidget {
  const EstimateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? jobUuid = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Esitmate Details",
      ),
      body: SingleChildScrollView(
        child: GetBuilder<EstimatedController>(
            init: EstimatedController(),
            initState: (state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.put(EstimatedController()).fetchEstimationDetails(jobUuid);
              });
            },
            builder: (estimatedCtrl) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "SERVICES",
                                style: CustomTextStyle.mediumBoldStyleDarkGrey,
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Divider(),
                            estimatedCtrl.estimationDetails!.lineItems!
                                    .where((item) => item.itemType == "S")
                                    .toList()
                                    .isEmpty
                                ? Container()
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: estimatedCtrl
                                        .estimationDetails!.lineItems!
                                        .where((item) => item.itemType == "S")
                                        .toList()
                                        .length,
                                    itemBuilder: (buildContex, index) {
                                      ServiceandMaterialItemModel serviceItem =
                                          estimatedCtrl
                                              .estimationDetails!.lineItems!
                                              .where((item) =>
                                                  item.itemType == "S")
                                              .toList()[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      estimatedCtrl
                                                          .assignDataForEditItemForm(
                                                              serviceItem);
                                                      PageNavigationService
                                                          .generalNavigation(
                                                              '/AddItemFormScreen',
                                                              arguments: [
                                                            estimatedCtrl
                                                                .estimationDetails!
                                                                .jobDto!
                                                                .jobUuid,
                                                            "S"
                                                          ]);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: CustomColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.1)),
                                                        child: const Icon(
                                                          Icons
                                                              .edit_calendar_outlined,
                                                          color: CustomColors
                                                              .primary,
                                                          size: 16,
                                                        ))),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                    onTap: () async {
                                                      await estimatedCtrl.deleteItem(
                                                          estimatedCtrl
                                                              .estimationDetails!
                                                              .jobDto!
                                                              .jobUuid,
                                                          serviceItem,
                                                          (double.tryParse(serviceItem
                                                                      .itemQty
                                                                      .toString())! *
                                                                  double.tryParse(
                                                                      serviceItem
                                                                              .itemUnitPrice ??
                                                                          "0")!)
                                                              .toString());
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: CustomColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.1)),
                                                        child: const Icon(
                                                          Icons.delete_outline,
                                                          color: CustomColors
                                                              .primary,
                                                          size: 16,
                                                        ))),
                                              ],
                                            ),
                                            CustomTextBox(
                                              label: "Item",
                                              text: serviceItem.itemName,
                                              topMargin: 0,
                                            ),
                                            CustomTextBox(
                                              label: "Description ",
                                              text: serviceItem.itemDescription,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: CustomTextBox(
                                                    label: "Quantity",
                                                    text:
                                                        "${serviceItem.itemQty}",
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextBox(
                                                    label: "Unit Price",
                                                    text: serviceItem
                                                        .itemUnitPrice,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextBox(
                                                    label: "Total",
                                                    text: (double.tryParse(
                                                                serviceItem
                                                                    .itemQty
                                                                    .toString())! *
                                                            double.tryParse(
                                                                serviceItem
                                                                        .itemUnitPrice ??
                                                                    "0")!)
                                                        .toString(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CheckboxListTile(
                                              value: serviceItem.itemIsTaxable,
                                              onChanged: null,
                                              dense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              activeColor: CustomColors.green,
                                              title: const Text(
                                                "Tax",
                                                style: CustomTextStyle
                                                    .mediumBoldStyleBlack,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              color: CustomColors.grey,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                            Align(
                              alignment: Alignment.topRight,
                              child: CustomCompanyButtonWithIcon(
                                  buttonName: "ADD SERVICE",
                                  topMargin: 0,
                                  bottomMargin: 0,
                                  bottomPadding: 0,
                                  topPadding: 0,
                                  fizedSize: const Size(double.infinity, 30),
                                  icon: null,
                                  isFitted: true,
                                  onPressed: () async {
                                    estimatedCtrl.clearForTextCtrl();
                                    PageNavigationService.generalNavigation(
                                        '/AddItemFormScreen',
                                        arguments: [
                                          estimatedCtrl.estimationDetails!
                                              .jobDto!.jobUuid,
                                          "S"
                                        ]);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //<-============= Material
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "MATERIALS",
                                style: CustomTextStyle.mediumBoldStyleDarkGrey,
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Divider(),
                            estimatedCtrl.estimationDetails!.lineItems!
                                    .where((item) => item.itemType == "M")
                                    .toList()
                                    .isEmpty
                                ? Container()
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: estimatedCtrl
                                        .estimationDetails!.lineItems!
                                        .where((item) => item.itemType == "M")
                                        .toList()
                                        .length,
                                    itemBuilder: (buildContex, index) {
                                      ServiceandMaterialItemModel materialItem =
                                          estimatedCtrl
                                              .estimationDetails!.lineItems!
                                              .where((item) =>
                                                  item.itemType == "M")
                                              .toList()[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      estimatedCtrl
                                                          .assignDataForEditItemForm(
                                                              materialItem);
                                                      PageNavigationService
                                                          .generalNavigation(
                                                              '/AddItemFormScreen',
                                                              arguments: [
                                                            estimatedCtrl
                                                                .estimationDetails!
                                                                .jobDto!
                                                                .jobUuid,
                                                            "M"
                                                          ]);
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: CustomColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.1)),
                                                        child: const Icon(
                                                          Icons
                                                              .edit_calendar_outlined,
                                                          color: CustomColors
                                                              .primary,
                                                          size: 16,
                                                        ))),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                    onTap: () async {
                                                      await estimatedCtrl.deleteItem(
                                                          estimatedCtrl
                                                              .estimationDetails!
                                                              .jobDto!
                                                              .jobUuid,
                                                          materialItem,
                                                          (double.tryParse(materialItem
                                                                      .itemQty
                                                                      .toString())! *
                                                                  double.tryParse(
                                                                      materialItem
                                                                              .itemUnitPrice ??
                                                                          "0")!)
                                                              .toString());
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: CustomColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.1)),
                                                        child: const Icon(
                                                          Icons.delete_outline,
                                                          color: CustomColors
                                                              .primary,
                                                          size: 16,
                                                        ))),
                                              ],
                                            ),
                                            CustomTextBox(
                                              label: "Item",
                                              text: materialItem.itemName,
                                              topMargin: 0,
                                            ),
                                            CustomTextBox(
                                              label: "Description ",
                                              text:
                                                  materialItem.itemDescription,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: CustomTextBox(
                                                    label: "Quantity",
                                                    text:
                                                        "${materialItem.itemQty}",
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextBox(
                                                    label: "Unit Price",
                                                    text: materialItem
                                                        .itemUnitPrice,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextBox(
                                                    label: "Total",
                                                    text: (double.tryParse(
                                                                materialItem
                                                                    .itemQty
                                                                    .toString())! *
                                                            double.tryParse(
                                                                materialItem
                                                                        .itemUnitPrice ??
                                                                    "0")!)
                                                        .toString(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CheckboxListTile(
                                              value: materialItem.itemIsTaxable,
                                              onChanged: null,
                                              dense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              activeColor: CustomColors.green,
                                              title: const Text(
                                                "Tax",
                                                style: CustomTextStyle
                                                    .mediumBoldStyleBlack,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              color: CustomColors.grey,
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
                                    estimatedCtrl.clearForTextCtrl();
                                    PageNavigationService.generalNavigation(
                                        '/AddItemFormScreen',
                                        arguments: [
                                          estimatedCtrl.estimationDetails!
                                              .jobDto!.jobUuid,
                                          "M"
                                        ]);
                                  }),
                            ),
                          ],
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
                                const Expanded(flex: 1, child: Text('')),
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Service Price',
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${estimatedCtrl.totalServicePrice}",
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
                                const Expanded(flex: 1, child: Text('')),
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Material Price',
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${estimatedCtrl.totalMaterialPrice}",
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
                                const Expanded(flex: 1, child: Text('')),
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'SUB Total',
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "\$${(estimatedCtrl.totalServicePrice + estimatedCtrl.totalMaterialPrice)}",
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    ))
                              ],
                            ),
                            const Divider(),
                            //Discount
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: const Icon(
                                          Icons.edit_document,
                                          color: CustomColors.primary,
                                        ),
                                        onTap: () {
                                          estimatedCtrl.discountDesTxtCrtl
                                              .text = estimatedCtrl
                                                  .discountDescription ??
                                              "";
                                          estimatedCtrl
                                                  .discountAmountTxtCrtl.text =
                                              estimatedCtrl.discountAmount ??
                                                  "";
                                          CustomDialogShow.showInformation(
                                            title: "Discount",
                                            contents: [
                                              Text(
                                                  "Only one type of discount may be applied at a time"),
                                              StatefulBuilder(
                                                  builder: (context, setState) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: estimatedCtrl
                                                        .discountTypeList
                                                        .map((discount) {
                                                      return Row(
                                                        children: [
                                                          Radio(
                                                            visualDensity: const VisualDensity(
                                                                horizontal:
                                                                    VisualDensity
                                                                        .minimumDensity,
                                                                vertical:
                                                                    VisualDensity
                                                                        .minimumDensity),
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            value:
                                                                discount['id'],
                                                            groupValue:
                                                                estimatedCtrl
                                                                    .selectedDiscount,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                estimatedCtrl
                                                                        .selectedDiscount =
                                                                    value;
                                                              });

                                                              estimatedCtrl
                                                                  .update();
                                                            },
                                                          ),
                                                          Text(
                                                              "${discount['text']}")
                                                        ],
                                                      );
                                                    }).toList(),
                                                  ),
                                                );
                                              }),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomTextField(
                                                      marginLeft: 0,
                                                      marginRight: 5,
                                                      minLines: 1,
                                                      maxLines: 3,
                                                      labelText:
                                                          "Description (opt.)",
                                                      controller: estimatedCtrl
                                                          .discountDesTxtCrtl,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomTextField(
                                                      marginLeft: 5,
                                                      marginRight: 0,
                                                      labelText: "Amount",
                                                      controller: estimatedCtrl
                                                          .discountAmountTxtCrtl,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                            cancelButtonName: "Delete",
                                            btnCancelOnPress: () {
                                              estimatedCtrl.discount = 0.0;
                                              estimatedCtrl.discountAmount =
                                                  null;
                                              estimatedCtrl
                                                  .discountDescription = null;
                                              estimatedCtrl
                                                  .discountAmountTxtCrtl
                                                  .clear();
                                              estimatedCtrl.discountDesTxtCrtl
                                                  .clear();

                                              estimatedCtrl.update();
                                              PageNavigationService
                                                  .backScreen();
                                              estimatedCtrl
                                                  .updateEstimate(jobUuid);
                                            },
                                            okayButtonName: "Save",
                                            btnOkOnPress: () {
                                              estimatedCtrl.discountAmount =
                                                  estimatedCtrl
                                                      .discountAmountTxtCrtl
                                                      .text;
                                              estimatedCtrl
                                                      .discountDescription =
                                                  estimatedCtrl
                                                      .discountDesTxtCrtl.text;
                                              if (estimatedCtrl
                                                      .selectedDiscount ==
                                                  "1") {
                                                estimatedCtrl
                                                    .discount = (estimatedCtrl
                                                            .totalMaterialPrice +
                                                        estimatedCtrl
                                                            .totalServicePrice) *
                                                    (double.parse(estimatedCtrl
                                                                .discountAmount ??
                                                            "0") *
                                                        0.01);
                                              } else {
                                                estimatedCtrl.discount =
                                                    double.parse(estimatedCtrl
                                                            .discountAmount ??
                                                        "0");
                                              }
                                              estimatedCtrl.update();
                                              estimatedCtrl
                                                  .updateEstimate(jobUuid);
                                              PageNavigationService
                                                  .backScreen();
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            'Discount',
                                            style: CustomTextStyle
                                                .mediumRegularStyleBlack,
                                            textAlign: TextAlign.right,
                                          ),
                                          estimatedCtrl.discountAmount !=
                                                      null ||
                                                  estimatedCtrl
                                                          .discountAmount !=
                                                      '' ||
                                                  estimatedCtrl
                                                          .discountAmount !=
                                                      0.0
                                              ? RichText(
                                                  text: TextSpan(
                                                    text: '',
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: [
                                                      TextSpan(
                                                        text: estimatedCtrl
                                                            .discountDescription,
                                                        style: CustomTextStyle
                                                            .normalRegularStyleGrey,
                                                      ),
                                                      TextSpan(
                                                          text:
                                                              " (${estimatedCtrl.discountAmount ?? ""}",
                                                          style: CustomTextStyle
                                                              .normalRegularStyleGrey),
                                                      TextSpan(
                                                          text: estimatedCtrl
                                                                      .selectedDiscount ==
                                                                  "P"
                                                              ? "%)"
                                                              : estimatedCtrl
                                                                          .selectedDiscount ==
                                                                      "F"
                                                                  ? ")"
                                                                  : "",
                                                          style: CustomTextStyle
                                                              .normalRegularStyleGrey),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "(-) \$${estimatedCtrl.discount}",
                                      style: CustomTextStyle
                                          .mediumRegularStyleBlack,
                                      textAlign: TextAlign.right,
                                    ))
                              ],
                            ),
                            const Divider(),
                            //<= Tax

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // const Expanded(flex: 1, child: Text('')),
                                Expanded(
                                  flex: 7,
                                  child: CustomDropDown(
                                    marginRight: 0,
                                    label: "Tax Rate",
                                    labelStyle:
                                        CustomTextStyle.mediumRegularStyleGrey,
                                    value: estimatedCtrl.selectedTaxCategory,
                                    items: estimatedCtrl.taxCategoryList
                                        .map((tax) {
                                      return DropdownMenuItem(
                                        value: tax['id'],
                                        child: Text(
                                            "${tax['text']} (${tax['percent']})"),
                                        onTap: () {
                                          estimatedCtrl.selectedTaxRate =
                                              tax['percent'];
                                          estimatedCtrl.calculateTax();
                                        },
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      estimatedCtrl.selectedTaxCategory =
                                          value as int?;
                                      estimatedCtrl.update();
                                      estimatedCtrl.updateEstimate(jobUuid);
                                    },
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      "(+) \$${estimatedCtrl.totalTaxAmount}",
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
                                // const Expanded(flex: 2, child: Text('')),
                                const Expanded(
                                    flex: 7,
                                    child: Text(
                                      'FINAL BILL',
                                      style:
                                          CustomTextStyle.mediumBoldStyleBlack,
                                      textAlign: TextAlign.right,
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      "\$${(estimatedCtrl.totalServicePrice + estimatedCtrl.totalMaterialPrice - estimatedCtrl.discount + estimatedCtrl.totalTaxAmount)}",
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
                  ],
                ),
              );
            }),
      ),
    );
  }
}
