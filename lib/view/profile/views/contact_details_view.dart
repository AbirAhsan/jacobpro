import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/controller/profile_controller.dart';
import 'package:service/controller/screen_controller.dart';

import '../../../services/image_picker_service.dart';
import '../../variables/text_style.dart';
import '../../widgets/custom_company_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_Image_widget.dart';

class ContactDetailsView extends StatelessWidget {
  const ContactDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        initState: (state) {
          Get.put(ProfileController()).fetchMyProfileDetails();
        },
        builder: (profileCtrl) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: ProfileImageWidget(
                          imageUrl: profileCtrl.myProfileDetails.value!
                                  .profileGeneralData?.userImgRef ??
                              "",
                          radius: 36,
                          isEditable: true,
                          onEdit: () async {
                            await ImagePickService()
                                .getSingleImage(ImageSource.gallery)
                                .then((imagePath) {
                              profileCtrl.uploadUserFile(imagePath, 100);
                            });
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "PERSONAL CONTACT",
                      style: CustomTextStyle.mediumBoldStyleDarkGrey,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: "First Name",
                            prefixIcon: const Icon(Icons.person),
                            controller: profileCtrl.pFirstNameTxtCtrl,
                            onChanged: (value) {
                              profileCtrl.myProfileDetails.value!
                                  .profileGeneralData!.userFirstName = value;
                              profileCtrl.update();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            labelText: "Last Name",
                            prefixIcon: const Icon(Icons.person),
                            controller: profileCtrl.pLastNameTxtCtrl,
                            onChanged: (value) {
                              profileCtrl.myProfileDetails.value!
                                  .profileGeneralData!.userLastName = value;
                              profileCtrl.update();
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      controller: profileCtrl.pEmailTxtCtrl,
                      onChanged: (value) {
                        profileCtrl.myProfileDetails.value!.profileGeneralData!
                            .userMail = value;
                        profileCtrl.update();
                      },
                    ),
                    CustomTextField(
                      labelText: "Phone",
                      prefixIcon: const Icon(Icons.call),
                      controller: profileCtrl.pPhoneTxtCtrl,
                      onChanged: (value) {
                        profileCtrl.myProfileDetails.value!.profileGeneralData!
                            .userContactNo = value;
                        profileCtrl.update();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "EMERGENCY CONTACT",
                      style: CustomTextStyle.mediumBoldStyleDarkGrey,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: "First Name",
                            prefixIcon: const Icon(Icons.person),
                            controller: profileCtrl.eFirstNameTxtCtrl,
                            onChanged: (value) {
                              profileCtrl
                                  .myProfileDetails
                                  .value!
                                  .profileEmergencyContactData!
                                  .emergencyContactFirstName = value;
                              profileCtrl.update();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            labelText: "Last Name",
                            prefixIcon: const Icon(Icons.person),
                            controller: profileCtrl.eLastNameTxtCtrl,
                            onChanged: (value) {
                              profileCtrl
                                  .myProfileDetails
                                  .value!
                                  .profileEmergencyContactData!
                                  .emergencyContactLastName = value;
                              profileCtrl.update();
                            },
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      controller: profileCtrl.eEmailTxtCtrl,
                      onChanged: (value) {
                        profileCtrl
                            .myProfileDetails
                            .value!
                            .profileEmergencyContactData!
                            .emergencyContactMail = value;
                        profileCtrl.update();
                      },
                    ),
                    CustomTextField(
                      labelText: "Phone",
                      prefixIcon: const Icon(Icons.call),
                      controller: profileCtrl.ePhoneTxtCtrl,
                      onChanged: (value) {
                        profileCtrl
                            .myProfileDetails
                            .value!
                            .profileEmergencyContactData!
                            .emergencyContactContactNo = value;
                        profileCtrl.update();
                      },
                    ),
                    GetBuilder<ScreenController>(
                        init: ScreenController(),
                        builder: (screenCtrl) {
                          return Align(
                              alignment: Alignment.bottomRight,
                              child: CustomCompanyButton(
                                  buttonName: "PROCEED",
                                  //  textStyle: CustomTextStyle.mediumBoldStylePrimary,
                                  isFitted: true,
                                  onPressed: () async {
                                    await profileCtrl.updateOwnProfile();
                                    screenCtrl.changeProfileTabbar(1);
                                  }));
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
