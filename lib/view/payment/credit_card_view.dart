import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/widgets/custom_submit_button.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../controller/payment_controller.dart';

class CreditCardView extends StatelessWidget {
  final String? jobUuid;
  const CreditCardView({super.key, this.jobUuid});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (paymentCtrl) {
            return Column(
              children: [
                CustomTextField(
                  labelText: "Name On Card",
                  initialValue: paymentCtrl.cardDetails.cardHolderName ?? "",
                  onChanged: (name) {
                    paymentCtrl.cardDetails.cardHolderName = name;
                    paymentCtrl.update();
                    print(paymentCtrl.cardDetails.cardHolderName);
                  },
                ),
                CustomTextField(
                  labelText: "Card Number",
                  initialValue: paymentCtrl.cardDetails.cardNo ?? "",
                  onChanged: (value) {
                    paymentCtrl.cardDetails.cardNo = value;
                    paymentCtrl.update();
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CustomTextField(
                          marginRight: 5,
                          labelText: "Expiry Month",
                          hintText: "mm",
                          onChanged: (month) {
                            paymentCtrl.cardDetails.cardExpiryMonth =
                                int.parse(month);
                            paymentCtrl.update();
                          },
                        )),
                    Expanded(
                        flex: 1,
                        child: CustomTextField(
                          marginLeft: 5,
                          marginRight: 5,
                          labelText: "Expiry Year",
                          hintText: "yyyy",
                          onChanged: (year) {
                            paymentCtrl.cardDetails.cardExpiryMonth =
                                int.parse(year);
                            paymentCtrl.update();
                          },
                        )),
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        marginLeft: 10,
                        labelText: "CVC",
                        onChanged: (cvc) {
                          paymentCtrl.cardDetails.cardCvc = int.parse(cvc);
                          paymentCtrl.update();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        marginRight: 10,
                        labelText: "Street",
                        initialValue:
                            paymentCtrl.cardDetails.cardBillingStreet ?? "",
                        onChanged: (value) {
                          paymentCtrl.cardDetails.cardBillingStreet = value;
                          paymentCtrl.update();
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        marginLeft: 10,
                        labelText: "Postal Code",
                        initialValue:
                            paymentCtrl.cardDetails.cardBillingZip ?? "",
                        onChanged: (value) {
                          paymentCtrl.cardDetails.cardBillingZip = value;
                          paymentCtrl.update();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        marginRight: 10,
                        labelText: "City",
                        initialValue:
                            paymentCtrl.cardDetails.cardBillingCity ?? "",
                        onChanged: (value) {
                          paymentCtrl.cardDetails.cardBillingCity = value;
                          paymentCtrl.update();
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        marginLeft: 10,
                        labelText: "State",
                        initialValue:
                            paymentCtrl.cardDetails.cardBillingStreet ?? "",
                        onChanged: (value) {
                          paymentCtrl.paymentDetails.cardData
                              ?.cardBillingState = value;
                          paymentCtrl.update();
                        },
                      ),
                    ),
                  ],
                ),
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
                          paymentCtrl.submitCardPayment(jobUuid);
                        }),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
