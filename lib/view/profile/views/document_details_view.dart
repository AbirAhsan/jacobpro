import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/profile_controller.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_text_field.dart';

import '../../widgets/custom_collapsed_widget.dart';
import '../../widgets/custom_cupertino_datetime_picker.dart';

class DocumentDetailsView extends StatelessWidget {
  const DocumentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (profileCtrl) {
              return Column(
                children: [
                  Card(
                    child: Container(
                      width: double.infinity,
                      child: CustomCollapsibleWidget(
                        initiallyCollapsed: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: 0,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Front",
                              style: CustomTextStyle.normalBoldStyleDarkGrey,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: Get.width,
                                height: Get.width / 2,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera_alt)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Back",
                              style: CustomTextStyle.normalBoldStyleDarkGrey,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: Get.width,
                                height: Get.width / 2,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera_alt)),
                              ),
                            ),
                            CupertinoDateTimePicker(
                              labelText: "Expiry Date",
                              minimumYear: 2023,
                              controller: profileCtrl.drivingLicenseTxtCtrl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
