import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';

import '../../widgets/custom_image_icon.dart';

class DashBoardCardWidget1 extends StatelessWidget {
  final String? assetImage;
  final String? name;
  final int? quantity;
  const DashBoardCardWidget1(
      {Key? key, this.assetImage, this.name, this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        // label: name,
        // enabled: true,
        onLongPress: () async {
          debugPrint(name);
          await SemanticsService.announce("$name", TextDirection.ltr);
        },
        child: SizedBox(
          height: 100,
          child: Card(
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomImageIcon(
                    size: 32,
                    imagepath: assetImage,
                    color: CustomColors.primary,
                  ),
                  const Spacer(),
                  FittedBox(
                    child: Text(
                      "$name",
                      style: CustomTextStyle.mediumBoldStyleDarkGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    child: Text(
                      "$quantity",
                      style: CustomTextStyle.mediumBoldStylePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
