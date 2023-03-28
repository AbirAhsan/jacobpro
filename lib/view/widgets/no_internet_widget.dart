import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:service/view/variables/icon_variables.dart';

import '../../generated/locale_keys.g.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Whoops !"),
          Image.asset(CustomIcons.noInternet),
          Text(LocaleKeys.extra_noInternet.tr()),
        ],
      ),
    );
  }
}
