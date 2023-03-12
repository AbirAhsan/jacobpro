import 'package:flutter/material.dart';

import '../variables/colors_variable.dart';
import '../variables/text_style.dart';

class CustomSubmitButton extends StatelessWidget {
  final String? buttonName;
  final void Function()? onPressed;
  final Color? primaryColor;
  final Color borderColor;
  final TextStyle? textStyle;
  final double? elevation;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;
  final Size? fizedSize;
  final double topLeftBorderRadius;
  final double topRightBorderRadius;
  final double bottomLeftBorderRadius;
  final double bottomRightBorderRadius;
  const CustomSubmitButton({
    Key? key,
    required this.onPressed,
    this.buttonName,
    this.fizedSize = const Size(double.infinity, 50),
    this.leftPadding = 0.0,
    this.rightPadding = 0.0,
    this.topPadding = 10.0,
    this.bottomPadding = 10.0,
    this.leftMargin = 0.0,
    this.rightMargin = 0.0,
    this.topMargin = 5.0,
    this.bottomMargin = 5.0,
    this.primaryColor = CustomColors.green,
    this.textStyle = CustomTextStyle.normalBoldStyleWhite,
    this.borderColor = CustomColors.green,
    this.elevation,
    this.topLeftBorderRadius = 10.0,
    this.topRightBorderRadius = 10.0,
    this.bottomLeftBorderRadius = 10.0,
    this.bottomRightBorderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  double width = fizedSize?.width ?? MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.fromLTRB(leftMargin, topMargin, rightMargin, bottomMargin),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: primaryColor,
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          fixedSize: fizedSize,
          // textStyle:
          //     TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: white),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeftBorderRadius),
              bottomRight: Radius.circular(bottomRightBorderRadius),
              topLeft: Radius.circular(topLeftBorderRadius),
              topRight: Radius.circular(topRightBorderRadius),
            ), // <-- Radius
          ),
        ),
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                leftPadding, topPadding, rightPadding, bottomPadding),
            child: Text(
              "$buttonName",
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
