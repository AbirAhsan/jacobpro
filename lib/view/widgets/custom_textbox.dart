import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../variables/colors_variable.dart';
import '../variables/text_style.dart';

class CustomTextBox extends StatelessWidget {
  final String? label;
  final String? text;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  const CustomTextBox({
    super.key,
    this.label,
    this.leftMargin = 10.0,
    this.rightMargin = 10.0,
    this.topMargin = 5.0,
    this.bottomMargin = 5.0,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(leftMargin, topMargin, rightMargin, bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: CustomTextStyle.normalRegularStyleBlack,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: Get.width,
            constraints: const BoxConstraints(
              minHeight: 40,
              minWidth: double.infinity,
              maxHeight: double.infinity,
            ),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            decoration:
                BoxDecoration(border: Border.all(color: CustomColors.grey)),
            child: Text(
              text ?? "",
              textAlign: TextAlign.left,
              style: CustomTextStyle.normalRegularStyleBlack,
            ),
          )
        ],
      ),
    );
  }
}
