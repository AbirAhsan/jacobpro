import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/view/profile/views/contact_details_view.dart';
import 'package:service/view/profile/views/document_details_view.dart';
import 'package:service/view/profile/views/employee_details_view.dart';

import '../../controller/profile_controller.dart';
import '../../controller/screen_controller.dart';
import '../variables/colors_variable.dart';
import '../variables/text_style.dart';
import '../widgets/custom_drawer.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (profileCtrl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Profile"),
              bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 5, bottom: 5),
                        child: profileCtrl
                                    .myProfileDetails
                                    .value!
                                    .profileGeneralData
                                    ?.userVerificationStatus ==
                                -1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "SUBMISSION PENDING",
                                    style: CustomTextStyle.titleBoldStyleGreen,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Your profile isn't submitted yet. Please provide all the data properly and submit to get reviewed and verified!",
                                    style:
                                        CustomTextStyle.normalRegularStyleGrey,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )
                            : profileCtrl
                                        .myProfileDetails
                                        .value!
                                        .profileGeneralData
                                        ?.userVerificationStatus ==
                                    1
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "ACCOUNT VERIFIED",
                                        style:
                                            CustomTextStyle.titleBoldStyleGreen,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "You're now eligible to use all the permitted features of the app.",
                                        style: CustomTextStyle
                                            .normalRegularStyleGrey,
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  )
                                : profileCtrl
                                            .myProfileDetails
                                            .value!
                                            .profileGeneralData
                                            ?.userVerificationStatus ==
                                        2
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "VERIFICATION DECLINED",
                                            style: CustomTextStyle
                                                .titleBoldStyleError,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "Administrator has declined your verification request. Please provide all the data properly and submit to get reviewed and verified!",
                                            style: CustomTextStyle
                                                .normalRegularStyleGrey,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      )
                                    : profileCtrl
                                                .myProfileDetails
                                                .value!
                                                .profileGeneralData
                                                ?.userVerificationStatus ==
                                            0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "VERIFICATION PENDING!",
                                                style: CustomTextStyle
                                                    .titleBoldStylWarning,
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "Your profile is under verification process. You'll get updated once the admin approve/decline it.",
                                                style: CustomTextStyle
                                                    .normalRegularStyleGrey,
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "",
                                                style: CustomTextStyle
                                                    .titleBoldStylWarning,
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "",
                                                style: CustomTextStyle
                                                    .normalRegularStyleGrey,
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                      ),
                      GetBuilder<ScreenController>(
                          init: ScreenController(),
                          builder: (screenCtrl) {
                            return Center(
                              child: TabBar(
                                indicatorColor: CustomColors.primary,
                                unselectedLabelColor: CustomColors.grey,
                                controller: screenCtrl.profileTabController,
                                labelStyle:
                                    CustomTextStyle.normalBoldStyleBlack,
                                automaticIndicatorColorAdjustment: true,
                                labelColor: CustomColors.primary,
                                isScrollable: true,
                                onTap: (value) {
                                  screenCtrl.changeProfileTabbar(value);
                                },
                                tabs: [
                                  Tab(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('GENERAL'),
                                        const SizedBox(width: 8),
                                        profileCtrl.pFirstNameTxtCtrl!.text ==
                                                    "" ||
                                                profileCtrl
                                                        .pLastNameTxtCtrl!.text ==
                                                    "" ||
                                                profileCtrl
                                                        .pPhoneTxtCtrl!.text ==
                                                    "" ||
                                                profileCtrl
                                                        .pEmailTxtCtrl!.text ==
                                                    "" ||
                                                profileCtrl
                                                        .eFirstNameTxtCtrl!.text ==
                                                    "" ||
                                                profileCtrl
                                                        .eLastNameTxtCtrl!.text ==
                                                    "" ||
                                                profileCtrl
                                                        .ePhoneTxtCtrl!.text ==
                                                    "" ||
                                                profileCtrl
                                                        .eEmailTxtCtrl!.text ==
                                                    ""
                                            ? Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        CustomColors.warning),
                                                child: const Icon(
                                                  Icons.error_outline,
                                                  size: 18,
                                                  color: CustomColors.white,
                                                ),
                                              )
                                            : Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: CustomColors.green),
                                                child: const Icon(
                                                  Icons.check,
                                                  size: 14,
                                                  color: CustomColors.white,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('SKILLS'),
                                        const SizedBox(width: 8),
                                        (profileCtrl.selectedSKillSubCategoryId ==
                                                        17 &&
                                                    (profileCtrl
                                                            .selectedSkillList!
                                                            .isEmpty ||
                                                        (profileCtrl.selectedSkillList!
                                                                .any((skill) =>
                                                                    skill!
                                                                        .skillId ==
                                                                    30) &&
                                                            profileCtrl
                                                                    .otherSkillTxtCtrl
                                                                    .text ==
                                                                ""))) ||
                                                (profileCtrl.selectedSKillSubCategoryId !=
                                                        17 &&
                                                    profileCtrl
                                                            .selectedSKillId ==
                                                        null) ||
                                                profileCtrl
                                                        .myProfileDetails
                                                        .value
                                                        ?.profileGeneralData
                                                        ?.workingMode ==
                                                    null
                                            ? Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        CustomColors.warning),
                                                child: const Icon(
                                                  Icons.error_outline,
                                                  size: 18,
                                                  color: CustomColors.white,
                                                ),
                                              )
                                            : Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: CustomColors.green),
                                                child: const Icon(
                                                  Icons.check,
                                                  size: 14,
                                                  color: CustomColors.white,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('DOCUMENTS'),
                                        const SizedBox(width: 8),
                                        profileCtrl.drivingLicenseExpiryTxtCtrl!.text != "" &&
                                                profileCtrl.idCardExpiryTxtCtrl!.text !=
                                                    "" &&
                                                profileCtrl.technicalLicenseExpiryTxtCtrl!.text !=
                                                    "" &&
                                                profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![0].profileDocumentsData!
                                                    .any((doc) =>
                                                        doc.profileDocumentTypeId ==
                                                        11) &&
                                                profileCtrl
                                                    .myProfileDetails
                                                    .value!
                                                    .profileDocumentsWrapperData![
                                                        0]
                                                    .profileDocumentsData!
                                                    .any((doc) =>
                                                        doc.profileDocumentTypeId ==
                                                        12) &&
                                                profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![1].profileDocumentsData!.any((doc) => doc.profileDocumentTypeId == 13) &
                                                    profileCtrl
                                                        .myProfileDetails
                                                        .value!
                                                        .profileDocumentsWrapperData![1]
                                                        .profileDocumentsData!
                                                        .any((doc) => doc.profileDocumentTypeId == 14) &&
                                                profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![2].profileDocumentsData!.any((doc) => doc.profileDocumentTypeId == 15) &&
                                                profileCtrl.myProfileDetails.value!.profileDocumentsWrapperData![3].profileDocumentsData!.any((doc) => doc.profileDocumentTypeId == 17)
                                            ? Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: CustomColors.green),
                                                child: const Icon(
                                                  Icons.check,
                                                  size: 14,
                                                  color: CustomColors.white,
                                                ),
                                              )
                                            : Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        CustomColors.warning),
                                                child: const Icon(
                                                  Icons.error_outline,
                                                  size: 18,
                                                  color: CustomColors.white,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  )),
            ),
            drawer: profileCtrl.myProfileDetails.value!.profileGeneralData
                        ?.userVerificationStatus ==
                    1
                ? CustomDrawer()
                : null,
            body: GetBuilder<ScreenController>(
                init: ScreenController(),
                builder: (screenCtrl) {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: screenCtrl.profileTabController,
                    children: const [
                      ContactDetailsView(),
                      EmployeeDetailsView(),
                      DocumentDetailsView(),
                    ],
                  );
                }),
          );
        });
  }
}
