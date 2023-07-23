import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/icon_variables.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_submit_button.dart';

import '../widgets/custom_drawer.dart';

class MyApprenticeScreen extends StatelessWidget {
  const MyApprenticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.lightgrey,
        appBar: AppBar(
          title: const Text(
            "My Apprentice",
          ),
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            CustomIcons.apprentice,
                            width: Get.width / 3,
                            height: Get.width / 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Work Together",
                            style: CustomTextStyle.normalBoldStyleBlack,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Invite your maid/ Apprestic to legally work with you on any assigned job by Jacob Pro",
                            style: CustomTextStyle.normalBoldStyleDarkGrey,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Text(
                            "You don't have any apprentice attached to your account",
                            style: CustomTextStyle.normalBoldStyleBlack,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomSubmitButton(
                              buttonName: "Invite your Apprentice",
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apprentice Request",
                            style: CustomTextStyle.normalBoldStyleBlack,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "You don't have any apprentice request at this moment.",
                            style: CustomTextStyle.normalBoldStyleDarkGrey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
