import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/payment_controller.dart';
import '../variables/colors_variable.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

class CashViewScreen extends StatelessWidget {
  final String? jobUuid;
  const CashViewScreen({super.key, this.jobUuid});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (paymentCtrl) {
            return Column(
              children: [
                CustomTextField(
                  labelText: "Payment Note",
                  initialValue: paymentCtrl.paymentDetails.paymentNote ?? "",
                  onChanged: (value) {
                    paymentCtrl.paymentDetails.paymentNote = value;
                  },
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
                        onPressed: () {
                          paymentCtrl.submitCashPayment(jobUuid);
                        }),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
