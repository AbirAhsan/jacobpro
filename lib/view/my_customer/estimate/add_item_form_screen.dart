import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../../controller/estimate_controller.dart';
import '../../../controller/search_controller.dart';
import '../../widgets/custom_submit_button.dart';
import '../../widgets/search_textfield.dart';

class AddItemFormScreen extends StatelessWidget {
  const AddItemFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String jobUuid = Get.arguments[0];
    String itemType = Get.arguments[1];
    return GetBuilder<EstimatedController>(
        init: EstimatedController(),
        builder: (estimatedCtrl) {
          return Scaffold(
            appBar: AppBar(
              title: Text(itemType == "S" ? "ADD SERVICE" : "ADD MATERIAL"),
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: estimatedCtrl.addItemFormKey,
                  child: Column(
                    children: [
                      GetBuilder<SearchControl>(
                          init: SearchControl(),
                          builder: (searchCtrl) {
                            return CompositedTransformTarget(
                                link: searchCtrl.layerLink,
                                child: ItemSearchTextField(itemType: itemType));
                          }),
                      CustomTextField(
                        labelText: "Description",
                        minLines: 5,
                        maxLines: 6,
                        controller: estimatedCtrl.itemDescriptionTxtCtrl,
                        onChanged: (value) {
                          estimatedCtrl.serviceAndMaterialItemDetailsForm!
                              .itemDescription = value;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              labelText: "Quantity",
                              controller: estimatedCtrl.itemQuantityTxtCtrl,
                              onChanged: (value) {
                                estimatedCtrl.serviceAndMaterialItemDetailsForm!
                                    .itemQty = int.tryParse(value);
                                //calculate total
                                estimatedCtrl.itemTotalTxtCtrl.text =
                                    (double.tryParse(estimatedCtrl
                                                .itemQuantityTxtCtrl.text)! *
                                            double.tryParse(estimatedCtrl
                                                .itemUnitPriceTxtCtrl.text)!)
                                        .toString();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomTextField(
                              labelText: "Unit Price",
                              controller: estimatedCtrl.itemUnitPriceTxtCtrl,
                              onChanged: (value) {
                                estimatedCtrl.serviceAndMaterialItemDetailsForm!
                                    .itemUnitPrice = value;
                                //calculate total
                                estimatedCtrl.itemTotalTxtCtrl.text =
                                    (double.tryParse(value)! *
                                            double.tryParse(estimatedCtrl
                                                .itemQuantityTxtCtrl.text)!)
                                        .toString();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomTextField(
                              labelText: "Total",
                              controller: estimatedCtrl.itemTotalTxtCtrl,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      CheckboxListTile(
                        value: estimatedCtrl
                            .serviceAndMaterialItemDetailsForm!.itemIsTaxable,
                        onChanged: (value) {
                          estimatedCtrl.serviceAndMaterialItemDetailsForm!
                              .itemIsTaxable = value;
                          estimatedCtrl.update();
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: CustomColors.green,
                        title: const Text(
                          "Tax",
                          style: CustomTextStyle.mediumBoldStyleBlack,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomSubmitButton(
                            rightMargin: 4,
                            fizedSize: const Size(double.infinity, 35),
                            buttonName: "Confirm",
                            onPressed: () {
                              estimatedCtrl.addItem(jobUuid);
                            }),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
