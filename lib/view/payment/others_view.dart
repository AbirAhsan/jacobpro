import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/payment_controller.dart';

import '../variables/colors_variable.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

class OthersViewScreen extends StatelessWidget {
  const OthersViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: GetBuilder<PaymentController>(
          init: PaymentController(),
          initState: (state) {
            Get.put(PaymentController()).getOtherPaymentList();
          },
          builder: (paymentCtrl) {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: paymentCtrl.paymentMethodList.length,
                    itemBuilder: (buildContext, index) {
                      var paymentMethod = paymentCtrl.paymentMethodList[index];
                      return Row(
                        children: [
                          RadioMenuButton(
                              value: paymentMethod["key"],
                              groupValue:
                                  paymentCtrl.selectedOtherPaymentMethod,
                              onChanged: (value) {
                                paymentCtrl.selectedOtherPaymentMethod = value;
                                paymentCtrl.update();
                              },
                              child: Text(paymentMethod["value"]))
                        ],
                      );
                    }),
                CustomTextField(
                  labelText: "Payment Note",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomSubmitButton(
                        buttonName: "CANCEL",
                        leftMargin: 5,
                        rightMargin: 5,
                        bottomRightBorderRadius: 0,
                        bottomLeftBorderRadius: 0,
                        topLeftBorderRadius: 0,
                        topRightBorderRadius: 0,
                        primaryColor: CustomColors.darkGrey,
                        fizedSize: const Size(double.infinity, 30),
                        onPressed: () {}),
                    CustomSubmitButton(
                        buttonName: "CONFIRM PAYMENT",
                        leftMargin: 5,
                        rightMargin: 5,
                        bottomRightBorderRadius: 0,
                        bottomLeftBorderRadius: 0,
                        topLeftBorderRadius: 0,
                        topRightBorderRadius: 0,
                        fizedSize: const Size(double.infinity, 30),
                        onPressed: () {}),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
