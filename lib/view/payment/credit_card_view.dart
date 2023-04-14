import 'package:flutter/material.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/widgets/custom_submit_button.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../widgets/custom_cupertino_datetime_picker.dart';

class CreditCardView extends StatelessWidget {
  const CreditCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CustomTextField(
            labelText: "Name On Card",
          ),
          CustomTextField(
            labelText: "Card Number",
          ),
          CustomTextField(
            labelText: "Name On Card",
          ),
          Row(
            children: [
              Expanded(flex: 2, child: CupertinoDateTimePicker()),
              Expanded(
                flex: 1,
                child: CustomTextField(
                  marginLeft: 10,
                  labelText: "CVC",
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
                ),
              ),
              Expanded(
                child: CustomTextField(
                  marginLeft: 10,
                  labelText: "Postal Code",
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
                ),
              ),
              Expanded(
                child: CustomTextField(
                  marginLeft: 10,
                  labelText: "State",
                ),
              ),
            ],
          ),
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
      ),
    );
  }
}
