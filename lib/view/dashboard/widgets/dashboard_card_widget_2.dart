import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';

class DashBoardCardWidget2 extends StatelessWidget {
  final String? assetImage;
  final String? name;
  final void Function()? onTap;

  const DashBoardCardWidget2({
    Key? key,
    this.assetImage,
    this.name,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        // label: name,
        // enabled: true,
        onLongPress: () async {
          debugPrint(name);
          await SemanticsService.announce("$name", TextDirection.ltr);
        },
        onTap: onTap,
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                          assetImage ?? "",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: CustomColors.white,
                  alignment: Alignment.center,
                  child: Text(
                    "$name",
                    style: CustomTextStyle.normalRegularStylePrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
