import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service/view/variables/text_style.dart';

class MyCupertinoBottomSheet extends StatelessWidget {
  final Widget child;
  final Widget? title;
  final String? confirmButtonName;
  final String? cancelButtonName;
  final void Function() onConfirm;
  final void Function()? onCancel;

  const MyCupertinoBottomSheet(
      {Key? key,
      required this.child,
      this.title,
      required this.onConfirm,
      required this.onCancel,
      this.confirmButtonName,
      this.cancelButtonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Column(
        children: [
          title!,
          const Divider(),
        ],
      ),
      message: Container(
        padding: const EdgeInsets.all(16.0),
        // height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          //   color: CustomColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: child,
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: onConfirm,
          child: Text(confirmButtonName ?? 'CONFIRM',
              style: CustomTextStyle.mediumBoldStylePrimary),
        ),
        onCancel != null
            ? CupertinoActionSheetAction(
                onPressed: onCancel!,
                child: Text(
                  cancelButtonName ?? 'CLOSE',
                  style: CustomTextStyle.mediumBoldStyleDarkGrey,
                ),
              )
            : Container(),
      ],
    );
  }
}
