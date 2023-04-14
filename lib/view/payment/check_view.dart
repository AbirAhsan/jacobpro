import 'package:flutter/material.dart';

import '../variables/colors_variable.dart';
import '../widgets/custom_cupertino_datetime_picker.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

class CheckViewScreen extends StatelessWidget {
  const CheckViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomTextField(
                  marginRight: 5,
                  labelText: "Check No",
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: CupertinoDateTimePicker(
                      labelText: "Issue Date",
                    ),
                  )),
            ],
          ),
          CustomTextField(
            marginRight: 10,
            labelText: "Account No",
          ),
          CustomTextField(
            marginRight: 10,
            labelText: "Account Name",
          ),
          CustomTextField(
            marginRight: 10,
            labelText: "Bank Name",
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
