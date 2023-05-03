import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/payment_controller.dart';
import 'package:service/view/payment/others_view.dart';
import 'package:service/view/widgets/custom_appbar.dart';

import '../../controller/screen_controller.dart';
import '../../model/job_report_model.dart';
import '../variables/colors_variable.dart';
import '../variables/text_style.dart';
import '../widgets/custom_text_field.dart';
import 'cash_view.dart';
import 'cheque_view.dart';
import 'credit_card_view.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final JobReportModel? jobReport = Get.arguments;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Payment",
        hideNotificationIcon: false,
      ),
      body: GetBuilder<PaymentController>(
          init: PaymentController(),
          initState: (state) {
            Get.put(PaymentController()).initializeTextCtrlData(
                jobReport!.customerEmail,
                jobReport.jobPriceCalculationDto!.jobTotalRemainAmount);
            Get.put(PaymentController()).fetchSavedCardList(
              jobReport.customerId,
            );
          },
          builder: (paymentCtrl) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          marginRight: 5,
                          controller: paymentCtrl.recipientEmailTxtCtrl,
                          labelText: "Email Receipt",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          marginLeft: 5,
                          controller: paymentCtrl.amountTxtCtrl,
                          labelText: "Amount",
                          onChanged: (amount) {
                            paymentCtrl.paymentDetails.paymentAmount = amount;
                            paymentCtrl.update();
                            print(paymentCtrl.paymentDetails.paymentAmount);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<ScreenController>(
                    init: ScreenController(),
                    builder: (screenCtrl) {
                      return SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TabBar(
                            indicatorColor: CustomColors.primary,
                            unselectedLabelColor: CustomColors.grey,
                            controller: screenCtrl.paymentTabController,
                            labelStyle: CustomTextStyle.normalBoldStyleBlack,
                            automaticIndicatorColorAdjustment: true,
                            labelColor: CustomColors.primary,
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                return states.contains(MaterialState.focused)
                                    ? null
                                    : Colors.white;
                              },
                            ),
                            onTap: (value) {
                              screenCtrl.changePaymentTabbar(value);
                            },
                            tabs: [
                              Tab(
                                text: 'CREDIT',
                              ),
                              Tab(
                                text: 'CASH',
                              ),
                              Tab(
                                text: 'CHEQUE',
                              ),
                              Tab(
                                text: 'OTHERS',
                              ),
                            ]),
                      );
                    }),
                SizedBox(
                  height: Get.height - 261,
                  child: GetBuilder<ScreenController>(
                      init: ScreenController(),
                      builder: (screenCtrl) {
                        return TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: screenCtrl.paymentTabController,
                          children: [
                            CreditCardView(jobReport: jobReport),
                            CashViewScreen(jobReport: jobReport),
                            ChequeViewScreen(jobReport: jobReport),
                            OthersViewScreen(jobReport: jobReport)
                          ],
                        );
                      }),
                )
              ],
            );
          }),
    );
  }
}
