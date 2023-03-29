import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../variables/colors_variable.dart';
import '../variables/text_style.dart';

class CustomDropDown extends StatelessWidget {
  final String? label;
  final Object? value;
  final List<DropdownMenuItem<Object?>>? items;
  final bool isBorderEnabeld;
  final void Function(dynamic)? onChanged;
  final String? Function(Object?)? validator;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double topLeftBorderRadius;
  final double topRightBorderRadius;
  final double bottomLeftBorderRadius;
  final double bottomRightBorderRadius;
  final Color borderSideColor;
  final TextStyle? labelStyle;
  const CustomDropDown({
    super.key,
    this.label,
    this.value,
    @required this.items,
    @required this.onChanged,
    this.isBorderEnabeld = true,
    this.marginTop = 10.0,
    this.marginBottom = 10.0,
    this.marginLeft = 20.0,
    this.marginRight = 20.0,
    this.topLeftBorderRadius = 5.0,
    this.topRightBorderRadius = 5.0,
    this.bottomLeftBorderRadius = 5.0,
    this.bottomRightBorderRadius = 5.0,
    this.validator,
    this.borderSideColor = CustomColors.lightgrey,
    this.labelStyle = CustomTextStyle.normalRegularStyleBlack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      margin: EdgeInsets.fromLTRB(
        marginLeft,
        marginTop,
        marginRight,
        marginBottom,
      ),
      child: DropdownButtonFormField<dynamic>(
        isExpanded: true,
        items: items,
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: CustomColors.white,
          filled: true,
          label: Text(label ?? ""),
          isDense: true,
          contentPadding: EdgeInsets.all(10),
          border: isBorderEnabeld
              ? OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: CustomColors.primary, width: 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(bottomLeftBorderRadius),
                    bottomRight: Radius.circular(bottomRightBorderRadius),
                    topLeft: Radius.circular(topLeftBorderRadius),
                    topRight: Radius.circular(topRightBorderRadius),
                  ),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.lightgrey),
                ),
          focusedBorder: isBorderEnabeld
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(bottomLeftBorderRadius),
                    bottomRight: Radius.circular(bottomRightBorderRadius),
                    topLeft: Radius.circular(topLeftBorderRadius),
                    topRight: Radius.circular(topRightBorderRadius),
                  ),
                  borderSide: const BorderSide(
                    color: CustomColors.primary,
                  ),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
          enabledBorder: isBorderEnabeld
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(bottomLeftBorderRadius),
                    bottomRight: Radius.circular(bottomRightBorderRadius),
                    topLeft: Radius.circular(topLeftBorderRadius),
                    topRight: Radius.circular(topRightBorderRadius),
                  ),
                  borderSide: BorderSide(
                    color: borderSideColor,
                  ))
              : const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
          labelStyle: labelStyle,
        ),
        validator: validator,
      ),
    );
  }
}
