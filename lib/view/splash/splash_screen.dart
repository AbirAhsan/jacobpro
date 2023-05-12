import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/screen_controller.dart';
import '../variables/colors_variable.dart';
import '../variables/icon_variables.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScreenController screenCtrl = Get.put(ScreenController());
    screenCtrl.splashDelay();
    return Scaffold(
      body: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.all(60),
        child: Center(
          child: Image.asset(CustomIcons.logo),
        ),
      ),
    );
  }
}
