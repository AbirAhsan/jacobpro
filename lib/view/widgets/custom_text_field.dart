import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../variables/colors_variable.dart';
import '../variables/text_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isBorderEnabeld;
  final String? labelText;
  final String? hintText;
  final Color? backgroundColor;
  final String? prefixText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool isRequired;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool expandes;
  final bool? enabled;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final Widget? suffixIcon;
  final Color borderSideColor;
  final double topLeftBorderRadius;
  final double topRightBorderRadius;
  final double bottomLeftBorderRadius;
  final double bottomRightBorderRadius;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(bool)? onFocusChange;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function()? onTap;

  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.suffixIcon,
    this.prefixText,
    this.style = CustomTextStyle.normalRegularStyleBlack,
    this.inputFormatters,
    this.maxLength,
    this.minLines,
    this.isRequired = false,
    this.maxLines = 1,
    this.onChanged,
    this.onTap,
    this.expandes = false,
    this.marginTop = 10.0,
    this.marginBottom = 10.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.hintStyle,
    this.borderSideColor = CustomColors.lightgrey,
    this.isBorderEnabeld = true,
    this.labelStyle,
    this.topLeftBorderRadius = 5.0,
    this.topRightBorderRadius = 5.0,
    this.bottomLeftBorderRadius = 5.0,
    this.bottomRightBorderRadius = 5.0,
    this.errorText,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.contentPadding =
        const EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 5),
    this.onFieldSubmitted,
    this.onSaved,
    this.onEditingComplete,
    this.onFocusChange,
    this.backgroundColor = CustomColors.lightgrey,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        marginLeft,
        marginTop,
        marginRight,
        marginBottom,
      ),
      // decoration: const BoxDecoration(
      //   color: CustomColors.white,
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(5),
      //   ),
      // ),
      child: Focus(
        onFocusChange: onFocusChange,
        child: TextFormField(
          onTap: onTap,
          initialValue: initialValue,
          readOnly: readOnly,
          focusNode: focusNode,
          enabled: enabled,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          style: style,
          expands: expandes,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            fillColor: backgroundColor,
            filled: true,
            alignLabelWithHint: true,
            contentPadding: contentPadding,
            // EdgeInsets.only(
            //     left: 10.0,
            //     top: maxLines! > 1 ? 25 : 30,
            //     bottom: maxLines! > 1 ? 15 : 0),
            isDense: true,

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
                    borderSide: BorderSide.none,
                  ),
            counterText: '',
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
            label: RichText(
              text: TextSpan(
                text: '',
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: labelText,
                    style:
                        labelStyle ?? CustomTextStyle.normalRegularStyleBlack,
                  ),
                  TextSpan(
                      text: isRequired ? '*' : '',
                      style: CustomTextStyle.normalRegularStyleError),
                ],
              ),
            ),
            //labelText: labelText,
            labelStyle: labelStyle ?? CustomTextStyle.normalRegularStyleBlack,
            hintText: hintText,
            floatingLabelStyle: CustomTextStyle.normalRegularStyleBlack,
            hintStyle: hintStyle,
            prefixIcon: prefixIcon,
            prefixIconColor: CustomColors.grey,

            prefixText: prefixText,
            prefixStyle: style,
            suffixIcon: suffixIcon,
            errorText: errorText,
          ),
          textAlign: textAlign,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
