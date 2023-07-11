import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/controller/profile_controller.dart';
import 'package:service/services/file_downloader_service.dart';
import 'package:service/services/file_picker_service.dart';
import 'package:service/services/image_picker_service.dart';
import 'package:service/services/page_navigation_service.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/text_style.dart';

import '../../../services/custom_dialog_class.dart';
import '../../widgets/custom_collapsed_widget.dart';
import '../../widgets/custom_company_button.dart';
import '../../widgets/custom_company_button_with_icon.dart';
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
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomCompanyButtonWithIcon(
                        isFitted: true,
                        topPadding: 0,
                        bottomPadding: 0,
                        buttonName: "FORMS ",
                        icon: Icons.download,
                        onPressed: () {
                          //<=====
                          CustomDialogShow.showInformation(
                              title: "Form List",
                              contents: [
                                ListTile(
                                  leading: const Icon(Icons.file_copy_outlined),
                                  title: const Text("W4 Form"),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        PageNavigationService.backScreen();
                                        await FileDownloaderService().startDownload(
                                            context,
                                            "http://jacobpro.api.jacobpro.net/Files/W4_Form.pdf",
                                            "W4_Form.pdf");
                                      },
                                      icon: const Icon(Icons.file_download)),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.file_copy_outlined),
                                  title: const Text("I-9 Form"),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        PageNavigationService.backScreen();
                                        await FileDownloaderService().startDownload(
                                            context,
                                            "http://jacobpro.api.jacobpro.net/Files/I9_Form.pdf",
                                            "I9_Form.pdf");
                                      },
                                      icon: const Icon(Icons.file_download)),
                                ),
                              ],
                              cancelButtonName: "Close",
                              btnCancelOnPress: () {
                                PageNavigationService.backScreen();
                              });
                        }),
                  ),
                  //<============== Drving License
                  Card(
                    elevation: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomCollapsibleWidget(
                        name: "DRIVING LICENSE",
                        isRequired: true,
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
                                      Get.dialog(AlertDialog(
                                        title: const Text("Choose"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.camera_alt_outlined),
                                              title: const Text("Camera"),
                                              onTap: () {
                                                PageNavigationService
                                                    .backScreen();
                                                ImagePickService()
                                                    .getSingleImage(
                                                        ImageSource.camera)
                                                    .then((imagePath) {
                                                  profileCtrl.uploadUserFile(
                                                      imagePath, 11);
                                                });
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons
                                                  .photo_camera_back_outlined),
                                              title: const Text("Gallery"),
                                              onTap: () {
                                                PageNavigationService
                                                    .backScreen();
                                                ImagePickService()
                                                    .getSingleImage(
                                                        ImageSource.gallery)
                                                    .then((imagePath) {
                                                  profileCtrl.uploadUserFile(
                                                      imagePath, 11);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ));
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                  ),
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
                                        Get.dialog(AlertDialog(
                                          title: const Text("Choose"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.camera_alt_outlined),
                                                title: const Text("Camera"),
                                                onTap: () {
                                                  PageNavigationService
                                                      .backScreen();
                                                  ImagePickService()
                                                      .getSingleImage(
                                                          ImageSource.camera)
                                                      .then((imagePath) {
                                                    profileCtrl.uploadUserFile(
                                                        imagePath, 12);
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons
                                                    .photo_camera_back_outlined),
                                                title: const Text("Gallery"),
                                                onTap: () {
                                                  PageNavigationService
                                                      .backScreen();
                                                  ImagePickService()
                                                      .getSingleImage(
                                                          ImageSource.gallery)
                                                      .then((imagePath) {
                                                    profileCtrl.uploadUserFile(
                                                        imagePath, 12);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ));
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

                  // //<============== Identification License
                  // Card(
                  //   elevation: 5,
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     child: CustomCollapsibleWidget(
                  //       name: "IDENTIFICATION",
                  //       initiallyCollapsed: true,
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const Divider(
                  //             height: 0,
                  //           ),
                  //           const SizedBox(
                  //             height: 20,
                  //           ),
                  //           const Text(
                  //             "Front",
                  //             style: CustomTextStyle.normalBoldStyleDarkGrey,
                  //           ),
                  //           Card(
                  //             elevation: 5,
                  //             child: Container(
                  //               width: Get.width,
                  //               height: Get.width / 2.2,
                  //               alignment: Alignment.topRight,
                  //               decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: CachedNetworkImageProvider(
                  //                       profileCtrl.identificationFrontImage ??
                  //                           "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 13)?.profileDocumentURL : ""}",
                  //                     ),
                  //                     fit: BoxFit.cover),
                  //               ),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color:
                  //                       CustomColors.offWhite.withOpacity(0.5),
                  //                 ),
                  //                 child: IconButton(
                  //                     onPressed: () {
                  //                       Get.dialog(AlertDialog(
                  //                         title: const Text("Choose"),
                  //                         content: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             ListTile(
                  //                               leading: const Icon(
                  //                                   Icons.camera_alt_outlined),
                  //                               title: const Text("Camera"),
                  //                               onTap: () {
                  //                                 PageNavigationService
                  //                                     .backScreen();
                  //                                 ImagePickService()
                  //                                     .getSingleImage(
                  //                                         ImageSource.camera)
                  //                                     .then((imagePath) {
                  //                                   profileCtrl.uploadUserFile(
                  //                                       imagePath, 13);
                  //                                 });
                  //                               },
                  //                             ),
                  //                             ListTile(
                  //                               leading: const Icon(Icons
                  //                                   .photo_camera_back_outlined),
                  //                               title: const Text("Gallery"),
                  //                               onTap: () {
                  //                                 PageNavigationService
                  //                                     .backScreen();
                  //                                 ImagePickService()
                  //                                     .getSingleImage(
                  //                                         ImageSource.gallery)
                  //                                     .then((imagePath) {
                  //                                   profileCtrl.uploadUserFile(
                  //                                       imagePath, 13);
                  //                                 });
                  //                               },
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ));
                  //                     },
                  //                     icon: const Icon(Icons.camera_alt)),
                  //               ),
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           const Text(
                  //             "Back",
                  //             style: CustomTextStyle.normalBoldStyleDarkGrey,
                  //           ),
                  //           Card(
                  //             elevation: 5,
                  //             child: Container(
                  //               width: Get.width,
                  //               height: Get.width / 2.2,
                  //               alignment: Alignment.topRight,
                  //               decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: CachedNetworkImageProvider(
                  //                       profileCtrl.identificationBackImage ??
                  //                           "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 14)?.profileDocumentURL : ""}",
                  //                     ),
                  //                     fit: BoxFit.cover),
                  //               ),
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color:
                  //                       CustomColors.offWhite.withOpacity(0.5),
                  //                 ),
                  //                 child: IconButton(
                  //                     onPressed: () {
                  //                       Get.dialog(AlertDialog(
                  //                         title: const Text("Choose"),
                  //                         content: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: [
                  //                             ListTile(
                  //                               leading: const Icon(
                  //                                   Icons.camera_alt_outlined),
                  //                               title: const Text("Camera"),
                  //                               onTap: () {
                  //                                 PageNavigationService
                  //                                     .backScreen();
                  //                                 ImagePickService()
                  //                                     .getSingleImage(
                  //                                         ImageSource.camera)
                  //                                     .then((imagePath) {
                  //                                   profileCtrl.uploadUserFile(
                  //                                       imagePath, 14);
                  //                                 });
                  //                               },
                  //                             ),
                  //                             ListTile(
                  //                               leading: const Icon(Icons
                  //                                   .photo_camera_back_outlined),
                  //                               title: const Text("Gallery"),
                  //                               onTap: () {
                  //                                 PageNavigationService
                  //                                     .backScreen();
                  //                                 ImagePickService()
                  //                                     .getSingleImage(
                  //                                         ImageSource.gallery)
                  //                                     .then((imagePath) {
                  //                                   profileCtrl.uploadUserFile(
                  //                                       imagePath, 14);
                  //                                 });
                  //                               },
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ));
                  //                     },
                  //                     icon: const Icon(Icons.camera_alt)),
                  //               ),
                  //             ),
                  //           ),
                  //           CupertinoDateTimePicker(
                  //             labelText: "Expiry Date",
                  //             minimumYear: 2023,
                  //             controller: profileCtrl.idCardExpiryTxtCtrl,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  //<========================== Technician License Card

                  Card(
                    elevation: 5,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomCollapsibleWidget(
                        name: "TECHNICAL LICENSE CARD",
                        initiallyCollapsed: true,
                        isRequired: true,
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
                                        Get.dialog(AlertDialog(
                                          title: const Text("Choose"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.camera_alt_outlined),
                                                title: const Text("Camera"),
                                                onTap: () {
                                                  PageNavigationService
                                                      .backScreen();
                                                  ImagePickService()
                                                      .getSingleImage(
                                                          ImageSource.camera)
                                                      .then((imagePath) {
                                                    profileCtrl.uploadUserFile(
                                                        imagePath, 15);
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons
                                                    .photo_camera_back_outlined),
                                                title: const Text("Gallery"),
                                                onTap: () {
                                                  PageNavigationService
                                                      .backScreen();
                                                  ImagePickService()
                                                      .getSingleImage(
                                                          ImageSource.gallery)
                                                      .then((imagePath) {
                                                    profileCtrl.uploadUserFile(
                                                        imagePath, 15);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ));
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
                        isRequired: true,
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
                                        Get.dialog(AlertDialog(
                                          title: const Text("Choose"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.camera_alt_outlined),
                                                title: const Text("Camera"),
                                                onTap: () {
                                                  PageNavigationService
                                                      .backScreen();
                                                  ImagePickService()
                                                      .getSingleImage(
                                                          ImageSource.camera)
                                                      .then((imagePath) {
                                                    profileCtrl.uploadUserFile(
                                                        imagePath, 17);
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons
                                                    .photo_camera_back_outlined),
                                                title: const Text("Gallery"),
                                                onTap: () {
                                                  PageNavigationService
                                                      .backScreen();
                                                  ImagePickService()
                                                      .getSingleImage(
                                                          ImageSource.gallery)
                                                      .then((imagePath) {
                                                    profileCtrl.uploadUserFile(
                                                        imagePath, 17);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ));
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

                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: RichText(
                              text: TextSpan(
                                  text: "",
                                  style: CustomTextStyle
                                      .normalRegularStyleDarkGrey,
                                  children: [
                                    TextSpan(
                                      text: "MY ATTACHMENTS",
                                      style: CustomTextStyle
                                          .mediumBoldStyleDarkGrey,
                                    ),
                                    TextSpan(
                                      text: " *",
                                      style:
                                          CustomTextStyle.mediumBoldStyleError,
                                    ),
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    CustomDialogShow.showInformation(
                                        title: "My Attachment List",
                                        contents: [
                                          ListTile(
                                            leading: const Icon(
                                                Icons.file_copy_outlined),
                                            title: const Text("W4 Form"),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      FilePickService
                                                              .getSingleFile()
                                                          .then((file) {
                                                        profileCtrl
                                                            .uploadUserFile(
                                                                file!.path,
                                                                101);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.file_upload)),
                                                IconButton(
                                                    onPressed: profileCtrl
                                                            .myProfileDetails
                                                            .value!
                                                            .profileDocumentsWrapperData![
                                                                4]
                                                            .profileDocumentsData!
                                                            .any((doc) =>
                                                                doc.profileDocumentTypeId ==
                                                                101)
                                                        ? () async {
                                                            PageNavigationService
                                                                .backScreen();
                                                            await FileDownloaderService()
                                                                .startDownload(
                                                                    context,
                                                                    "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![4].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![4].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 101)?.profileDocumentURL : ""}",
                                                                    "My_W4_File.pdf");
                                                          }
                                                        : null,
                                                    icon: Icon(
                                                      Icons.file_download,
                                                      color: profileCtrl
                                                              .myProfileDetails
                                                              .value!
                                                              .profileDocumentsWrapperData![
                                                                  4]
                                                              .profileDocumentsData!
                                                              .any((doc) =>
                                                                  doc.profileDocumentTypeId ==
                                                                  101)
                                                          ? CustomColors.green
                                                          : CustomColors.grey,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            leading: const Icon(
                                                Icons.file_copy_outlined),
                                            title: const Text("I-9 Form"),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      FilePickService
                                                              .getSingleFile()
                                                          .then((file) {
                                                        profileCtrl
                                                            .uploadUserFile(
                                                                file!.path,
                                                                102);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.file_upload)),
                                                IconButton(
                                                    onPressed: profileCtrl
                                                            .myProfileDetails
                                                            .value!
                                                            .profileDocumentsWrapperData![
                                                                4]
                                                            .profileDocumentsData!
                                                            .any((doc) =>
                                                                doc.profileDocumentTypeId ==
                                                                102)
                                                        ? () async {
                                                            PageNavigationService
                                                                .backScreen();
                                                            await FileDownloaderService()
                                                                .startDownload(
                                                                    context,
                                                                    "${profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![4].profileDocumentsData!.isNotEmpty ? profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![4].profileDocumentsData!.firstWhereOrNull((doc) => doc.profileDocumentTypeId == 102)?.profileDocumentURL : ""}",
                                                                    "My_I9_File.pdf");
                                                          }
                                                        : null,
                                                    icon: Icon(
                                                      Icons.file_download,
                                                      color: profileCtrl
                                                              .myProfileDetails
                                                              .value!
                                                              .profileDocumentsWrapperData![
                                                                  4]
                                                              .profileDocumentsData!
                                                              .any((doc) =>
                                                                  doc.profileDocumentTypeId ==
                                                                  102)
                                                          ? CustomColors.green
                                                          : CustomColors.grey,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                        cancelButtonName: "Close",
                                        btnCancelOnPress: () {
                                          PageNavigationService.backScreen();
                                        });
                                    // FilePickService().getSingleFile();
                                  },
                                  icon: const Icon(Icons.attach_file)),
                              IconButton(
                                  onPressed: () {
                                    CustomDialogShow.showInfoDialog(
                                        title: "Info",
                                        description:
                                            "Please fill out W4 and I-9 Forms and upload, you can download those forms in the link above",
                                        cancelButtonName: "Close",
                                        btnCancelOnPress: () =>
                                            PageNavigationService.backScreen());
                                  },
                                  icon: const Icon(Icons.info)),
                            ],
                          ),
                        ],
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
                          })),
                ],
              );
            }),
      ),
    );
  }
}
