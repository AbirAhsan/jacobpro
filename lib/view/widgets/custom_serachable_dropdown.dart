import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../variables/colors_variable.dart';

class CustomSearchableDropDown extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final dynamic selectedItem;
  final List<dynamic> items;
  final bool showSelectedItems;
  final bool Function(dynamic)? disabledItemFn;
  final void Function(dynamic)? onChanged;
  final bool isBorderEnabeld;
  final double topLeftBorderRadius;
  final double topRightBorderRadius;
  final double bottomLeftBorderRadius;
  final double bottomRightBorderRadius;
  final Color borderSideColor;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final Key? searchkey;
  final String Function(dynamic)? itemAsString;
  const CustomSearchableDropDown({
    super.key,
    this.labelText,
    this.hintText,
    this.selectedItem,
    required this.items,
    this.onChanged,
    this.showSelectedItems = false,
    this.disabledItemFn,
    this.isBorderEnabeld = true,
    this.topLeftBorderRadius = 5.0,
    this.topRightBorderRadius = 5.0,
    this.bottomLeftBorderRadius = 5.0,
    this.bottomRightBorderRadius = 5.0,
    this.borderSideColor = CustomColors.lightgrey,
    this.marginTop = 10.0,
    this.marginBottom = 10.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.itemAsString,
    this.searchkey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        marginLeft,
        marginTop,
        marginRight,
        marginBottom,
      ),
      child: DropdownSearch<dynamic>(
        key: searchkey,
        popupProps: PopupProps.menu(
          showSelectedItems: showSelectedItems,
          disabledItemFn: showSelectedItems ? disabledItemFn : null,
        ),
        itemAsString: itemAsString,
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
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
            labelText: labelText,
            hintText: hintText,
          ),
        ),
        onChanged: onChanged,
        selectedItem: selectedItem,
      ),
    );
  }
}
