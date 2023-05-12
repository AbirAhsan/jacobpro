import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/job_controller.dart';
import '../../controller/payment_controller.dart';
import '../../model/job_report_model.dart';
import '../widgets/custom_cupertino_datetime_picker.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

class ChequeViewScreen extends StatelessWidget {
  final JobReportModel? jobReport;
  const ChequeViewScreen({super.key, this.jobReport});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: GetBuilder<PaymentController>(
          init: PaymentController(),
          builder: (paymentCtrl) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        marginRight: 5,
                        labelText: "Cheque No",
                        initialValue: paymentCtrl.checkDetails.chequeNo ?? "",
                        onChanged: (value) {
                          paymentCtrl.checkDetails.chequeNo = value;
                          paymentCtrl.update();
                        },
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 10),
                          child: CupertinoDateTimePicker(
                            labelText: "Expiry Date",
                            minimumYear: 2023,
                            controller: paymentCtrl.chequeDateTxtCtrl,
                          ),
                        )),
                  ],
                ),
                CustomTextField(
                  marginRight: 10,
                  labelText: "Account No",
                  initialValue:
                      paymentCtrl.checkDetails.chequeBankAccountNo ?? "",
                  onChanged: (value) {
                    paymentCtrl.checkDetails.chequeBankAccountNo = value;
                    paymentCtrl.update();
                  },
                ),
                CustomTextField(
                  marginRight: 10,
                  labelText: "Account Name",
                  initialValue:
                      paymentCtrl.checkDetails.chequeBankAccountName ?? "",
                  onChanged: (value) {
                    paymentCtrl.checkDetails.chequeBankAccountName = value;
                    paymentCtrl.update();
                  },
                ),
                CustomTextField(
                  marginRight: 10,
                  labelText: "Bank Name",
                  initialValue: paymentCtrl.checkDetails.chequeBankName ?? "",
                  onChanged: (value) {
                    paymentCtrl.checkDetails.chequeBankName = value;
                    paymentCtrl.update();
                  },
                ),
                CustomTextField(
                  labelText: "Payment Note",
                  initialValue: paymentCtrl.paymentDetails.paymentNote ?? "",
                  onChanged: (value) {
                    paymentCtrl.paymentDetails.paymentNote = value;
                    paymentCtrl.update();
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
                              .submitChequePayment(jobReport!.jobUuid);
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
