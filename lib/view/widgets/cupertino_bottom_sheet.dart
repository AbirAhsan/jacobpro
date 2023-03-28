import 'package:flutter/cupertino.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/variables/text_style.dart';

class MyCupertinoBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;

  const MyCupertinoBottomSheet({Key? key, required this.child, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        title ?? "",
        style: CustomTextStyle.titleBoldStyleDarkGrey,
      ),
      message: Container(
        padding: const EdgeInsets.all(16.0),
        // height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: child,
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            PageNavigationService.backScreen();
          },
          child: const Text('CONFIRM',
              style: CustomTextStyle.mediumBoldStylePrimary),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            PageNavigationService.backScreen();
          },
          child: const Text(
            'CLOSE',
            style: CustomTextStyle.mediumBoldStyleDarkGrey,
          ),
        ),
      ],
    );
  }
}
