import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/controller/profile_controller.dart';
import 'package:service/view/variables/text_style.dart';

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
                  //<============== Drving License
                  Card(
                    elevation: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomCollapsibleWidget(
                        name: "DRIVING LICENSE",
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
                                height: Get.width / 2.2,
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
                                height: Get.width / 2.2,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera_alt)),
                              ),
                            ),
                            CupertinoDateTimePicker(
                              labelText: "Expiry Date",
                              minimumYear: 2023,
                              controller:
                                  profileCtrl.drivingLicenseExpiryTxtCtrl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //<============== Identification License
                  Card(
                    elevation: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomCollapsibleWidget(
                        name: "IDENTIFICATION",
                        initiallyCollapsed: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              height: 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Front",
                              style: CustomTextStyle.normalBoldStyleDarkGrey,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: Get.width,
                                height: Get.width / 2.2,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera_alt)),
                              ),
                            ),
                            const SizedBox(
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
                                height: Get.width / 2.2,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera_alt)),
                              ),
                            ),
                            CupertinoDateTimePicker(
                              labelText: "Expiry Date",
                              minimumYear: 2023,
                              controller: profileCtrl.idCardExpiryTxtCtrl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //<========================== Technician License Card
                  Card(
                    elevation: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomCollapsibleWidget(
                        name: "TECHNICAL LICENSE CARD",
                        initiallyCollapsed: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              height: 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Front",
                              style: CustomTextStyle.normalBoldStyleDarkGrey,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: Get.width,
                                height: Get.width / 2.2,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera_alt)),
                              ),
                            ),
                            CupertinoDateTimePicker(
                              labelText: "Expiry Date",
                              minimumYear: 2023,
                              controller:
                                  profileCtrl.technicalLicenseExpiryTxtCtrl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //<========================== Socity Security Card
                  Card(
                    elevation: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomCollapsibleWidget(
                        name: "SOCIAL SECURITY  CARD",
                        initiallyCollapsed: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              height: 0,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Front",
                              style: CustomTextStyle.normalBoldStyleDarkGrey,
                            ),
                            Card(
                              elevation: 5,
                              child: Container(
                                width: Get.width,
                                height: Get.width / 2.2,
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera_alt)),
                              ),
                            ),
                            CupertinoDateTimePicker(
                              labelText: "Expiry Date",
                              minimumYear: 2023,
                              controller:
                                  profileCtrl.socialSecurityExpiryTxtCtrl,
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
