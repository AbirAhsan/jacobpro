import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/job_controller.dart';
import '../../controller/payment_controller.dart';
import '../../model/job_report_model.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

class CashViewScreen extends StatelessWidget {
  final JobReportModel? jobReport;
  const CashViewScreen({super.key, this.jobReport});

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
                        buttonName: "CONFIRM PAYMENT",
                        leftMargin: 5,
                        rightMargin: 5,
                        bottomRightBorderRadius: 0,
                        bottomLeftBorderRadius: 0,
                        topLeftBorderRadius: 0,
                        topRightBorderRadius: 0,
                        fizedSize: const Size(double.infinity, 30),
                        onPressed: () async {
                          await paymentCtrl
                              .submitCashPayment(jobReport!.jobUuid);
                          await paymentCtrl
                              .fetchJobPaymentSummery(jobReport!.jobSystemId);
                          await Get.put(JobController())
                              .fetchJobLifeCycle(jobReport!.jobUuid);
                          await Get.put(JobController())
                              .fetchJobReportDetails(jobReport!.jobUuid);
                        }),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
