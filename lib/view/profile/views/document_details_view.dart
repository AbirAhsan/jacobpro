import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/controller/profile_controller.dart';
import 'package:service/services/custom_dialog_class.dart';
import 'package:service/services/image_picker_service.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';

import '../../widgets/custom_collapsed_widget.dart';
import '../../widgets/custom_company_button.dart';
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
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(profileCtrl
                                                .drivingLicenseFrontImage ??
                                            "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![0].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![0].profileDocumentsData!.firstWhereOrNull(
                                                  (doc) =>
                                                      doc.profileDocumentTypeId ==
                                                      11,
                                                )?.profileDocumentURL : ""}"),
                                        fit: BoxFit.cover)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        CustomColors.offWhite.withOpacity(0.5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        ImagePickService()
                                            .getSingleImage(ImageSource.gallery)
                                            .then((imagePath) {
                                          profileCtrl.uploadUserFile(
                                              imagePath, 11);
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                ),
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        profileCtrl.drivingLicenseBackImage ??
                                            "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![0].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![0].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 12)?.profileDocumentURL : ""}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        CustomColors.offWhite.withOpacity(0.5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        ImagePickService()
                                            .getSingleImage(ImageSource.gallery)
                                            .then((imagePath) {
                                          profileCtrl.uploadUserFile(
                                              imagePath, 12);
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                ),
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        profileCtrl.identificationFrontImage ??
                                            "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 13)?.profileDocumentURL : ""}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        CustomColors.offWhite.withOpacity(0.5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        ImagePickService()
                                            .getSingleImage(ImageSource.gallery)
                                            .then((imagePath) {
                                          profileCtrl.uploadUserFile(
                                              imagePath, 13);
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                ),
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        profileCtrl.identificationBackImage ??
                                            "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 14)?.profileDocumentURL : ""}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        CustomColors.offWhite.withOpacity(0.5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        ImagePickService()
                                            .getSingleImage(ImageSource.gallery)
                                            .then((imagePath) {
                                          profileCtrl.uploadUserFile(
                                              imagePath, 14);
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                ),
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        profileCtrl
                                                .technicalLicenseFrontImage ??
                                            "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![2].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![2].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 15)?.profileDocumentURL : ""}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        CustomColors.offWhite.withOpacity(0.5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        ImagePickService()
                                            .getSingleImage(ImageSource.gallery)
                                            .then((imagePath) {
                                          profileCtrl.uploadUserFile(
                                              imagePath, 15);
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                ),
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        profileCtrl.socialSecurityFrontImage ??
                                            "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![3].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![3].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 17)?.profileDocumentURL : ""}",
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        CustomColors.offWhite.withOpacity(0.5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        ImagePickService()
                                            .getSingleImage(ImageSource.gallery)
                                            .then((imagePath) {
                                          profileCtrl.uploadUserFile(
                                              imagePath, 17);
                                        });
                                      },
                                      icon: const Icon(Icons.camera_alt)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                      alignment: Alignment.bottomRight,
                      child: CustomCompanyButton(
                          topMargin: 10,
                          buttonName: "SUBMIT FOR VERIFICATION",
                          //  textStyle: CustomTextStyle.mediumBoldStylePrimary,
                          isFitted: true,
                          onPressed: () async {
                            await profileCtrl.updateOwnProfile();
                            CustomDialogShow.showSuccessDialog(
                                title: "Successfully Submitted",
                                description:
                                    "Your details has been submitted. Please wait Your details has been submitted. Please wait",
                                okayButtonName: "HOME",
                                btnOkOnPress: () {
                                  PageNavigationService.removeAllAndNavigate(
                                      "/DashBoardScreen");
                                });
                          })),
                ],
              );
            }),
      ),
    );
  }
}
