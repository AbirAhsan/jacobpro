import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/payment/others_view.dart';
import 'package:service/view/widgets/custom_appbar.dart';

import '../../controller/screen_controller.dart';
import '../variables/colors_variable.dart';
import '../variables/text_style.dart';
import '../widgets/custom_text_field.dart';
import 'cash_view.dart';
import 'check_view.dart';
import 'credit_card_view.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Payment",
        hideNotificationIcon: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    marginRight: 5,
                    labelText: "Email Receipt",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomTextField(
                    marginLeft: 5,
                    labelText: "Amount",
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
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
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
                          text: 'CHECK',
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
                    children: const [
                      CreditCardView(),
                      CashViewScreen(),
                      CheckViewScreen(),
                      OthersViewScreen()
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
